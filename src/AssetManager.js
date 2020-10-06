// Asset manager class, for loading data from MTF files
import MTF from './kaitai/mtf.ksy';
import KaitaiStream from 'kaitai-struct/KaitaiStream';

import { win2nixFilename } from './utils';

export default class AssetManager {
  constructor() {
    this.archives = [];
  }

  // Returns the content of 'filename' as ArrayBuffer,
  // or null if file is not found
  getFile(filename) {
    for (let archive of this.archives) {
      let file = archive.fileMap.get(filename);
      if (file) {
        if (file.isCompressed) {
          return this.decompress(file);
        }
        return archive.arrayBuffer.slice(
          file.offset, file.offset + file.size);
      }
    }

    return null;
  }

  // add an archive as source for assets
  addArchive(arrayBuffer, name) {
    // Load and parse the MTF archive
    let mtf = new MTF(new KaitaiStream(arrayBuffer));

    // Got it, now create a Map for fast lookup
    let fileMap = new Map();
    mtf.files.forEach(f => {
      // Convert uppercase windows path to a lowercase *NIX path
      let name = win2nixFilename(f.name.text);
      // and store it in the map
      fileMap.set(name, f);
    })

    // now add the archive to the **start** of the list,
    // so the newest archive is searched first for files.
    this.archives.unshift({
      name,
      arrayBuffer,
      fileMap,
    });
  }

  // Decompresses a file from the archive
  decompress(file) {
    const size = file.compressionHeader.decompressedSize;
    let outBuffer = new ArrayBuffer(size);
    let out = new Uint8Array(outBuffer);
    let outIdx = 0;
  
    let bytesLeft = size;
    let off = 12; // past compression header!
    while (bytesLeft > 0) {
      let chunkBits = file.rawData[off++];
      for (let b = 0; b < 8; b++) {
        let flag = chunkBits & (1 << b);
        if (flag) {
          // Copy single byte
          let byte = file.rawData[off++];
          out[outIdx++] = byte;
          bytesLeft--;
        } else {
          let word = (file.rawData[off+1] << 8) | file.rawData[off];
          off += 2;
          if (word === 0) {
            break;
          }
  
          let count = (word >> 10);
          let offset = (word & 0x03FF);
          // Copy count+3 bytes staring at offset to the end of the decompression buffer,
          // as explained here: http://wiki.xentax.com/index.php?title=Darkstone
          for (let n = 0; n < count + 3; ++n) {
            out[outIdx] = out[outIdx - offset];
            ++outIdx;
            --bytesLeft;
          }
  
          if (bytesLeft < 0) {
            throw `${file.name.text} has a size mismatch on decompression`;
          }
        }
      }
    }
  
    return outBuffer;
  }
};

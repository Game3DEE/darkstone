import CDF from './kaitai/cdf.ksy';
import KaitaiStream from 'kaitai-struct/KaitaiStream';

import { win2nixFilename } from './utils';

import * as THREE from 'three';

// Dimension of block in OGL units
const blockDimension = 512;

export default class RoomFactory {
  constructor(meshFactory) {
    this.meshFactory = meshFactory;
  }

  // Build 3D model of room
  buildRoom(arrayBuffer, filename) {
    // Parse the room data
    const cdf = new CDF(new KaitaiStream(arrayBuffer));

    const centerX = (cdf.maxX - cdf.minX) / 2;
    const centerY = (cdf.maxY - cdf.minY) / 2;

    let room = new THREE.Group();
    room.name = filename;

    // Get all blocks
    cdf.blocks.forEach(block => {
      let mesh = this.meshFactory.getMesh(win2nixFilename(block.path));
      if (mesh) {
        mesh.position.set(
          (block.x - centerX) * blockDimension, 
          0,
          (block.y - centerY) * blockDimension,
        );
        mesh.rotation.y = -(Math.PI / 2) * block.rotation;
        room.add(mesh);
      } else {
        console.error(`${filename} references ${block.path} but block cannot be found!`)
      }
    });

    return room;
  }
}

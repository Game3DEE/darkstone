import O3D from './kaitai/o3d.ksy';
import MBR from './kaitai/mbr.ksy';
import SKA from './kaitai/ska.ksy';

import KaitaiStream from 'kaitai-struct/KaitaiStream';

import {
  BufferGeometry,
  Float32BufferAttribute,
  Group,
  Mesh,
  MeshBasicMaterial,
  Texture,
} from 'three';

import { TGALoader } from './customized/TGALoader';

export default class MeshFactory {
  constructor(assetManager) {
    this.cache = new Map();
    this.assetManager = assetManager;
  }

  clear() {
    this.cache.clear();
  }

  getMesh(filename) {
    let mesh = this.cache.get(filename);
    if (!mesh) {
      let meshData = this.assetManager.getFile(filename);
      if (meshData) {
        mesh = this.createMesh(meshData, filename);
        this.cache.set(filename, mesh);
      }
    }

    if (!mesh) {
      console.error(`Mesh ${filename} could not be loaded!`);
      return null;
    }

    return mesh.clone();
  }

  createModel(mbrBuffer, skaBuffer, filename) {
    let mbr = new MBR(new KaitaiStream(mbrBuffer));
    let ska = new SKA(new KaitaiStream(skaBuffer));

    let group = new Group();
    group.name = filename;
    //group.rotation.y = Math.PI / 4;
    let offset = 0;

    ska.skeletons.forEach(skel => {
      let skelGrp = new Group();
      skelGrp.name = `${skel.name}/${skel.modelName}`;
      skelGrp.position.x = offset;
      offset += 512;

      mbr.subMeshes.forEach(sub => {
        if (skel.bones.indexOf(sub.name) != -1) {
          let mesh = this._createMesh(sub.vertices, sub.faces);
          mesh.position.set(sub.position.x, sub.position.y, -sub.position.z);
          mesh.name = sub.name;
          mesh.userData.type = sub.type;
          skelGrp.add(mesh);
        }
      })

      group.add(skelGrp);
    })

    return group;
  }

  createMesh(arrayBuffer, filename) {
    let model = new O3D(new KaitaiStream(arrayBuffer));
    let mesh = this._createMesh(model.vertices, model.faces)
    mesh.name = filename;
    return mesh;
  }

  _createMesh(vertices, faces) {
    let materials = [];
    let position = [];
    let uv = [];
    let groups = [];
    let texNumber = -1;
    faces.forEach(f => {
      if (texNumber != f.texNumber) {
        if (groups.length) {
          let idx = groups.length - 1;
          groups[idx].count = (position.length / 3) - groups[idx].start;
        }
        groups.push({
          start: position.length / 3,
          materialIndex: materials.length,
        });

        texNumber = f.texNumber;
        // console.log(f.flags);
        let map = this.getTexture(texNumber);
        materials.push(
          new MeshBasicMaterial({ transparent: true, alphaTest: 0.5, map })
        )
      }

      let a = f.indices[0], b = f.indices[2], c = f.indices[1];
      uv.push(
        f.texCoords[0].x / 256, f.texCoords[0].y / 256,
        f.texCoords[2].x / 256, f.texCoords[2].y / 256,
        f.texCoords[1].x / 256, f.texCoords[1].y / 256,
      );
      position.push(
        vertices[a].x, vertices[a].y, -vertices[a].z,
        vertices[b].x, vertices[b].y, -vertices[b].z,
        vertices[c].x, vertices[c].y, -vertices[c].z,
      );

      if (f.indices[3] != 0xffff) {
        let a = f.indices[2], b = f.indices[0], c = f.indices[3];
        uv.push(
          f.texCoords[2].x / 256, f.texCoords[2].y / 256,
          f.texCoords[0].x / 256, f.texCoords[0].y / 256,
          f.texCoords[3].x / 256, f.texCoords[3].y / 256,
        );
        position.push(
          vertices[a].x, vertices[a].y, -vertices[a].z,
          vertices[b].x, vertices[b].y, -vertices[b].z,
          vertices[c].x, vertices[c].y, -vertices[c].z,
        );
      }
    });

    if (groups.length) {
      groups[groups.length - 1].count =
        (position.length / 3) - groups[groups.length - 1].start;
    } else {
      groups.push({
        start: 0,
        count: position.length / 3,
        materialIndex: 0,
      })
    }

    let geo = new BufferGeometry();
    geo.setAttribute('position', new Float32BufferAttribute(position, 3));
    geo.setAttribute('uv', new Float32BufferAttribute(uv, 2));
    groups.forEach(g => geo.addGroup(g.start, g.count, g.materialIndex));
    geo.computeVertexNormals();
    let mesh = new Mesh(geo, materials);
    return mesh;
  }

  getTexture(id) {
    if (this.cache.has(id)) {
      return this.cache.get(id);
    }

    // Create id with leading zeroes
    const num = ('0000'+id).slice(-4);

    // Create full regexp to match filename
    // (being as specific as possible)
    let re = new RegExp(`^data/bankdatabase/dragonblade/.${num}_.*.tga$`);
    let texData = this.assetManager.getFileByRE(re);
    if (texData) {
      // If we got data, create the actual texture (assuming TGA format)
      const loader = new TGALoader();
      const texture = new Texture();
      texture.image = loader.parse(texData);
      texture.needsUpdate = true;
      texture.flipY = false;

      this.cache.set(id, texture);

      return texture;
    }

    return null;
  }
}
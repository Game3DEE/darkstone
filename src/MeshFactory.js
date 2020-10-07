import O3D from './kaitai/o3d.ksy';
import KaitaiStream from 'kaitai-struct/KaitaiStream';

import * as THREE from 'three';

export default class MeshFactory {
  constructor(assetManager) {
    this.cache = new Map();
    this.assetManager = assetManager;
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

    return mesh.clone();
  }

  createMesh(arrayBuffer, filename) {
    let model = new O3D(new KaitaiStream(arrayBuffer));
    let materials = [];
    let position = [];
    let uv = [];
    let groups = [];
    let texNumber = -1;
    model.faces.forEach(f => {
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
        // let map = this.getTexture(texNumber, f.flags === 37 ? 'k' : 'r');
        materials.push(
          new THREE.MeshNormalMaterial()
          //new THREE.MeshLambertMaterial({ map })
        )
      }

      let a = f.indices[0], b = f.indices[2], c = f.indices[1];
      uv.push(
        f.texCoords[0].x / 256, f.texCoords[0].y / 256,
        f.texCoords[2].x / 256, f.texCoords[2].y / 256,
        f.texCoords[1].x / 256, f.texCoords[1].y / 256,
      );
      position.push(
        model.vertices[a].x, model.vertices[a].y, -model.vertices[a].z,
        model.vertices[b].x, model.vertices[b].y, -model.vertices[b].z,
        model.vertices[c].x, model.vertices[c].y, -model.vertices[c].z,
      );

      if (f.indices[3] != 0xffff) {
        let a = f.indices[2], b = f.indices[0], c = f.indices[3];
        uv.push(
          f.texCoords[2].x / 256, f.texCoords[2].y / 256,
          f.texCoords[0].x / 256, f.texCoords[0].y / 256,
          f.texCoords[1].x / 256, f.texCoords[1].y / 256,
        );
        position.push(
          model.vertices[a].x, model.vertices[a].y, -model.vertices[a].z,
          model.vertices[b].x, model.vertices[b].y, -model.vertices[b].z,
          model.vertices[c].x, model.vertices[c].y, -model.vertices[c].z,
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

    let geo = new THREE.BufferGeometry();
    geo.setAttribute('position', new THREE.Float32BufferAttribute(position, 3));
    geo.setAttribute('uv', new THREE.Float32BufferAttribute(uv, 2));
    groups.forEach(g => geo.addGroup(g.start, g.count, g.materialIndex));
    geo.computeVertexNormals();
    let mesh = new THREE.Mesh(geo, materials);
    mesh.name = filename;
    return mesh;
  }
}
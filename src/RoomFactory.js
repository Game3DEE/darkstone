import CDF from './kaitai/cdf.ksy';
import KaitaiStream from 'kaitai-struct/KaitaiStream';

import { win2nixFilename } from './utils';

import {
  BoxGeometry,
  Group,
  Mesh,
  MeshNormalMaterial,
} from 'three';

import { trapTable } from './traps';

// Dimension of block in OGL units
const blockGridSize = 512;
const trapGridSize = blockGridSize / 3;

export default class RoomFactory {
  constructor(meshFactory, monsterFactory) {
    this.meshFactory = meshFactory;
    this.monsterFactory = monsterFactory;
  }

  clear() {
  }

  // Build 3D model of room
  buildRoom(arrayBuffer, filename) {
    // Parse the room data
    const cdf = new CDF(new KaitaiStream(arrayBuffer));

    const offsetX = (cdf.minX + (cdf.maxX - cdf.minX) / 2) * blockGridSize;
    const offsetY = (cdf.minY + (cdf.maxY - cdf.minY) / 2) * blockGridSize;

    let room = new Group();
    room.name = filename;

    // Get all blocks
    cdf.blocks.forEach(block => {
      let mesh = this.meshFactory.getMesh(win2nixFilename(block.path));
      if (mesh) {
        mesh.position.set(
          block.x * blockGridSize - offsetX,
          0,
          block.y * blockGridSize - offsetY,
        );
        mesh.rotation.y = -(Math.PI / 2) * block.rotation;
        room.add(mesh);
      } else {
        console.error(`${filename} references ${block.path} but block cannot be found!`)
      }
    });

    cdf.traps.forEach(trap => {
      if (trap.name.length) {
        console.log(trap.name, trap)
      }
      let trapInfo = trapTable[trap.type];
      if (!trapInfo) {
        console.error(`map ${filename} uses undefined trap ${trap.type}`, trap)
      } else {
        let mesh = null;
        if (!trapInfo.meshes.length) {
          // XX are these waypoints?
          //mesh = new Mesh(new BoxGeometry(10,10,10), new MeshNormalMaterial());
        } else {
          mesh = this.meshFactory.getMesh(trapInfo.meshes[0]);
        }

        if (mesh) {
          mesh.position.set(
            trap.x * trapGridSize - offsetX - trapGridSize,
            0,
            trap.y * trapGridSize - offsetY - trapGridSize,
          )
          mesh.rotation.y = -(Math.PI / 2) * trap.rotation;
          room.add(mesh);
        }
      }
    })

    cdf.monsters.forEach(monster => {
      console.log( this.monsterFactory.getMonsterClass(monster.name) );
    })

    return room;
  }
}

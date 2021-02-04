import MonsterClass from './kaitai/monsterclass.ksy';

import KaitaiStream from 'kaitai-struct/KaitaiStream';

export default class MonsterFactory {
  constructor(assetManager, meshFactory) {
    this.assetManager = assetManager;
    this.meshFactory = meshFactory;    
  }

  reset() {
    let buf = this.assetManager.getFile('data/monsterclass.dat');
    if (buf != null) {
      const parsed = new MonsterClass(new KaitaiStream(buf));
      this.classes = new Map();
      parsed.classes.forEach(cl => {
        this.classes.set(cl.idDsqe.toUpperCase(), cl);
      })
      console.log(this.classes);
    }
  }

  getMonsterClass(name) {
    return this.classes.get(name);
  }
}

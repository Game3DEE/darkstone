import {
  Color,
  Fog,
  PerspectiveCamera,
  Scene,
  WebGLRenderer,
} from 'three';

import Stats from 'stats.js';
import { GUI } from 'dat.gui';

import { OrbitControls } from 'three/examples/jsm/controls/OrbitControls.js';

import AssetManager from './AssetManager';
import MeshFactory from './MeshFactory';
import RoomFactory from './RoomFactory';

const DemoMTFPath = 'assets/ddata.mtf';
const defaultDemoRoom = 'data/cbs/town.cdf';

var container, stats, controls;
var camera, scene, renderer;

var currentRoom = null;

var gui, archivesFolder;

var assetManager = new AssetManager();
var meshFactory = new MeshFactory(assetManager);
var roomFactory = new RoomFactory(meshFactory);

function selectRoom(roomPath) {
  let cdfData = assetManager.getFile(roomPath);
  let room = roomFactory.buildRoom(cdfData, roomPath);
  if (currentRoom) {
    scene.remove(currentRoom);
  }
  currentRoom = room;
  if (currentRoom) {
    scene.add(currentRoom);
  }
}

function addArchive(buffer, name, defaultRoom) {
  // Add archive to asset manager
  let arch = assetManager.addArchive(buffer, name);
  // Add it to our UI
  let settings = {
    room: defaultRoom || '',
  }
  let rooms = [];
  arch.fileMap.forEach( (_, fname) => {
    if (fname.endsWith('.cdf')) {
      rooms.push(fname);
    }
  });
  let af = archivesFolder.addFolder(name);
  af.open();
  af.add(settings, 'room', rooms).onFinishChange(path => {
    selectRoom(path);
  });

  if (defaultRoom) {
    selectRoom(defaultRoom);
  }
}

function init() {

  container = document.createElement('div');
  document.body.appendChild(container);

  // scene

  scene = new Scene();
  scene.background = new Color(0x000000);
  scene.fog = new Fog(0x000000, 500, 10000);

  // camera

  camera = new PerspectiveCamera(30, window.innerWidth / window.innerHeight, 1, 100900);
  camera.position.set(-728, 1695, 4616);

  /*
  // lights

  var light = new SpotLight(0xdfebff, 1);
  light.position.set(50, 200, 100);
  light.position.multiplyScalar(1.3);

  light.castShadow = true;

  light.shadow.mapSize.width = 1024;
  light.shadow.mapSize.height = 1024;

  var d = 300;

  light.shadow.camera.left = - d;
  light.shadow.camera.right = d;
  light.shadow.camera.top = d;
  light.shadow.camera.bottom = - d;

  light.shadow.camera.far = 1000;

  scene.add(light);
  */

  // renderer

  renderer = new WebGLRenderer({ antialias: true });
  renderer.setPixelRatio(window.devicePixelRatio);
  renderer.setSize(window.innerWidth, window.innerHeight);

  container.appendChild(renderer.domElement);

  renderer.shadowMap.enabled = true;

  // controls
  controls = new OrbitControls(camera, renderer.domElement);
  controls.target.set(0, 0, -1000);
  controls.maxPolarAngle = Math.PI * 0.5;
  controls.minDistance = 1000;
  //controls.maxDistance = 5000;

  // performance monitor

  stats = new Stats();
  container.appendChild(stats.dom);

  //

  window.addEventListener('resize', onWindowResize, false);

  //

  let globalSettings = {
    disableFog: false,
  };

  gui = new GUI();
  gui.add(globalSettings, 'disableFog').name('Disable Fog').onChange(v => {
    scene.fog.far = v ? 0 : 10000;
  })
  archivesFolder = gui.addFolder('Archives');
  archivesFolder.open();
  gui.open();

  // Done setting things up, now load the demo data...
  fetch(DemoMTFPath).then(body => body.arrayBuffer()).then(
    buffer => {
      addArchive(buffer, DemoMTFPath, defaultDemoRoom);
    }
  );
}

//

function onWindowResize() {

  camera.aspect = window.innerWidth / window.innerHeight;
  camera.updateProjectionMatrix();

  renderer.setSize(window.innerWidth, window.innerHeight);

}

//

function animate() {

  requestAnimationFrame(animate);

  renderer.render(scene, camera);
  stats.update();
  controls.update();

}

init();
animate();

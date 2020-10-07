import {
  AmbientLight,
  Color,
  DirectionalLight,
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

var container, stats;
var camera, scene, renderer;

var gui, archivesFolder;

var assetManager = new AssetManager();
var meshFactory = new MeshFactory(assetManager);
var roomFactory = new RoomFactory(meshFactory);

const DemoMTFPath = 'assets/ddata.mtf';
const defaultDemoRoom = 'data/cbs/town.cdf';

function init() {

  container = document.createElement('div');
  document.body.appendChild(container);

  // scene

  scene = new Scene();
  scene.background = new Color(0xcce0ff);
  //scene.fog = new Fog(0xcce0ff, 500, 10000);

  // camera

  camera = new PerspectiveCamera(30, window.innerWidth / window.innerHeight, 1, 100900);
  camera.position.set(24800, 3500, 14000);

  // lights

  scene.add(new AmbientLight(0x666666));

  var light = new DirectionalLight(0xdfebff, 1);
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

  // renderer

  renderer = new WebGLRenderer({ antialias: true });
  renderer.setPixelRatio(window.devicePixelRatio);
  renderer.setSize(window.innerWidth, window.innerHeight);

  container.appendChild(renderer.domElement);

  renderer.shadowMap.enabled = true;

  // controls
  var controls = new OrbitControls(camera, renderer.domElement);
  controls.maxPolarAngle = Math.PI * 0.5;
  //controls.minDistance = 1000;
  //controls.maxDistance = 5000;

  // performance monitor

  stats = new Stats();
  container.appendChild(stats.dom);

  //

  window.addEventListener('resize', onWindowResize, false);

  //

  gui = new GUI();
  archivesFolder = gui.addFolder('Archives');
  archivesFolder.open();
  gui.open();

  // Done setting things up, now load the demo data...
  fetch(DemoMTFPath).then(body => body.arrayBuffer()).then(
    buffer => {
      assetManager.addArchive(buffer, DemoMTFPath);

      let cdfData = assetManager.getFile(defaultDemoRoom);
      let room = roomFactory.buildRoom(cdfData, defaultDemoRoom);
      scene.add(room);
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

}

init();
animate();

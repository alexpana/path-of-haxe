import h3d.prim.ModelCache;
import hrt.prefab.Prefab.ContextMake;
import haxe.Log;
import hxd.System;
import hxd.res.Prefab;
import h3d.scene.Mesh;
// Keep prefab imports to ensure they register with the serialization mechanism
import hrt.prefab.Model;

class Main extends hxd.App {
	var wscale = 1.;
	var ui:UI;
	var modelCache:h3d.prim.ModelCache;

	override function init() {
		super.init();

		ui = new UI(s2d);
		modelCache = new h3d.prim.ModelCache();
		hxd.Res.initEmbed();

		var playerModel = modelCache.loadModel(hxd.Res.models.player);
		Log.trace("Player model: " + playerModel.toMesh());

		new Player(s3d);

		var r = new hxd.Rand(Std.random(42));

		var floor = new h3d.prim.Grid(10, 10, 1, 1);
		floor.addNormals();
		floor.translate(-5, -5, 0);
		var m = new h3d.scene.Mesh(floor, s3d);
		m.material.color.makeColor(0.35, 0.5, 0.5);
		m.setScale(wscale);

		// for (i in 0...100) {
		// 	var box:h3d.prim.Polygon = new h3d.prim.Cube(0.3 + r.rand() * 0.5, 0.3 + r.rand() * 0.5, 0.2 + r.rand());
		// 	box.unindex();
		// 	box.addNormals();
		// 	var p = new h3d.scene.Mesh(box, s3d);
		// 	p.setScale(wscale);
		// 	p.x = r.srand(3) * wscale;
		// 	p.y = r.srand(3) * wscale;
		// 	p.material.color.makeColor(r.rand() * 0.3, 0.5, 0.5);
		// }
		s3d.camera.zNear = 0.1 * wscale;
		s3d.camera.zFar = 150 * wscale;
		// new h3d.scene.CameraController(s3d).loadFromCamera();

		cast(s3d.lightSystem, h3d.scene.fwd.LightSystem).ambientLight.set(0.5, 0.5, 0.5);
		var dir = new h3d.scene.fwd.DirLight(new h3d.Vector(-0.3, -0.2, -1), s3d);
		dir.color.set(0.5, 0.5, 0.5);

		ui.addSlider("Scale", function() return wscale, function(v) wscale = v, 1, 10.0);
		onResize();
	}

	function reset() {
		while (s3d.numChildren > 0) {
			s3d.getChildAt(0).remove();
		}
		s3d.dispose();
		init();
	}

	override function update(dt:Float) {
		s2d.setScale(wscale);
	}

	static function main() {
		new Main();
	}
}

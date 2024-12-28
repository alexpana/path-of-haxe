import h3d.Vector;
import h3d.scene.Scene;
import haxe.Log;
import h3d.scene.Object;
import h3d.Camera;
import h3d.scene.Mesh;
import h3d.scene.RenderContext;
import hxd.Key;
import Math;

class Player extends Object {
	var mesh:Mesh;
	var camera:Camera;
	var scene:Scene;
	var maxSpeed:Float = 10;
	var speed:Float = 0.0;

	var acceleration:Float = 10;

	var direction = new Vector();

	var camerPos = new Object();

	public function new(parent:h3d.scene.Scene) {
		super(parent);

		var prefab = hxd.Res.scenes.Main.load();
		var unk = prefab.getOpt(hrt.prefab.Unknown);
		if (unk != null)
			Log.trace("Prefab " + unk.type + " was not compiled");

		var object3d = prefab.make(this);

		this.mesh = cast(cast(object3d.children[0], hrt.prefab.Model).local3d.children[0], Mesh);
		this.camera = parent.camera;

		mesh.material.castShadows = false;

		camerPos.setPosition(0, -10, 60);
		addChild(camerPos);
		this.camera.follow = {pos: camerPos, target: this};
	}

	override function sync(ctx:RenderContext) {
		var camdist = 50;
		var time = Math.PI * 0.25;
		// mesh.z = Math.sin(ctx.time);

		direction.set(0, 0, 0);

		if (Key.isDown(Key.W)) {
			direction.y += 1;
		}
		if (Key.isDown(Key.S)) {
			direction.y -= 1;
		}
		if (Key.isDown(Key.A)) {
			direction.x += 1;
		}
		if (Key.isDown(Key.D)) {
			direction.x -= 1;
		}

		if (Key.isPressed(Key.SPACE)) {
			fire();
		}

		if (direction.lengthSq() > 0.0) {
			speed = Math.min(speed + acceleration * ctx.elapsedTime, maxSpeed);
		} else {
			speed = Math.max(speed - acceleration * ctx.elapsedTime, 0);
		}

		setPosition(x + direction.x * speed * ctx.elapsedTime, y + direction.y * speed * ctx.elapsedTime, 0);
		camera.update();
	}

	function fire() {
		// TODO: cache / pool bullets
		var bullet = new Bullet(getScene(), Meshes.getMesh(hxd.Res.models.bullet));
		bullet.setPosition(mesh.x, mesh.y, mesh.z);
	}
}

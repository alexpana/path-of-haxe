import h3d.Vector;
import h3d.scene.RenderContext;
import h3d.scene.Object;
import h3d.scene.Mesh;

class Bullet extends Object {
	var speed:Float = 10;
	var direction:Vector = new Vector(1, 1, 0).normalized();
	var mesh:Mesh;

	public function new(parent:h3d.scene.Object, mesh:h3d.scene.Mesh) {
		super(parent);
		mesh.setScale(10);
		this.mesh = mesh;
		this.setDirection(direction);
		this.addChild(mesh);
	}

	override function sync(ctx:RenderContext) {
		setPosition(x
			+ direction.x * speed * ctx.elapsedTime, y
			+ direction.y * speed * ctx.elapsedTime, z
			+ direction.z * speed * ctx.elapsedTime);
		syncPos();
	}
}

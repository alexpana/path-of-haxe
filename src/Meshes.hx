class Meshes {
	private static var cache = new h3d.prim.ModelCache();

	public static function getMesh(model:hxd.res.Model):h3d.scene.Mesh {
		return cache.loadModel(model).toMesh();
	}
}

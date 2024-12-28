class Scene {
	public function new() {}
}

class Test {
	var s:Scene;

	public function new(?a, ?c, ?b, ?d) {
		s = b;
		init(a);
		init(c);
		init(d);
	}

	function init(x:Int) {}
}

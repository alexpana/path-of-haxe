class UI {
	var fui:h2d.Flow;
	var scale:Float;

	public function new(scene:h2d.Scene) {
		fui = new h2d.Flow(scene);
		fui.layout = Vertical;
		fui.verticalSpacing = 5;
		fui.padding = 10;
	}

	function getFont() {
		return hxd.res.DefaultFont.get();
	}

	public function addSlider(label:String, get:Void->Float, set:Float->Void, min:Float = 0., max:Float = 1.) {
		var f = new h2d.Flow(fui);

		f.horizontalSpacing = 5;

		var tf = new h2d.Text(getFont(), f);
		tf.text = label;
		tf.maxWidth = 70;
		tf.textAlign = Right;

		var sli = new h2d.Slider(100, 10, f);
		sli.minValue = min;
		sli.maxValue = max;
		sli.value = get();

		var tf = new h2d.TextInput(getFont(), f);
		tf.text = "" + hxd.Math.fmt(sli.value);
		sli.onChange = function() {
			set(sli.value);
			tf.text = "" + hxd.Math.fmt(sli.value);
			f.needReflow = true;
		};
		tf.onChange = function() {
			var v = Std.parseFloat(tf.text);
			if (Math.isNaN(v))
				return;
			sli.value = v;
			set(v);
		};
		return sli;
	}
}

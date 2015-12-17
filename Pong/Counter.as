package  {

	import flash.display.MovieClip;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;


	public class Counter extends MovieClip {

		// Store initial Value
		private var _initialValue:String;


		public function Counter(xC:Number, yC:Number, initial:String, wdth:Number) {

			this.x = xC;
			this.y = yC;
			this.counter.text = initial;
			this.counter.width = wdth;

			this.initialValue = initial;

			var fmt:TextFormat = new TextFormat();
			fmt.align = TextFormatAlign.CENTER;

			this.counter.selectable = false;
			this.counter.defaultTextFormat = fmt;

		}

		// Get initial Value
		public function get initialValue():String{
			return this._initialValue;
		}

		// Set initial Value
		public function set initialValue(v:String):void{
			this._initialValue = v;
		}

		// Reset
		public function resetText():void{
			this.counter.text = this.initialValue;
		}

		// Set text again
		public function setText(txt:String):void{
			this.counter.text = txt;
		}

	}

}

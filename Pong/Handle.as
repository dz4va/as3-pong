package  {

	import flash.display.MovieClip;


	public class Handle extends MovieClip {

		// Velocity
		private var _velocity:Number = 20;
		private var _startX:Number;
		private var _startY:Number;
		public var maxSpeed = 30;

		public function Handle(xC:Number, yC:Number) {
			this.y = yC;
			this.x = xC;


			// Make a copy
			this.startX = xC;
			this.startY = yC;
		}

		// Get startX
		public function get startX():Number{
			return this._startX;
		}

		// Set startX
		public function set startX(x:Number):void{
			this._startX = x;
		}

		// Get startY
		public function get startY():Number{
			return this._startY;
		}

		// Set startY
		public function set startY(y:Number):void{
			this._startY = y;
		}

		// Get velocity
		public function get velocity():Number{
			return this._velocity;
		}

		// Set velocity
		public function set velocity(newVelocity:Number):void{
			this._velocity = newVelocity;
		}

		// Log position and velocity
		public function log():void{
			trace("Position: [" + this.x + "," + this.y + "], Velocity: " + this.velocity);
		}

		// Move handle up
		public function moveUp():void{
			this.y -= this.velocity;
			this.accelerate();
		}

		// Move handle down
		public function moveDown():void{
			this.y += this.velocity;
			this.accelerate();
		}

		public function accelerate():void{
			if ((this.velocity > this.maxSpeed - 1 && this.velocity < this.maxSpeed) || this.velocity > this.maxSpeed){
				this.velocity = this.maxSpeed;
			}else{
				this.velocity *= 1.2;
			}
		}

		// Reset position
		public function resetPos():void{
			this.x = this.startX;
			this.y = this.startY;
		}

		// Reset velocity
		public function resetVelocity():void{
			this.velocity = 4;
		}

	}

}

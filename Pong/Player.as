package  {
	import flash.ui.Keyboard;

	public class Player {

		// Player Score
		private var _score:uint;
		// Score Counter
		public var scoreCounter:Counter;
		// Handle
		public var handle:Handle;
		// Score Limit Per game

		public function Player() {
			this.score = 0;
		}

		// Get Score
		public function get score():uint{
			return this._score;
		}

		// Set Score
		public function set score(n:uint){
			this._score = n;
		}

	}

}

package  {

	import flash.display.MovieClip;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import flash.events.MouseEvent;
	import flash.system.fscommand;


	public class Pong extends MovieClip {

		public var player1:Player;
		public var player2:Player;

		public var pongSounds:PongSoundPlayer;

		public var player1Scored:Boolean;
		public var player2Scored:Boolean;

		public var ball:Ball;

		private var _maxMatchLimit:uint = 10;

		public var keys:Dictionary;

		public function Pong() {

			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.stage.align = StageAlign.TOP_LEFT;

			// [1] Step
			this.initializeComponents();

			// [3] Step
			this.addChildren();

			// [4] Step
			this.addEvents();

			this.pongSounds.playBG();

			// Play Game
			this.stage.addEventListener(Event.ENTER_FRAME, this.playPong);


		}


		public function initializeComponents():void{

			// Player 1
			this.player1 = new Player();
			this.player1.scoreCounter = new Counter(45, 10, "0", (this.stage.stageWidth / 2.0) - 105);
			this.player1.handle = new Handle(30, this.stage.stageHeight / 2.0);

			// Player 2
			this.player2 = new Player();
			this.player2.scoreCounter = new Counter(this.stage.stageWidth / 2.0 + 60, 10, "0", (this.stage.stageWidth / 2.0) - 105);
			this.player2.handle = new Handle(this.stage.stageWidth - 20, this.stage.stageHeight / 2.0);

			// Ball
			this.ball = new Ball(this.stage.stageWidth / 2.0, this.stage.stageHeight / 2.0);
			this.ball.shouldMove = true;

			// Keys
			this.keys = new Dictionary();

			// Sounds
			this.pongSounds = new PongSoundPlayer();
		}

		public function addEvents():void{
			this.stage.addEventListener(KeyboardEvent.KEY_DOWN, this.onDown);
			this.stage.addEventListener(KeyboardEvent.KEY_UP, this.onUp);
		}

		public function addChildren():void{
			this.addChild(this.player1.scoreCounter);
			this.addChild(this.player1.handle);
			this.addChild(this.player2.scoreCounter);
			this.addChild(this.player2.handle);
			this.addChild(this.ball);
		}

		public function playPong(e:Event):void{

			this.interact();

			this.ball.addX();
			this.ball.addY();

			this.boundBall();

			this.checkWon();

		}

		// Check ball bounds
		public function boundBall():void{
			// Going bottom
			if ((this.ball.y + 14) >= this.stage.stageHeight){
				this.ball.flipY();
				this.pongSounds.playTopBot();
			}

			// Going top
			if ((this.ball.y - 14) <= 0){
				this.ball.flipY();
				this.pongSounds.playTopBot();
			}

			// Going left
			if (((this.ball.x - 14) <= (this.player1.handle.x + 10)) &&
				((this.ball.y <= this.player1.handle.y + 60) && (this.ball.y >= this.player1.handle.y - 60))){

				this.pongSounds.playLeftRight();
				this.ball.x = this.player1.handle.x + 24;
				this.ball.flipX();

			}
			else if ((this.ball.x - 14) <= 0){
				this.pongSounds.playOOB();
				this.stopBall();
				this.player1.handle.resetPos();
				this.player2.handle.resetPos();
				this.player2Scored = true;
				this.player1Scored = false;
				this.stage.addEventListener(MouseEvent.CLICK, goOn);
			}

			// Going right
			if (((this.ball.x + 14) >= (this.player2.handle.x - 10)) &&
				((this.ball.y <= this.player2.handle.y + 60) && (this.ball.y >= this.player2.handle.y - 60))){

				this.pongSounds.playLeftRight();
				this.ball.x = this.player2.handle.x - 24;
				this.ball.flipX();

			}
			else if ((this.ball.x + 14) >= this.stage.stageWidth){
				this.pongSounds.playOOB();
				this.stopBall();
				this.player1.handle.resetPos();
				this.player2.handle.resetPos();
				this.player1Scored = true;
				this.player2Scored = false;
				this.stage.addEventListener(MouseEvent.CLICK, goOn);
			}


		}

		// Check if won
		public function checkWon():void{
			if (player1.score >= this.matchLimit){
				this.pongSounds.playWin();
				trace("Player1 Won!");
				resetGame();
				return;
			}

			if (player2.score >= this.matchLimit){
				this.pongSounds.playWin();
				trace("Player2 Won!");
				resetGame();
				return;
			}

			if (player1Scored){
				this.player1.score += 1;
				trace(player1.score);
				this.player1.scoreCounter.setText(this.player1.score.toString());
				this.player1Scored = false;
				this.player2Scored = false;
			}

			if (player2Scored){
				this.player2.score += 1;
				trace(player2.score);
				this.player2.scoreCounter.setText(this.player2.score.toString());
				this.player1Scored = false;
				this.player2Scored = false;
			}

		}

		// Let ball go again
		public function goOn(e:MouseEvent):void{
			this.stage.removeEventListener(MouseEvent.CLICK, goOn);
			this.ball.shouldMove = true;
		}

		// Stop and reset ball
		public function stopBall():void{
			this.ball.shouldMove = false;
			this.ball.resetPos();
		}

		// Reset game
		public function resetGame():void{
			this.player1.handle.resetPos();
			this.player1.scoreCounter.resetText();
			this.player1.score = 0;

			this.player2.handle.resetPos();
			this.player2.scoreCounter.resetText();
			this.player2.score = 0;

			this.ball.resetPos();

			this.player1Scored = false;
			this.player2Scored = false;
		}

		// Interactions
		public function interact():void{
			if (this.keys[Keyboard.W]){
				if (this.player1.handle.y - 60 <= 10){
					this.player1.handle.y = 70;
				}else{
					this.player1.handle.moveUp();
				}
			}

			if (this.keys[Keyboard.S]){
				if (this.player1.handle.y + 60 >= this.stage.stageHeight - 10){
					this.player1.handle.y = this.stage.stageHeight - 70;
				}else{
					this.player1.handle.moveDown();
				}
			}

			if (this.keys[Keyboard.UP]){
				if (this.player2.handle.y - 60 <= 10){
					this.player2.handle.y = 70;
				}else{
					this.player2.handle.moveUp();
				}
			}

			if (this.keys[Keyboard.DOWN]){
				if (this.player2.handle.y + 60 >= this.stage.stageHeight - 10){
					this.player2.handle.y = this.stage.stageHeight - 70;
				}else{
					this.player2.handle.moveDown();
				}
			}
		}

		// Event Methods
		public function onDown(e:KeyboardEvent):void{

			if (!(e.keyCode in this.keys)){
				this.keys[e.keyCode] = true;
			}

		}

		function onUp(e:KeyboardEvent):void {
			this.player1.handle.resetVelocity();
			this.player2.handle.resetVelocity();
			delete this.keys[e.keyCode];
		}

		// Get Match Limit
		public function get matchLimit():uint{
			return this._maxMatchLimit;
		}
	}

}

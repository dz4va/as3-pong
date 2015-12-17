package  {
	import flash.media.Sound;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;

	public class PongSoundPlayer {

		private var _collisionTopBottom:Sound;		// Done
		private var _collisionLeftRright:Sound;		// Done
		private var _win:Sound;						// Done
		private var _outOfBound:Sound;				// Done
		private var _background:Sound;				// Done

		private var _collisionTopBottomReady:Boolean;
		private var _collisionLeftRightReady:Boolean;
		private var _winReady:Boolean;
		private var _outOfBoundReady:Boolean;
		private var _backgroundReady:Boolean;

		public function PongSoundPlayer() {

			this._collisionTopBottom = new Sound();
			this._collisionLeftRright = new Sound();
			this._win = new Sound();
			this._outOfBound = new Sound();
			this._background = new Sound();

			this.addEvents();
			this.loadSounds();

		}

		// Play methods
		public function playTopBot():void{
			//var volumeAdjust:SoundTransform = new SoundTransform();
			//volumeAdjust.volume = .6;
			//this._collisionTopBottom.play();
		}

		public function playLeftRight():void{
			//var volumeAdjust:SoundTransform = new SoundTransform();
			//volumeAdjust.volume = .6;
			//this._collisionLeftRright.play();
		}

		public function playWin():void{
			this._win.play();
		}

		public function playOOB():void{
			this._outOfBound.play();
		}

		public function playBG():void{
			var myChannel:SoundChannel = new SoundChannel();
			myChannel = this._background.play(100);

		}

		// If all are ready
		public function soundsReady():Boolean{
			if (this._collisionTopBottomReady &&
				this._collisionLeftRright &&
				this._winReady &&
			    this._outOfBoundReady &&
				this._backgroundReady)
			{
				return true;
			}else{
				return false;
			}
		}

		// Load Sounds
		public function loadSounds():void{
			this._collisionTopBottom.load(new URLRequest("music/collision-top-bottom.mp3"));
			this._collisionLeftRright.load(new URLRequest("music/collision-left-right.mp3"));
			this._win.load(new URLRequest("music/win.mp3"));
			this._outOfBound.load(new URLRequest("music/out-of-bounds.mp3"));
			this._background.load(new URLRequest("music/background.mp3"));
		}

		// Add Events
		public function addEvents():void{
			// Top Bottom
			this._collisionTopBottom.addEventListener(Event.COMPLETE, tb_loaded);
			this._collisionTopBottom.addEventListener(IOErrorEvent.IO_ERROR, tb_error);

			// Left Right
			this._collisionLeftRright.addEventListener(Event.COMPLETE, lr_loaded);
			this._collisionLeftRright.addEventListener(IOErrorEvent.IO_ERROR, lr_error);

			// Win
			this._win.addEventListener(Event.COMPLETE, win_loaded);
			this._win.addEventListener(IOErrorEvent.IO_ERROR, win_error);

			// Out of bounds
			this._outOfBound.addEventListener(Event.COMPLETE, oob_loaded);
			this._outOfBound.addEventListener(IOErrorEvent.IO_ERROR, oob_error);

			// Background
			this._background.addEventListener(Event.COMPLETE, bg_loaded);
			this._background.addEventListener(IOErrorEvent.IO_ERROR, bg_error);

		}

		// Top Bottom
		private function tb_loaded(e:Event):void{
		   this._collisionTopBottomReady = true;
		}

		private function tb_error(e:IOErrorEvent):void{
		   trace(e.text);
		}

		// Left Right
		private function lr_loaded(e:Event):void{
			this._collisionLeftRightReady = true;
		}

		private function lr_error(e:IOErrorEvent):void{
		   trace(e.text);
		}

		// Win
		private function win_loaded(e:Event):void{
			this._winReady = true;
		}

		private function win_error(e:IOErrorEvent):void{
		   trace(e.text);
		}

		// Out of bounds
		private function oob_loaded(e:Event):void{
			this._outOfBoundReady = true;
		}

		private function oob_error(e:IOErrorEvent):void{
		   trace(e.text);
		}

		// Bg
		private function bg_loaded(e:Event):void{
			this._backgroundReady = true;
		}

		private function bg_error(e:IOErrorEvent):void{
		   trace(e.text);
		}
	}

}

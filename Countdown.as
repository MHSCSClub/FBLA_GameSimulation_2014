package  {
	
	import API.*;
	import flash.events.Event;
	
	public class Countdown extends Environment {
		private var _minutes:int;
		private var _seconds:int;
		private var _frames:int = 0;
		
		public function Countdown() {
			this.eventFrameBind = true;
			_minutes = parseInt(this.text_min.text, 10);
			_seconds = parseInt(this.text_sec.text, 10);
		}
		public function construct(): void {
			this.addEventListener(Event.ENTER_FRAME, this.bindEnterFrame);
		}
		public function destruct(): void {
			this.removeEventListener(Event.ENTER_FRAME, this.bindEnterFrame);
		}
		public function bindEnterFrame(evt:Event): void {
			++_frames;
			if(_frames == 30) {
				updateTimer();
				_frames = 0;
			}
		}
		private function updateTimer(): void {
			if(_seconds == 0 && _minutes == 0) {
				this.removeEventListener(Event.ENTER_FRAME, this.bindEnterFrame);
				dispatchEvent(new Event("NO_TIME"));
				return;
			}
			--_seconds;
			if(_seconds == -1) {
				_seconds = 59;
				--_minutes;
			}
			this.text_min.text = String(_minutes);
			if(_seconds >= 10)
				this.text_sec.text = String(_seconds);
			else
				this.text_sec.text = "0" + String(_seconds);
		}
		override public function scroll_obj(movex:Number, movey:Number): void { }
	}
	
}
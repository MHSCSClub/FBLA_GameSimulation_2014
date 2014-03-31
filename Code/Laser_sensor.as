package  {
	
	import API.*;
	import flash.events.*;
	
	public class Laser_sensor extends Sensor {
		
		private var _damage:int = 5;
		private var _current_wait:int = 0;
		
		public var wait:int = 60;
		
		public var _on:Boolean = true;
		
		public function Laser_sensor() {
			this.visible = true;
			this.eventFrameBind = true;
		}
		public function bindEnterFrame(evt:Event): void {
			if(!_on) {
				++_current_wait;
				if(_current_wait % wait == 0) {
					_current_wait = 0;
					this.gotoAndPlay(13);
					_on = true;
					_damage = 5;
					
				}					
			}else{
				++_current_wait
				if(_current_wait % wait == 0) {
					this.gotoAndPlay(1);
					_on = false;
					_damage = 0;
					_current_wait = 0;
				}			
			}
		}
		

		
		override public function create_event(ett:Entity): void {
			ett.health -= _damage;
		}
		
		public function pause(evt:Event): void {
			this.removeEventListener(Event.ENTER_FRAME, this.bindEnterFrame);
		}
		public function unpause(evt:Event): void {
			this.addEventListener(Event.ENTER_FRAME, this.bindEnterFrame);
		}
		public function construct(): void {
			this.addEventListener(Event.ENTER_FRAME, this.bindEnterFrame);
			stage.addEventListener("PAUSE", this.pause, true);
			stage.addEventListener("UNPAUSE", this.unpause, true);

		}
		public function destruct(): void {
			this.addEventListener(Event.ENTER_FRAME, this.bindEnterFrame);
			stage.addEventListener("PAUSE", this.pause, true);
			stage.addEventListener("UNPAUSE", this.unpause, true);

		}
	}
	
}

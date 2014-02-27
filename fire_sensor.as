package  {
	
	import API.*;
	import flash.events.*;
	
	public class fire_sensor extends Sensor {
		
		private var _on:Boolean = true;
		private var _damage:int = 5;
		private var _current_wait:int = 0;
		
		public var _wait:int = 150;
		
		public function fire_sensor() {
			this.visible = true;
			this.eventFrameBind = true;
		}
		public function bindEnterFrame(evt:Event): void {
			if(!_on) {
				++_current_wait;
				if(_current_wait == _wait) {
					turnon();
					_current_wait = 0;
				}				
			}
		}
		
		private function turnoff(evt:Event): void {
			this.visible = false;
			_on = false;
			_damage = 0;
		}
		private function turnon(): void {
			this.visible = true;
			_on = true;
			_damage = 5;
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
			stage.addEventListener(EntityEvent.APPEAR + "fire", turnoff, true);
		}
		public function destruct(): void {
			this.addEventListener(Event.ENTER_FRAME, this.bindEnterFrame);
			stage.addEventListener("PAUSE", this.pause, true);
			stage.addEventListener("UNPAUSE", this.unpause, true);
			stage.removeEventListener(EntityEvent.APPEAR + "fire", turnoff, true);
		}
	}
	
}

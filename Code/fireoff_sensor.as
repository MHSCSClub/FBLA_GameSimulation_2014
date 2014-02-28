package  {
	
	import API.*;
	import flash.events.*;
	
	public class fireoff_sensor extends Sensor {
		
		private var _state:Boolean = true;

		public function fireoff_sensor() { 
			this.visible = true;
			this.eventFrameBind = true;
		}
		
		override public function create_event(ett:Entity): void {
			if(ett is Player && _state) {
				dispatchEvent(new EntityEvent(EntityEvent.APPEAR + "fire", ""));
				this.gotoAndPlay(2);
				_state = false;
			}
		}
		private function toggle_state(evt:Event): void {
			_state = true;
			this.gotoAndPlay(1);
		}
		
		public function construct(): void {
			stage.addEventListener(EntityEvent.APPEAR + "done", toggle_state, true);
		}
		public function destruct(): void {
			stage.removeEventListener(EntityEvent.APPEAR + "done", toggle_state, true);
		}
	}
	
}

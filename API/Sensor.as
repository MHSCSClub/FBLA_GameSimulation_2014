/*
	Passing events when collided with
*/
package API {
	
	import API.*;
	import flash.events.Event;
	
	public class Sensor extends Environment{

		public function Sensor() {
			this.fallThroughEnabled = true;
			this.jumpThroughEnabled = true;
			this.moveThroughEnabled = true;
			this.visible = false;
			this.eventFrameBind = true;
		}
		public function bindEnterFrame(evt:Event): void {
			if(player_spawner.playerConstructed) {
				if(this.hitTestObject(Entity.envObj[Player.p_sig])) {
					create_event();
				}
			}
		}
		public function create_event(): void {
			
		}
		public function construct() {
			this.addEventListener(Event.ENTER_FRAME, this.bindEnterFrame);
		}
		public function destruct() {
			this.removeEventListener(Event.ENTER_FRAME, this.bindEnterFrame);
		}
		
	}
	
}

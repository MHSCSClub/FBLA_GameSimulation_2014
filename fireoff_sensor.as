package  {
	
	import API.*;
	import flash.events.*;
	
	public class fireoff_sensor extends Sensor {

		public function fireoff_sensor() { 
				this.visible = true;
		}
		
		override public function create_event(ett:Entity): void {
			if(ett is Player) {
				dispatchEvent(new EntityEvent(EntityEvent.APPEAR + "fire", ""));
			}
		}
	}
	
}

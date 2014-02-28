package  {
	
	import API.*;
	
	public class spike_sensor extends Sensor {
		
		public function spike_sensor() {
			this.fallThroughEnabled = false;
			this.visible = true;
		}
		override public function create_event(ett:Entity): void {
			ett.health -= 5;
		}
	}
	
}

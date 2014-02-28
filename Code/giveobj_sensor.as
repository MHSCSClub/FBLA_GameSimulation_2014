package  {
	
	import API.*;
	
	
	public class giveobj_sensor extends Sensor {
		
		public function giveobj_sensor() { 
			this.visible = true;
		}
		override public function create_event(ett:Entity): void {
			if(ett is Player) {
				Player.possess_obj = true;
				this.visible = false;
			}
		}
	}
	
}

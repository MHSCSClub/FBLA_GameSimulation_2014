package  {
	
	import API.*;
	
	
	public class giveobj_sensor extends Sensor {
		var _gave = false;
		
		public function giveobj_sensor() { 
			this.visible = true;
		}
		override public function create_event(ett:Entity): void {
			if(ett is Player && !_gave && !Player.negotiation_skill) {
				++Player.smile_count;
				_gave = true;
				this.visible = false;
			}
		}
	}
	
}

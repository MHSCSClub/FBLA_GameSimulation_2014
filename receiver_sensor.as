package  {
	
	import API.*;
	
	public class receiver_sensor extends Sensor{
		
		public function receiver_sensor() {
			this.visible = true;
		}
		override public function create_event(ett:Entity): void {
			if(ett is Player && Player.possess_obj) {
				Player.negotiation_skill_count++;
				this.visible = false;
			}
		}
	}
	
}

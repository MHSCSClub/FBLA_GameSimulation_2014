package  {
	
	import API.*;
	
	public class receiver_sensor extends Sensor{
		
		private var _gave:Boolean = false;
		
		public function receiver_sensor() {
			this.visible = true;
		}
		override public function create_event(ett:Entity): void {
			if(ett is Player && Player.possess_obj && !_gave) {
				Player.negotiation_skill_count++;
				this.visible = false;
				_gave = true;
			}
		}
	}
	
}

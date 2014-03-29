package  {
	
	import API.*;
	
	public class receiver_sensor extends Sensor{
		
		private var _gave:Boolean = false;
		
		public function receiver_sensor() {
			this.visible = true;
		}
		override public function create_event(ett:Entity): void {
			if(ett is Player && Player.smile_count > 0 && !_gave) {
				Player.negotiation_skill = true;
				this.gotoAndPlay(2);
				_gave = true;
			}
		}
	}
	
}

package  {
	
	import API.*;
	
	public class fdestination_sensor extends Sensor{
		
		private var _gave:Boolean = false;

		public function fdestination_sensor() {
			this.visible = true;
		}
		
		override public function create_event(ett:Entity): void {
			if(ett is Follower && !_gave) {
				++Player.leadership_skill_count;
				dispatchEvent(new EntityEvent(EntityEvent.HITSENSOR + "REACHEDDEST", "REACHEDDEST"));
				_gave = true;
			}
		}

	}
	
}

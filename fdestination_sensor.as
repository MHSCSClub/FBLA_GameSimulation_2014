package  {
	
	import API.*;
	
	public class fdestination_sensor extends Sensor{

		public function fdestination_sensor() {
			this.visible = true;
		}
		
		override public function create_event(ett:Entity): void {
			if(ett is Follower) {
				++Player.leadership_skill_count;
				dispatchEvent(new EntityEvent(EntityEvent.HITSENSOR + "REACHEDDEST", "REACHEDDEST"));
			}
		}

	}
	
}

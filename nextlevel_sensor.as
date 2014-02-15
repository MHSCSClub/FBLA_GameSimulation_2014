package  {
	
	import API.*;
	import flash.events.Event;
	
	public class nextlevel_sensor extends Sensor{
		
		public var _gave:Boolean = false;

		public function nextlevel_sensor() { 
			this.visible = true;
		}
		
		override public function create_event(ett:Entity): void {
			if(Player.leadership_skill_count < 1)
				return;
			if(Player.negotiation_skill_count < 1)
				return;
			if(Player.people_skill_count < 3)
				return
			if(ett is Player && !_gave){
				dispatchEvent(new Event("LEVEL_DONE"));
				_gave = true;
			}
		}
		
	}
	
}

package  {
	
	import API.*;
	import flash.events.Event;
	
	public class nextlevel_sensor extends Sensor{

		public function nextlevel_sensor() { }
		
		override public function create_event(ett:Entity): void {
			if(Player.leadership_skill_count != 1)
				return;
			if(ett is Player){
				dispatchEvent(new Event("NEXT_LEVEL"));
			}
		}
		
	}
	
}

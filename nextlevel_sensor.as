package  {
	
	import API.*;
	import flash.events.Event;
	
	public class nextlevel_sensor extends Sensor{
		
		private var _gave:Boolean = false;
		
		public static var leadership_requirements:int = 0;
		public static var negotiation_requirements:int = 0;
		public static var people_skill_requirements:int = 0;
		

		public function nextlevel_sensor() { 
			this.visible = true;
		}
		
		override public function create_event(ett:Entity): void {
			if(Player.leadership_skill_count < leadership_requirements)
				return;
			if(Player.negotiation_skill_count < negotiation_requirements)
				return;
			if(Player.people_skill_count < people_skill_requirements)
				return
			if(ett is Player && !_gave){
				this.gotoAndPlay(2);
				_gave = true;
			}
		}
		
	}
	
}

package  {
	
	import API.*;
	import flash.events.Event;
	
	public class nextlevel_sensor extends Sensor{

		public function nextlevel_sensor() { }
		
		override public function create_event(): void {
			dispatchEvent(new Event("NEXT_LEVEL"));
		}
		
	}
	
}

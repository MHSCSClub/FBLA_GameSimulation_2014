package  {
	
	import API.*;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class guide_sensor extends Sensor {
		
		private var _gave:Boolean = false;
		private var _guide;
		
		public static var box_text:String = "";

		public function guide_sensor() { 
			this.visible = true;
		}
		
		override public function create_event(ett:Entity): void {
			if(ett is Player && !_gave) {
				dispatchEvent(new Event("PAUSE"));
				stage.addEventListener(EntityEvent.BUTTONPRESS + "g", bindButtonPress, true);
				_guide = new guide_frame();
				_guide.x = (stage.stageWidth - _guide.width) / 2;
				_guide.y = (500 - _guide.height) / 2;
				_guide.tbox.text = box_text;
				stage.addChild(_guide);
				_gave = true;
			}
		}
		private function bindButtonPress(eevt:EntityEvent): void {
			stage.removeChild(_guide);
			dispatchEvent(new Event("UNPAUSE"));
			this.stage.focus = (root as MovieClip);
			stage.removeEventListener(EntityEvent.BUTTONPRESS + "g", bindButtonPress, true);
		}
	}
	
}

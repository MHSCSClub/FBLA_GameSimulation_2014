package  {
	
	import API.*;
	import flash.events.Event;
	
	public class HighFive extends Entity{
		
		private var giveFive:Boolean = false;

		public function HighFive(nx:Number, ny:Number, sig:int) {
			super(nx, ny, sig);
			this.g_testpoint.push(0);
		}
		public function bindEnterFrame(evt:Event): void {
			super.entity_update();
		}
		override public function x_setVariables(ett:Entity): void {
			if(!giveFive){
				(ett as Player).people_skill_count++;
				giveFive = true;
			}
		}

	}
	
}

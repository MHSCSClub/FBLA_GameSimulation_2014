package  {
	
	import API.*;
	import flash.events.Event;
	import flash.display.Shape;
	
	public class HighFive extends Entity{
		
		private var giveFive:Boolean = false;

		public function HighFive(nx:Number, ny:Number, sig:int) {
			super(nx, ny, sig);
			this.g_testpoint.push(0);
			this.fallThroughEnabled = true;
		}
		override public function bindEnterFrame(evt:Event): void {
			super.entity_update();
		}
		override public function g_collid_hit_test(c_obj:Environment, ln:Shape): Boolean {
			return c_obj.hitTestObject(ln) && !(c_obj is Player);
		}
		override public function x_setVariables(ett:Entity): void {
			if(!giveFive){
				++Player.people_skill_count;
				giveFive = true;
				this.gotoAndStop(2);
			}
		}

	}
	
}

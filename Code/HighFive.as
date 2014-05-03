package  {
	
	import API.*;
	import flash.events.Event;
	import flash.display.Shape;
	import flash.display.MovieClip;
	
	public class HighFive extends Entity{
		
		private var giveFive:Boolean = false;
		private var _sig:int;
		
		public static var sayingsList1:Array;
		public static var sayingsList2:Array;
		public var choice:int = 0;
		
		public var num:int = 1;

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
				if(choice == 1)
					dispatchEvent(new EntityEvent(EntityEvent.WORDDEF, sayingsList1[num-1]));
				else if(choice == 2)
					dispatchEvent(new EntityEvent(EntityEvent.WORDDEF, sayingsList2[num-1]));
				var c = new charisma_plus();
				c.x = (this.width - c.width) / 2 + this.x;
				c.y = (this.height - c.height) / 2 + this.y;
				c.addEventListener(Event.ENTER_FRAME, c.bindEnterFrame);
				c.addEventListener(EntityEvent.DEATH + "c", c.despawn);
				(root as MovieClip).addChild(c);
				Entity.envObj.push(c);
				this.gotoAndStop(2);
			}
		}

	}
	
}

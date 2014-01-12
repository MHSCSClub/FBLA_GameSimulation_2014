package  {
	
	import API.*;
	import flash.events.Event;
	
	public class FallingSpike extends Entity {
		
		public function FallingSpike(nsig:int, nx:Number = 0, ny:Number = 0) {
			super(nsig, nx, ny);
			this.g_testpoint.push(0);
			this.gravityBasePower = 8;
			this.moveThroughEnabled = false;
			this.jumpThroughEnabled = false;
			this.bounceEnabled = false;
		}
		public function bindEnterFrame(evt:Event): void {
			this.entity_update();
		}
		override public function g_setVariables(ett:Entity): void {
			ett.frictionEnabled = false;
			ett.slidingEnabled = false;
			ett.bounceEnabled = false;
			ett.slideDecreaseMultiplier = 1;
		}
		override public function g_env_set_var(c_obj:Environment): void {
			if(c_obj is Entity) {
				var t = c_obj;
				t.health -= 5;
				return;
			}
			dispatchEvent(new EntityEvent(EntityEvent.DEATH + this.sig, this.sig));
		}
		override public function j_setVariables(ett:Entity): void {
			ett.health -= 5;
		}
		override public function x_setVariables(ett:Entity): void {
			ett.health -= 5;
		}
		
	}
}

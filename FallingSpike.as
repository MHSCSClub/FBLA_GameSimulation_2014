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
		}
		public function bindEnterFrame(evt:Event): void {
			this.entity_update();
			if(this.onGround){
				dispatchEvent(new EntityEvent(EntityEvent.DEATH + this.sig, this.sig));
			}
		}
		override public function setVariables(ett:Entity): void {
			ett.health -= 5;
		}
	}
}

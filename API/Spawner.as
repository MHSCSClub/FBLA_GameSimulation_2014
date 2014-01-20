/*
	Base class to create Entities
*/
package API {
	
	import API.*;
	import flash.events.Event;
	
	public class Spawner extends Environment{
		protected var _obj_sig:int;

		public function Spawner() {
			this.fallThroughEnabled = true;
			this.jumpThroughEnabled = true;
			this.moveThroughEnabled = true;
			this.visible = false;
			this.eventFrameBind = true;
		}
		public function bindEnterFrame(evt:Event): void {
			
		}
		public function pause(evt:Event): void {
			
		}
		public function unpause(evt:Event): void {
			
		}
		public function construct(): void {
			this.addEventListener(Event.ENTER_FRAME, this.bindEnterFrame);
			stage.addEventListener("PAUSE", this.pause, true);
			stage.addEventListener("UNPAUSE", this.unpause, true);
		}
		public function destruct(): void {
			this.removeEventListener(Event.ENTER_FRAME, this.bindEnterFrame);
			stage.removeEventListener("PAUSE", this.pause, true);
			stage.removeEventListener("UNPAUSE", this.unpause, true);
		}
	}
	
}
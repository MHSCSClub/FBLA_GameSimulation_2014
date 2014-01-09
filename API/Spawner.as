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
		}
		public function bindEnterFrame(evt:Event): void {
			
		}
	}
	
}
package  {
	
	import API.*;
	import flash.events.*;
	
	public class disp_ground extends Environment {
		
		private var _appear:Boolean = false;
		
		public function disp_ground() { 
			this.fallThroughEnabled = true;
			this.visible = false;
			this.eventFrameBind = true;
		}
		
		override public function g_setVariables(ett:Entity): void {
			ett.frictionEnabled = false;
			ett.slidingEnabled = false;
			ett.bounceEnabled = false;
			ett.reset_all_default();
		}
		
		private function appear(evt:Event): void {
			this.fallThroughEnabled = false;
			this.visible = true;
			this.moveThroughEnabled = false;
			this.jumpThroughEnabled = false;
			if(!_appear)
				stage.removeEventListener(EntityEvent.APPEAR, appear, true);
			_appear = true;
		}
		public function pause(evt:Event): void { }
		public function unpause(evt:Event): void { }
		public function construct(): void {
			stage.addEventListener(EntityEvent.APPEAR + "ground", appear, true);
		}
		public function destruct(): void {
			if(!_appear){
				stage.removeEventListener(EntityEvent.APPEAR + "ground", appear, true);
			}
		}
	}
	
}

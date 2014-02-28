package {
	
	import flash.display.MovieClip;
	import API.*;
	
	public class basic_ground extends Environment{
		
		public function basic_ground() { 
			this.moveThroughEnabled = false;
			this.jumpThroughEnabled = false;
		}
		override public function g_setVariables(ett:Entity): void {
			ett.frictionEnabled = false;
			ett.slidingEnabled = false;
			ett.bounceEnabled = false;
			ett.reset_all_default();
		}
	}
	
}

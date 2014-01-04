package {
	
	import flash.display.MovieClip;
	import API.*;
	
	public class basic_ground extends Environment implements NoJump{
		
		public function basic_ground() { }
		override public function setVariables(ett:Entity): void {
			ett.frictionEnabled = false;
			ett.slidingEnabled = false;
			ett.bounceEnabled = false;
		}
	}
	
}

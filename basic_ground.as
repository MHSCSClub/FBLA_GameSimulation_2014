package  {
	
	import flash.display.MovieClip;
	import API.*;
	
	public class basic_ground extends Environment {
		
		public function basic_ground() {
		}
		override protected function setVariables(ett:Entity): void {
			ett.frictionEnabled = false;
			ett.slidingEnabled = false;
			ett.bounceEnabled = false;
		}
	}
	
}

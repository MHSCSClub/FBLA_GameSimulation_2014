package  {
	
	import API.*;
	
	public class slip_ground extends Environment {
		
		public function slip_ground() { }
		
		override public function setVariables(ett:Entity): void {
			ett.frictionEnabled = false;
			ett.slidingEnabled = true;
			ett.bounceEnabled = false;
			ett.slideDecreaseMultiplier = 1;
		}
	}
}

package {
	
	import API.*;
	
	public class bounce_ground extends Environment {
		
		
		public function bounce_ground() { }
		
		override public function g_setVariables(ett:Entity): void {
			ett.frictionEnabled = false;
			ett.slidingEnabled = true;
			ett.bounceEnabled = true;
			ett.bounceBackHeight = .5;
			ett.bounceBasePower = 40;
			ett.slideDecreaseMultiplier = .8;
		}
	}
	
}
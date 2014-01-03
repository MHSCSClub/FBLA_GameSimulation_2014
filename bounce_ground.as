package  {
	
	import API.*;
	
	public class bounce_ground extends Environment {
		
		
		public function bounce_ground() { }
		
		override public function setVariables(ett:Entity): void {
			ett.frictionEnabled = false;
			ett.slidingEnabled = false;
			ett.bounceEnabled = true;
			ett.bounceBackHeight = .5;
			ett.bounceBasePower = 40;
		}
	}
	
}

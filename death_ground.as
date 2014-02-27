package  {

	import API.*;
	
	public class death_ground extends Environment {
		
		
		public function death_ground() { }
		
		override public function g_setVariables(ett:Entity): void {
			ett.health = -1;
		}
	}
	
}

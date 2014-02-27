package  {
	import API.*;
	
	public class DoubleSpike extends FallingSpike{
		
		
		public function DoubleSpike(nsig:int, nx:Number = 0, ny:Number = 0) {
			super(nsig, nx, ny);
		}
		override public function g_setVariables(ett:Entity): void {
			ett.health -= 5;
		}
	}
	
}

/*
	Environment class
	The environment class is responsible for anything that affects entity, as in collisions
*/
package API {
	
	import flash.display.MovieClip;
	import API.*;
	
	public class Environment extends MovieClip{
		
		public function Environment() {
			// constructor code
		}
		
		public static function less_y(e1:Environment, e2:Environment): int {
			if(e1.y < e2.y)
				return -1;
			else if(e1.y == e2.y)
				return 0;
			return 1;
		}
		//Virtual
		protected function setVariables(ett:Entity): void {
			
		}

	}
	
}

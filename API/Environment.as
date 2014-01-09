/*
	Environment class
	The environment class is responsible for anything that affects entity, as in collisions
*/
package API {
	
	import flash.display.MovieClip;
	import API.*;
	
	public class Environment extends MovieClip{
		
		private var _sig:int = -1;
		
		public var jumpThroughEnabled = true;
		public var moveThroughEnabled = true;
		public var fallThroughEnabled = false;
		
		public function Environment() { }
		public function set sig(nsig:int) {
			if(_sig == -1) {
				_sig = nsig;
			} else {
				throw new Error("Sig already set");
			}
		}
		public function get sig(): int {
			if(_sig != -1) {
				return _sig;
			} else {
				throw new Error("Sig not set");
			}
		}
		
		public static function less_y(e1:Environment, e2:Environment): int {
			if(e1.y < e2.y)
				return -1;
			else if(e1.y == e2.y)
				return 0;
			return 1;
		}
		public static function less_x(e1:Environment, e2:Environment): int {
			if(e1.x < e2.x)
				return -1;
			else if(e1.x == e2.x)
				return 0;
			return 1;
		}
		
		public function scroll_obj(movex:Number, movey:Number): void {
			this.x = this.x - movex;
			this.y = this.y - movey;
		}
		
		//Virtual
		public function setVariables(ett:Entity): void {
			
		}

	}
	
}

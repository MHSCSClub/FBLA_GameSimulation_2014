/*
	Main Player Package and Class
	Main Player Frame Guides:
	Frame 1: Still (standing)
*/

package  {
	
	import flash.display.MovieClip;
	
	public class Player extends MovieClip{

		public function Player(nx:int, ny:int) {
			stop(); //Initializes at frame 1 and stops
			this.x = nx;
			this.y = ny;
		}

	}
	
}

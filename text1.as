package {
	
	import flash.display.MovieClip;
	import API.*
	
	public class text1 extends MovieClip implements Scrollable{
		
		public function text1() {
			// constructor code
		}
		public function scroll_obj(movex:Number, movey:Number): void {
			this.x = this.x - movex;
			this.y = this.y - movey;
		}
	}
	
}

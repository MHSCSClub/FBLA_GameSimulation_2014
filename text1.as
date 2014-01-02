package  {
	
	import flash.display.MovieClip;
	import API.*
	
	public class text1 extends MovieClip implements Scrollable{
		
		public function text1() {
			// constructor code
		}
		public function scroll_obj(nx:Number, ny:Number): void {
			this.x -= nx;
			this.y -= ny;
		}
	}
	
}

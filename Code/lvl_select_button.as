package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class lvl_select_button extends MovieClip {
		
		private var _button;
		public var lvl:int = 0;
		
		public function lvl_select_button() {
			this.stop();
		}
		public function construct() {
			_button = getChildByName("l" + String(lvl));
			_button.visible = true;
			_button.stop();
			if(Player.max_level < lvl) {
				this.cover.visible = true;
			} else {
				this.addEventListener(MouseEvent.MOUSE_OVER, overFunc);
				this.addEventListener(MouseEvent.MOUSE_OUT, outFunc);
				this.addEventListener(MouseEvent.CLICK, clickFunc);
			}
		}
		
		private function overFunc(mevt:MouseEvent) {
			_button.gotoAndStop(2);
		}
		private function outFunc(mevt:MouseEvent) {
			_button.gotoAndStop(1);
		}
		private function clickFunc(mevt:MouseEvent) {
			Player.current_level = lvl;
			(root as MovieClip).gotoAndPlay(Player.lvl_offset + lvl);
		}
	}
	
}

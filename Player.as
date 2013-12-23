/*
	Main Player Package and Class
	Main Player Frame Guides:
	Frame 1: Still (standing)
*/

package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.ui.Keyboard;
	public class Player extends MovieClip{
		private var _keycode:Array = [];
		private var _added:Boolean = false;
		private function keymove():void { //moves the Player
			if(_keycode[Keyboard.UP]) check_set_y(this.y - moveunit);
			if(_keycode[Keyboard.DOWN]) check_set_y(this.y + moveunit);
			if(_keycode[Keyboard.RIGHT]) check_set_x(this.x + moveunit);
			if(_keycode[Keyboard.LEFT]) check_set_x(this.x - moveunit);
		}
		public function check_set_x(nx:int):Boolean {
			if(_added){
				if(nx > 0 + this.width / 2 && nx < this.stage.stageWidth - this.width / 2){
					this.x = nx;
					return true;
				}
			}
			return false
		}
		public function check_set_y(ny:int):Boolean {
			if(_added){
				if(ny > 0 + this.height / 2 && ny < this.stage.stageHeight - this.height / 2){
					this.y = ny;
					return true;
				}
			}
			return false;
		}
		
		public static var moveunit:int = 10;
		
		public function Player(nx:int = 0, ny:int = 0) {
			this.x = nx + this.width / 2;
			this.y = ny + this.height / 2;
		}
				
		public function bindEnterFrame(evt:Event):void {
			stop();
			keymove();
		}
		public function bindAddedToStage(evt:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE, bindAddedToStage);
			_added = true;
		}
		public function bindKeyDown(kevt:KeyboardEvent):void {
			_keycode[kevt.keyCode] = true;
		}
		public function bindKeyUp(kevt:KeyboardEvent):void {
			_keycode[kevt.keyCode] = false;
		}
	}
	
}

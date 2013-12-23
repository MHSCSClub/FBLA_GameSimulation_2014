/*
	Main Player Package and Class
	Main Player Frame Guides:
	Frame 1: Still (standing)
	Frame 2 - ?: Jump
*/

package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.ui.Keyboard;
	public class Player extends MovieClip{
		private var _keycode:Array = [];
		private var _isJump:Boolean = false; 
		private var _gravityConstant:Number = gpower;
		
		private function keymove():void { //moves the Player
			if(_keycode[Keyboard.UP] && !_isJump) { //Jump
				check_set_y(this.y - jumpunit);
				_isJump = true;
			}
			//if(_keycode[Keyboard.DOWN]) check_set_y(this.y + moveunit);
			if(_keycode[Keyboard.RIGHT]) check_set_x(this.x + moveunit);
			if(_keycode[Keyboard.LEFT]) check_set_x(this.x - moveunit);
		}
		//Gravity
		public function gravity():void {
			if(check_set_y(this.y + _gravityConstant))
				_gravityConstant += 1.5;
			else
				_gravityConstant = gpower;
		}
		//Make sure that x and y coordinate are valid (in stage)
		private function check_set_x(nx:Number):Boolean {
			if(nx > 0 + this.width / 2 && nx < this.stage.stageWidth - this.width / 2){
				this.x = nx;
				return true;
			}
			return false
		}
		private function check_set_y(ny:Number):Boolean {
			if(ny > 0 + this.height / 2 && ny < this.stage.stageHeight - this.height / 2){
				this.y = ny;
				return true;
			}
			return false;
		}
		
		//Static variables (dont have to end in _) configurable
		public static var moveunit:int = 10;
		public static var gpower:Number = 5;
		public static var jumpunit:int = 100;
		
		public function Player(nx:int = 0, ny:int = 0) {
			this.x = nx + this.width / 2;
			this.y = ny + this.height / 2;
		}
		public function bindEnterFrame(evt:Event):void {
			stop();
			keymove();
			gravity();
		}
		public function bindKeyDown(kevt:KeyboardEvent):void {
			_keycode[kevt.keyCode] = true;
		}
		public function bindKeyUp(kevt:KeyboardEvent):void {
			_keycode[kevt.keyCode] = false;
			_isJump = false
		}
	}
	
}

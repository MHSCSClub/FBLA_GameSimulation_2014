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
	public class Player extends Entity{
		private var _keycode:Array = [];
		private var _jcount:int = 0;
		
		public var moveunit:int = 10;
		public var jumpunit:int = 40;
		public var jumplimit:int = 4;
		
		private function keymove():void { //moves the Player
			//Jump
			if(_keycode[Keyboard.UP] && _jcount == 0 && this.onGround) {
				_jcount = jumplimit + 1;
				this.onGround = false;
				this.gravityEnabled = false;
			}
			if(_jcount > 1){
				--_jcount;
				this.movey -= jumpunit;
			}else if(_jcount == 1){
				_jcount = 0;
				this.gravityEnabled = true;
			}
			
			//Right Left movement
			if(_keycode[Keyboard.RIGHT]){ 
				this.movex += moveunit; 
				//this.bounceEnabled = false;
			}
			if(_keycode[Keyboard.LEFT]) {
				this.movex -= moveunit;
			}
			if(_keycode[Keyboard.B]) {
				this.bounceEnabled = false;
			}
		}
		
		public function Player(nx:int = 0, ny:int = 0) {
			super(nx, ny);
			//this.bounceEnabled = false;
		}
		public function bindEnterFrame(evt:Event):void {
			stop();
			keymove();
			super.entity_update();
		}
		public function bindKeyDown(kevt:KeyboardEvent):void {
			_keycode[kevt.keyCode] = true;
		}
		public function bindKeyUp(kevt:KeyboardEvent):void {
			_keycode[kevt.keyCode] = false;
		}
	}
	
}

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
		
		private var _jcount:int = 0;
		private var _onGround:Boolean = false;
		private var _gravityConstant:Number = gpower;
		
		private var _movex = 0;
		
		private function keymove():void { //moves the Player
			if(_keycode[Keyboard.UP] && _jcount == 0 && _onGround) { //Jump
				_jcount = jumplimit;
				_onGround = false;
			}
			if(_keycode[Keyboard.RIGHT]) _movex += moveunit;
			if(_keycode[Keyboard.LEFT]) _movex -= moveunit;
		}
		//Update
		private function update(): void {
			var nx:Number = this.x + _movex;
			
			if(nx > 0 + this.width / 2 && nx < this.stage.stageWidth - this.width / 2) //side by side
				this.x = nx;
			if(_jcount > 0){ //jumping
				var ny:Number = this.y - jumpunit;
				if(ny > 0)
					this.y = ny;
				--_jcount;
			}else { //falling
				var ny:Number = this.y + _gravityConstant;
				if(ny <= this.stage.stageHeight - this.height / 2){
					this.y = ny;
					_gravityConstant += 2.5;
				} else {
					this.y = this.stage.stageHeight - this.height / 2;
					_onGround = true;
					_gravityConstant = gpower;
				}
			}
			
			_movex = 0;
		}
		
		//Static variables (dont have to end in _) configurable
		public static var moveunit:int = 10;
		public static var gpower:Number = 10;
		public static var jumpunit:int = 20;
		public static var jumplimit:int = 4;
		
		public function Player(nx:int = 0, ny:int = 0) {
			this.x = nx + this.width / 2;
			this.y = ny + this.height / 2;
		}
		public function bindEnterFrame(evt:Event):void {
			stop();
			keymove();
			update();
		}
		public function bindKeyDown(kevt:KeyboardEvent):void {
			_keycode[kevt.keyCode] = true;
		}
		public function bindKeyUp(kevt:KeyboardEvent):void {
			_keycode[kevt.keyCode] = false;
			//_jcount = false
		}
	}
	
}

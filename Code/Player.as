/*
	Main Player Package and Class
	Main Player Frame Guides:
	Frame 1: Still (standing)
	Frame 2 - ?: Jump
*/

package {
	
	import flash.events.*;
	import flash.ui.Keyboard;
	import API.*;
	import flash.display.Shape;
	
	public class Player extends Entity{
		private var _keycode:Array = [];
		private var _jcount:int = 0;
		private var _currentJump = jumpunit;
		private var _scroll_left_line:Shape = new Shape();
		private var _scroll_right_line:Shape = new Shape();
		
		private static var _p_sig:int = -1;
		
		public static var current_level:int = 1;
		public static var lvl_offset:int = 4;
		public static var score:int = 0;
		
		public static var people_skill_count:int = 0;
		public static var leadership_skill_count:int = 0;
		public static var negotiation_skill_count:int = 0;
		
		public static var possess_obj:Boolean = false;
		
		public var moveunit:int = 10;
		public var jumpunit:int = 20;
		public var jumplimit:int = 5;
		public var jumpDecreaseMultiplier = .9;
		public var deathCount:int = 0;
		
		public function Player(nsig:int, nx:Number = 0, ny:Number = 0) {
			super(nsig, nx, ny);
			
			this.fallThroughEnabled = false;
			//offsets
			g_testpoint.push(this.width - 5);
			g_testpoint.push(this.width / 2);
			g_testpoint.push(5);
			x_testpoint.push(5);
			x_testpoint.push(this.height / 2 + 10);
			if(_p_sig == -1) {
				_p_sig = this.sig;
			} else {
				throw new Error("Multiple players on screen");
			}
			this.gotoAndPlay(1);
		}
		
		public static function get p_sig(): int {
			if(_p_sig == -1){
				throw new Error("Accessed player before initialization");
			} else {
				return _p_sig;
			}
		}
		
		public function destruct(): void {
			_p_sig = -1;
			people_skill_count = 0;
			leadership_skill_count = 0;
			negotiation_skill_count = 0;
			possess_obj = false;
		}
		
		//Responsible for player move
		private function keymove():void {
			//Jump
			if(_keycode[Keyboard.UP] && _jcount == 0 && this.onGround) {
				_jcount = jumplimit + 1;
				this.onGround = false;
				this.gravityEnabled = false;
			}
			if(_jcount > 1){
				if(_keycode[Keyboard.UP]){
					--_jcount;
					this.movey -= _currentJump;
					_currentJump *= jumpDecreaseMultiplier;
				} else {
					_jcount = 1;
				}
			}else if(_jcount == 1){
				_jcount = 0;
				_currentJump = jumpunit;
				this.gravityEnabled = true;
			}
			//Right Left movement
			if(_keycode[Keyboard.RIGHT]){
				//Movement: 1-13
				this.movex += moveunit;
				if(this.currentFrame >= 13)
					this.gotoAndPlay(1);
				else
					this.nextFrame();
			}
			if(_keycode[Keyboard.LEFT]) {
				this.movex -= moveunit;
				if(this.currentFrame < 14 || this.currentFrame >= 26)
					this.gotoAndPlay(14);
				else
					this.nextFrame();
			}
		}
		override public function bindEnterFrame(evt:Event):void {
			if(this.health <= 0){
				++deathCount;
				dispatchEvent(new EntityEvent(EntityEvent.DEATH + this.sig, this.sig));
				return;
			}
			keymove();
			super.entity_update();
		}
		public function bindKeyDown(kevt:KeyboardEvent): void {
			_keycode[kevt.keyCode] = true;
		}
		public function bindKeyUp(kevt:KeyboardEvent): void {
			_keycode[kevt.keyCode] = false;
		}
		
		public function drawBoundLines(): void {
			drawLine(stage.stageWidth / 4, 0, stage.stageWidth / 4, stage.stageHeight, _scroll_left_line);
			drawLine(stage.stageWidth * (3 / 4), 0, stage.stageWidth * (3 / 4), stage.stageHeight, _scroll_right_line);
		}
		
		private function drawLine(sx:Number, sy:Number, fx:Number, fy:Number, shp:Shape): void {
			shp.graphics.lineStyle(2, 0x0000FF, 2);
			shp.graphics.moveTo(sx, sy);
			shp.graphics.lineTo(fx, fy);
		}
		override public function scroll_x(nx:Number): void {
			var ml:Shape = new Shape();
			var scroll:Boolean = false;
			drawLine(this.x, this.y, nx, this.y, ml);
			
			if(nx - this.x > 0){
				if(_scroll_right_line.hitTestObject(this.xLines[0])){
					scroll = true;
				}
			} else {
				if(_scroll_left_line.hitTestObject(this.xLines[0])){
					scroll = true;
				}
			}
			
			if(scroll){
				for(var i:int = 0; i < envObj.length; ++i){
					envObj[i].scroll_obj(nx - this.x, 0);
					//this.x = nx;
				}
			} else{
				this.x = nx;
			}
		}
		override public function scroll_obj(movex:Number, movey:Number): void { }
	}
}

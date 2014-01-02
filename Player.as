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
	import API.*;
	import flash.display.Shape;
	
	public class Player extends Entity{
		private var _keycode:Array = [];
		private var _jcount:int = 0;
		private var _scroll_left_line:Shape = new Shape();
		private var _scroll_right_line:Shape = new Shape();
		private var _scroll_bottom_line:Shape = new Shape();
		private var _scroll_top_line:Shape = new Shape();
		
		public var moveunit:int = 10;
		public var jumpunit:int = 40;
		public var jumplimit:int = 4;
		
		public static var scrollObj:Array = [];
		
		public function Player(nx:int = 0, ny:int = 0) {
			super(nx, ny);
			
			//offsets
			g_testpoint.push(-3.0);
			g_testpoint.push(8);
			for(var q:Number = -this.height / 4; q < this.height / 2; q += this.height / 4){
				x_testpoint.push(q);
			}
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
					this.movey -= jumpunit;
				} else {
					_jcount = 1;
				}
			}else if(_jcount == 1){
				_jcount = 0;
				this.gravityEnabled = true;
			}
			//Right Left movement
			if(_keycode[Keyboard.RIGHT]){
				this.movex += moveunit; 
			}
			if(_keycode[Keyboard.LEFT]) {
				this.movex -= moveunit;
			}
		}
		public function bindEnterFrame(evt:Event):void {
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
			shp.graphics.lineStyle(1, 0xFF0000, 1);
			shp.graphics.moveTo(sx, sy);
			shp.graphics.lineTo(fx, fy);
			//stage.addChild(shp);
		}
		override public function scroll_x(nx:Number): void {
			var ml:Shape = new Shape();
			var scroll:Boolean = false;
			drawLine(this.x, this.y, nx, this.y, ml);
			drawLine(stage.stageWidth / 4, 0, stage.stageWidth / 4, stage.stageHeight, _scroll_left_line);
			drawLine(stage.stageWidth * (3 / 4), 0, stage.stageWidth * (3 / 4), stage.stageHeight, _scroll_right_line);
			
			if(nx - this.x > 0){
				if(_scroll_right_line.hitTestObject(ml)){
					scroll = true;
				}
			} else {
				if(_scroll_left_line.hitTestObject(ml)){
					scroll = true;
				}
			}
			
			if(scroll){
				for(var i:int = 0; i < scrollObj.length; ++i){
					scrollObj[i].scroll_obj(nx - this.x, 0);
				}
			} else{
				this.x = nx;
			}
		}
/*		override public function scroll_y(ny:Number): void {
			var ml:Shape = new Shape();
			var scroll:Boolean = false;
			drawLine(this.x, this.y + this.height / 2, this.x, ny, ml);
			drawLine(0, stage.stageHeight / 5, stage.stageWidth, stage.stageHeight / 5,  _scroll_top_line);
			drawLine(0, stage.stageHeight * (4 / 5), stage.stageWidth, stage.stageHeight * (4 / 5), _scroll_bottom_line);
			
			if(ny - this.y > 0){
				if(_scroll_bottom_line.hitTestObject(ml)){
					scroll = true;
				}
			} else {
				if(_scroll_top_line.hitTestObject(ml)){
					scroll = true;
				}
			}
			
			if(scroll){
				for(var i:int = 0; i < envObj.length; ++i){
					envObj[i].scroll_obj(0, ny - this.y);
				}
			} else {
				this.y = ny;
			}
		}*/
	}
}

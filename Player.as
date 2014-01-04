﻿/*
	Main Player Package and Class
	Main Player Frame Guides:
	Frame 1: Still (standing)
	Frame 2 - ?: Jump
*/

package {
	
	import flash.display.MovieClip;
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
		
		public var moveunit:int = 10;
		public var jumpunit:int = 30;
		public var jumplimit:int = 5;
		public var jumpDecreaseMultiplier = .9;
		
		public function Player(nx:int = 0, ny:int = 0) {
			super(nx, ny);
			this.slidingEnabled = false;
			
			//offsets
			g_testpoint.push(-7.0);
			g_testpoint.push(17);
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
			shp.graphics.lineStyle(2, 0x0000FF, 2);
			shp.graphics.moveTo(sx, sy);
			shp.graphics.lineTo(fx, fy);
			//stage.addChild(shp);
		}
		override public function scroll_x(nx:Number): void {
			var ml:Shape = new Shape();
			var scroll:Boolean = false;
			drawLine(this.x, this.y, nx, this.y, ml);
			
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
				for(var i:int = 0; i < envObj.length; ++i){
					envObj[i].scroll_obj(nx - this.x, 0);
				}
			} else{
				this.x = nx;
			}
			ml.graphics.clear();
		}
	}
}

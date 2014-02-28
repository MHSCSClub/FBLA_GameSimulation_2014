package  {
	
	import API.*;
	import flash.events.*;
	import flash.ui.Keyboard;
	import flash.display.Shape;
	
	public class MovableBlock extends Entity {
		private var _keycode:Array = [];
		public var moveunit:int = 10;
		
		public function MovableBlock(sig:int, nx:Number, ny:Number) {
			super(sig, nx, ny);
			this.g_testpoint.push(-this.width);
			this.g_testpoint.push(this.width);
			this.x_testpoint.push(-this.height);
			this.x_testpoint.push(-this.height);
		}
		
		override public function bindEnterFrame(evt:Event): void {
			keymove();
			super.entity_update();
		}
		//movement exactly the same as player
		public function keymove(): void {
			var circle:Shape = new Shape();
			if(Math.abs(Entity.envObj[Player.p_sig].x - this.x) < this.width / 2) {
				if(_keycode[Keyboard.RIGHT]){
					this.movex += moveunit;
				}
				if(_keycode[Keyboard.LEFT]) {
					this.movex -= moveunit;
				}
			}
		}
		public function bindKeyDown(kevt:KeyboardEvent): void {
			_keycode[kevt.keyCode] = true;
		}
		public function bindKeyUp(kevt:KeyboardEvent): void {
			_keycode[kevt.keyCode] = false;
		}
		public function bindReachedDest(evt:Event): void {
			dispatchEvent(new EntityEvent(EntityEvent.DEATH + this.sig, this.sig));
		}
	}
	
}

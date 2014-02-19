package {

	import API.*;
	import flash.events.*;
	import flash.ui.Keyboard;
	import flash.display.Shape;

	public class Follower extends Entity {
		private var _keycode: Array = [];
		private var _jcount: int = 0;
		private var _currentJump = jumpunit;
		private var _follow: Boolean = false;

		public var moveunit: int = 10;
		public var jumpunit: int = 30;
		public var jumplimit: int = 5;
		public var jumpDecreaseMultiplier = .9;

		public function Follower(sig: int, nx: Number, ny: Number) {
			super(sig, nx, ny);
			this.g_testpoint.push(this.width / 2);
			this.g_testpoint.push(-this.width / 2);
			this.x_testpoint.push(0);
			this.fallThroughEnabled = true;
		}
		override public function bindEnterFrame(evt: Event): void {
			if (this.health <= 0) {
				dispatchEvent(new EntityEvent(EntityEvent.DEATH + this.sig, this.sig));
				return;
			}
			keymove();
			super.entity_update();
		}
		override public function g_collid_hit_test(c_obj: Environment, ln: Shape): Boolean {
			return c_obj.hitTestObject(ln) && !(c_obj is Player);
		}
		//movement exactly the same as player
		public function keymove(): void {
			var circle: Shape = new Shape();
			//trace(Math.abs(Entity.envObj[Player.p_sig].x - this.x) < 100 && Math.abs(Entity.envObj[Player.p_sig].x - this.x) > 80);
			if (Entity.envObj[Player.p_sig].hitTestObject(this)) {
				_follow = true;
			} else if (Math.abs(Entity.envObj[Player.p_sig].x - this.x) > 100) {
				_follow = false;
			}
			if (Math.abs(Entity.envObj[Player.p_sig].x - this.x) > 80 && _follow) {
				if (_keycode[Keyboard.RIGHT]) {
					this.movex += moveunit;
					if (this.currentFrame >= 8)
						this.gotoAndPlay(1);
					else
						this.nextFrame();
				}
				if (_keycode[Keyboard.LEFT]) {
					this.movex -= moveunit;
					if (this.currentFrame < 9 || this.currentFrame >= 16)
						this.gotoAndPlay(9);
					else
						this.nextFrame();
				}
			}
			if (_follow) {
				if (_keycode[Keyboard.UP] && _jcount == 0 && this.onGround) {
					_jcount = jumplimit + 1;
					this.onGround = false;
					this.gravityEnabled = false;
					this.gotoAndPlay(2);
				}
				if (_jcount > 1) {
					if (_keycode[Keyboard.UP]) {
						--_jcount;
						this.movey -= _currentJump;
						_currentJump *= jumpDecreaseMultiplier;
					} else {
						_jcount = 1;
					}
				} else if (_jcount == 1) {
					_jcount = 0;
					_currentJump = jumpunit;
					this.gravityEnabled = true;
				}
			}
		}
		public function bindKeyDown(kevt: KeyboardEvent): void {
			_keycode[kevt.keyCode] = true;
		}
		public function bindKeyUp(kevt: KeyboardEvent): void {
			_keycode[kevt.keyCode] = false;
		}
		public function bindReachedDest(evt: Event): void {
			dispatchEvent(new EntityEvent(EntityEvent.DEATH + this.sig, this.sig));
		}

	}

}
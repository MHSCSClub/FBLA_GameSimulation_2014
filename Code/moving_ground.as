package {

	import API.*;
	import flash.events.Event;

	public class moving_ground extends Environment {

		private var direction: int = -1;
		private var _ridden: Boolean = false;

		public var x_threshhold_l: int = 0;
		public var x_threshhold_r: int = 600;
		public var moveunit: Number = 10;

		public function moving_ground() {
			this.eventFrameBind = true;
			this.jumpThroughEnabled = true;
			this.moveThroughEnabled = true;
		}
		public function bindEnterFrame(evt: Event): void {
			if (this.x <= x_threshhold_l || this.x + this.width >= x_threshhold_r) {
				moveunit *= -1;
			}
			this.x += moveunit * direction;
			if (_ridden) {
				Entity.envObj[Player.p_sig].x += moveunit * direction;
			}
			_ridden = false;
		}
		override public function g_setVariables(ett: Entity): void {
			if (ett is Player)
				_ridden = true;
		}
		public function pause(evt: Event): void {
			this.removeEventListener(Event.ENTER_FRAME, this.bindEnterFrame);
		}
		public function unpause(evt: Event): void {
			this.addEventListener(Event.ENTER_FRAME, this.bindEnterFrame);
		}
		public function construct(): void {
			this.addEventListener(Event.ENTER_FRAME, this.bindEnterFrame);
			stage.addEventListener("PAUSE", this.pause, true);
			stage.addEventListener("UNPAUSE", this.unpause, true);
		}
		public function destruct(): void {
			this.removeEventListener(Event.ENTER_FRAME, this.bindEnterFrame);
			stage.removeEventListener("PAUSE", this.pause, true);
			stage.removeEventListener("UNPAUSE", this.unpause, true);
		}
	}

}
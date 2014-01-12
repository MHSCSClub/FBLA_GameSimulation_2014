package  {
	
	import API.*;
	import flash.events.Event;
	import flash.display.Shape;
	
	public class spike_spawner extends Spawner {
		
		private var spike:FallingSpike;
		private var _spawn:Boolean = false;
		
		public function spike_spawner() {
			this.visible = true;
		}
		override public function bindEnterFrame(evt:Event): void {
			if(player_spawner.playerConstructed) {
				var left_line:Shape = new Shape();
				left_line.graphics.lineStyle(1, 0xFF0000, 1);
				left_line.graphics.moveTo(this.x, this.y);
				left_line.graphics.lineTo(this.x, stage.stageWidth);
				if(Entity.envObj[Player.p_sig].xLines[0] == null) {
					return;
				} else if(left_line.hitTestObject(Entity.envObj[Player.p_sig].xLines[0])){
					spawn();
				}
			}
		}
		public function spawn(): void {
			_spawn = true;
			spike = new FallingSpike(Entity.envObj.length, this.x, this.y);
			this._obj_sig = Entity.envObj.length;
			stage.addChild(spike);
			Entity.envObj.push(spike);
			spike.addEventListener(Event.ENTER_FRAME, spike.bindEnterFrame);
			this.removeEventListener(Event.ENTER_FRAME, this.bindEnterFrame);
			stage.addEventListener(EntityEvent.DEATH + this._obj_sig, despawn, true);
			this.visible = false;
		}
		public function despawn(eevt:EntityEvent): void {
			spike.removeEventListener(Event.ENTER_FRAME, spike.bindEnterFrame);
			stage.removeEventListener(EntityEvent.DEATH, despawn, true);
			this.removeEventListener(Event.ENTER_FRAME, this.bindEnterFrame);
		}
		override public function destruct(): void {
			if(_spawn){
				stage.removeChild(spike);
				_spawn = false;
			}
			this.removeEventListener(Event.ENTER_FRAME, this.bindEnterFrame);
		}
	}
}

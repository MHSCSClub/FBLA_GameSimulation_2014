package  {
	
	import API.*;
	import flash.events.Event;
	import flash.display.Shape;
	
	public class spike_spawner extends Spawner {
		
		private var spike:FallingSpike;
		
		public function spike_spawner() {
			this.visible = true;
		}
		override public function bindEnterFrame(evt:Event): void {
			if(player_spawner.playerConstructed) {
				var left_line:Shape = new Shape();
				left_line.graphics.lineStyle(1, 0xFF0000, 1);
				left_line.graphics.moveTo(this.x, this.y);
				left_line.graphics.lineTo(this.x, stage.stageWidth);
				if(Entity.envObj[Player.p_sig].xLines[0] && left_line.hitTestObject(Entity.envObj[Player.p_sig].xLines[0]) && !_spawn){
					spawn();
				}
			}
		}
		override public function spawn(): void {
			if(!_spawn){
				super.spawn();
				this.visible = false;
			}
		}
		override public function create_obj(): Entity {
			return new FallingSpike(Entity.envObj.length, this.x, this.y);
		}
	}
}

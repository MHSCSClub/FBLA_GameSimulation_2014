package  {
	
	import API.*;
	import flash.events.*;
	
	public class follower_spawner extends Spawner{

		public function follower_spawner() { }
		override public function bindEnterFrame(evt:Event): void {
			if(this.x > 0 && this.x < stage.stageWidth){
				spawn();
			}
		}
		override public function spawn(): void {
			super.spawn();
			if(_spawn) {
				stage.addEventListener(KeyboardEvent.KEY_DOWN, _obj.bindKeyDown);
				stage.addEventListener(KeyboardEvent.KEY_UP, _obj.bindKeyUp);
				stage.addEventListener(EntityEvent.HITSENSOR + "REACHEDDEST", _obj.bindReachedDest, true);
			}
		}
		override public function create_obj(): Entity {
			return new Follower(Entity.envObj.length, this.x, this.y);
		}
		override public function despawn(evt:Event): void {
			super.despawn(new Event(""));
			if(!_spawn) {
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, _obj.bindKeyDown);
				stage.removeEventListener(KeyboardEvent.KEY_UP, _obj.bindKeyUp);
				stage.removeEventListener(EntityEvent.HITSENSOR + "REACHEDDEST", _obj.bindReachedDest, true);
				stage.removeChild(_obj);
				_onScreen = false;
			}
		}

	}
	
}

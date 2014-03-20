package  {
	
	import API.*;
	import flash.events.*;
	import flash.display.MovieClip;
	
	public class player_spawner extends Spawner{
		public static var playerConstructed:Boolean = false;
		public function player_spawner() { }
		
		override public function bindEnterFrame(evt:Event): void {
			spawn();
			this.removeEventListener(Event.ENTER_FRAME, this.bindEnterFrame);
		}
		
		override public function spawn(): void {
			var np:Player = new Player(Entity.envObj.length, this.x, this.y);
			this._obj_sig = Entity.envObj.length;
			(root as MovieClip).addChildAt(np, (root as MovieClip).numChildren - 3);
			Entity.envObj.push(np);
			np.addEventListener(Event.ENTER_FRAME, np.bindEnterFrame);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, np.bindKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, np.bindKeyUp);
			stage.addEventListener(EntityEvent.DEATH + this._obj_sig, despawn, true);
			np.drawBoundLines();
			playerConstructed = true;
		}
		override public function pause(evt:Event): void {
			if(playerConstructed) {
				Entity.envObj[this._obj_sig].removeEventListener(Event.ENTER_FRAME, Entity.envObj[this._obj_sig].bindEnterFrame);
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, Entity.envObj[this._obj_sig].bindKeyDown);
			}
		}
		override public function unpause(evt:Event): void {
			if(playerConstructed) {
				Entity.envObj[this._obj_sig].addEventListener(Event.ENTER_FRAME, Entity.envObj[this._obj_sig].bindEnterFrame);
				stage.addEventListener(KeyboardEvent.KEY_DOWN, Entity.envObj[this._obj_sig].bindKeyDown);
			}
		}
		override public function despawn(evt:Event): void {
			if(playerConstructed) {
				Entity.envObj[this._obj_sig].destruct();
				(root as MovieClip).removeChild(Entity.envObj[this._obj_sig]);
				Entity.envObj[this._obj_sig].removeEventListener(Event.ENTER_FRAME, Entity.envObj[this._obj_sig].bindEnterFrame);
				stage.removeEventListener(EntityEvent.DEATH + this._obj_sig, despawn, true);
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, Entity.envObj[this._obj_sig].bindKeyDown);
				stage.removeEventListener(KeyboardEvent.KEY_UP, Entity.envObj[this._obj_sig].bindKeyUp);
				Entity.envObj[this._obj_sig].removeEventListener(EntityEvent.DEATH + this._obj_sig, despawn);
				playerConstructed = false;
				dispatchEvent(new Event("PLAYER_DEATH"));
			}
		}
		override public function destruct(): void {
			if(playerConstructed){
				Entity.envObj[this._obj_sig].destruct();
				(root as MovieClip).removeChild(Entity.envObj[this._obj_sig]);
				Entity.envObj[this._obj_sig].removeEventListener(Event.ENTER_FRAME, Entity.envObj[this._obj_sig].bindEnterFrame);
				stage.removeEventListener(EntityEvent.DEATH + this._obj_sig, despawn, true);
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, Entity.envObj[this._obj_sig].bindKeyDown);
				stage.removeEventListener(KeyboardEvent.KEY_UP, Entity.envObj[this._obj_sig].bindKeyUp);
				Entity.envObj[this._obj_sig].removeEventListener(EntityEvent.DEATH + this._obj_sig, despawn);
				playerConstructed = false;
				playerConstructed = false;
			}
			super.destruct();
		}
	}
	
}

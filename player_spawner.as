package  {
	
	import API.*;
	import flash.events.*;
	
	public class player_spawner extends Spawner{
		
		public static var playerConstructed:Boolean = false;
		public function player_spawner() { }
		
		override public function bindEnterFrame(evt:Event): void {
			create();
			this.removeEventListener(Event.ENTER_FRAME, this.bindEnterFrame);
		}
		
		public function create(): void {
			var np:Player = new Player(Entity.envObj.length, this.x, this.y);
			this._obj_sig = Entity.envObj.length;
			stage.addChild(np);
			Entity.envObj.push(np);
			np.addEventListener(Event.ENTER_FRAME, np.bindEnterFrame);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, np.bindKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, np.bindKeyUp);
			stage.addEventListener(EntityEvent.DEATH + this._obj_sig, despawn, true);
			np.drawBoundLines();
			playerConstructed = true;
		}
		public function despawn(eevt:EntityEvent): void {
			Entity.envObj[this._obj_sig].destruct();
			stage.removeChild(Entity.envObj[this._obj_sig]);
			Entity.envObj[this._obj_sig].removeEventListener(Event.ENTER_FRAME, Entity.envObj[this._obj_sig].bindEnterFrame);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, Entity.envObj[this._obj_sig].bindKeyDown);
			stage.removeEventListener(KeyboardEvent.KEY_UP, Entity.envObj[this._obj_sig].bindKeyUp);
			Entity.envObj[this._obj_sig].removeEventListener(EntityEvent.DEATH + this._obj_sig, despawn);
			dispatchEvent(new Event("PLAYER_DEATH"));
			playerConstructed = false;
		}
	}
	
}

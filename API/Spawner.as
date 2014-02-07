/*
	Base class to create Entities
*/
package API {
	
	import API.*;
	import flash.events.Event;
	import flash.display.MovieClip;
	
	public class Spawner extends Environment{
		protected var _obj_sig:int;
		protected var _obj;
		protected var _spawn:Boolean = false;
		protected var _onScreen:Boolean = false;

		public function Spawner() {
			this.fallThroughEnabled = true;
			this.jumpThroughEnabled = true;
			this.moveThroughEnabled = true;
			this.visible = false;
			this.eventFrameBind = true;
		}
		
		public function bindEnterFrame(evt:Event): void {
			
		}
		public function spawn(): void {
			if(!_spawn){
				_spawn = true;
				_obj = create_obj();
				this._obj_sig = Entity.envObj.length;
				(root as MovieClip).addChildAt(_obj, 2);
				_onScreen = true;
				Entity.envObj.push(_obj);
				_obj.addEventListener(Event.ENTER_FRAME, _obj.bindEnterFrame);
				stage.addEventListener(EntityEvent.DEATH + this._obj_sig, despawn, true);
				this.removeEventListener(Event.ENTER_FRAME, this.bindEnterFrame);
			}
		}
		public function despawn(evt:Event): void {
			if(_spawn) {
				_obj.removeEventListener(Event.ENTER_FRAME, _obj.bindEnterFrame);
				stage.removeEventListener(EntityEvent.DEATH + this._obj_sig, despawn, true);
				this.removeEventListener(Event.ENTER_FRAME, this.bindEnterFrame);
				_spawn = false;
			}
		}
		public function create_obj(): Entity {
			throw new Error("Did not override create_obj");
			return new Entity(0, 0, 0);
		}
		public function pause(evt:Event): void {
			if(_spawn) {
				_obj.removeEventListener(Event.ENTER_FRAME, _obj.bindEnterFrame);
			}
			this.removeEventListener(Event.ENTER_FRAME, this.bindEnterFrame);
		}
		public function unpause(evt:Event): void {
			if(_spawn) {
				_obj.addEventListener(Event.ENTER_FRAME, _obj.bindEnterFrame);
			}
			this.addEventListener(Event.ENTER_FRAME, this.bindEnterFrame);
		}
		public function construct(): void {
			this.addEventListener(Event.ENTER_FRAME, this.bindEnterFrame);
			stage.addEventListener("PAUSE", this.pause, true);
			stage.addEventListener("UNPAUSE", this.unpause, true);
		}
		public function destruct(): void {
			if(_spawn){
				despawn(new Event(""));
				_spawn = false;
			}
			if(_onScreen) {
				(root as MovieClip).removeChild(_obj);
				_onScreen = false;
			}
			this.removeEventListener(Event.ENTER_FRAME, this.bindEnterFrame);
			stage.removeEventListener("PAUSE", this.pause, true);
			stage.removeEventListener("UNPAUSE", this.unpause, true);
		}
	}
	
}
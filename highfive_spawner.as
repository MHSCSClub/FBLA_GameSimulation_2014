package  {
	
	import API.*;
	import flash.events.Event;
	
	public class highfive_spawner extends Spawner{
		private var _spawn:Boolean = false;
		private var nhf:HighFive;

		public function highfive_spawner() { }
		
		override public function bindEnterFrame(evt:Event): void {
			if(this.x > 0 && this.x < stage.stageWidth){
				spawn();
			}
		}
		public function spawn(): void {
			if(!_spawn){
				_spawn = true;
				nhf = new HighFive(Entity.envObj.length, this.x, this.y);
				this._obj_sig = Entity.envObj.length;
				stage.addChild(nhf);
				Entity.envObj.push(nhf);
				nhf.addEventListener(Event.ENTER_FRAME, nhf.bindEnterFrame);
				this.removeEventListener(Event.ENTER_FRAME, this.bindEnterFrame);
				stage.addEventListener(EntityEvent.DEATH + this._obj_sig, despawn, true);
			}
		}
		public function despawn(eevt:EntityEvent): void {
			if(_spawn) {
				nhf.removeEventListener(Event.ENTER_FRAME, nhf.bindEnterFrame);
				stage.removeEventListener(EntityEvent.DEATH + this._obj_sig, despawn, true);
				this.removeEventListener(Event.ENTER_FRAME, this.bindEnterFrame);
			}
		}
		override public function pause(evt:Event): void {
			if(_spawn) {
				nhf.removeEventListener(Event.ENTER_FRAME, nhf.bindEnterFrame);
			}
			this.removeEventListener(Event.ENTER_FRAME, this.bindEnterFrame);
		}
		override public function unpause(evt:Event): void {
			if(_spawn) {
				nhf.addEventListener(Event.ENTER_FRAME, nhf.bindEnterFrame);
			}
			this.addEventListener(Event.ENTER_FRAME, this.bindEnterFrame);
		}
		override public function destruct(): void {
			if(_spawn){
				stage.removeChild(nhf);
				_spawn = false;
			}
			super.destruct();
		}
	}
	
}

package  {
	
	import API.*;
	import flash.events.Event;
	
	public class highfive_spawner extends Spawner {
		
		private var nhf:HighFive = null;
		public var choice:int = 0;
		public var num:int;

		public function highfive_spawner() { }
		
		override public function construct(): void {
			super.construct();
			stage.addEventListener(EntityEvent.BUTTONPRESS + "g", bindChoice, true);
		}
		
		override public function destruct() : void {
			super.destruct();
			stage.removeEventListener(EntityEvent.BUTTONPRESS + "g", bindChoice, true);
		}
		
		override public function bindEnterFrame(evt:Event): void {
			if(this.x > 0 && this.x < stage.stageWidth){
				spawn();
			}
		}
		override public function create_obj(): Entity {
			nhf = new HighFive(Entity.envObj.length, this.x, this.y)
			nhf.choice = choice;
			trace(choice);
			nhf.num = num;
			return nhf;
		}
		private function bindChoice(eevt:EntityEvent): void {
			choice = eevt.sig;
			if(nhf != null) {
				nhf.choice = eevt.sig;
			}
		}
	}
	
}

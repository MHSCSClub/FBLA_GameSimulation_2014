package  {
	
	import API.*;
	import flash.events.Event;
	
	public class highfive_spawner extends Spawner {
		
		private var nhf:HighFive;
		public var choice:int;
		public var num:int;

		public function highfive_spawner() { }
		
		override public function construct(): void {
			super.construct();
			stage.addEventListener(EntityEvent.BUTTONPRESS + "g", bindChoice, true);
		}
		
		override public function bindEnterFrame(evt:Event): void {
			if(this.x > 0 && this.x < stage.stageWidth){
				spawn();
			}
		}
		override public function create_obj(): Entity {
			nhf = new HighFive(Entity.envObj.length, this.x, this.y)
			nhf.choice = choice;
			nhf.num = num;
			return nhf;
		}
		private function bindChoice(eevt:EntityEvent): void {
			choice = eevt.sig;
			stage.removeEventListener(EntityEvent.BUTTONPRESS + "g", bindChoice);
		}
	}
	
}

package  {
	
	import API.*;
	import flash.events.Event;
	
	public class highfive_spawner extends Spawner {
		private var nhf:HighFive;

		public function highfive_spawner() { }
		
		override public function bindEnterFrame(evt:Event): void {
			if(this.x > 0 && this.x < stage.stageWidth){
				spawn();
			}
		}
		override public function create_obj(): Entity {
			return new HighFive(Entity.envObj.length, this.x, this.y);
		}
	}
	
}

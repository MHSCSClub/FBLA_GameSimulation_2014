package  {
	
	import API.*;
	import flash.events.Event;
	
	public class appear_sensor extends Sensor{
		
		private var _gave:Boolean = false;

		public function appear_sensor() { 
				this.visible = true;
		}
		
		override public function create_event(ett:Entity): void {
			if(ett is Player && !_gave) {
				dispatchEvent(new EntityEvent(EntityEvent.APPEAR + "ground", ""));
				this.nextFrame();
				_gave = true;
			}
		}

	}
	
}

package  {
	
	import API.*;
	
	public class word_sensor extends Sensor{
		
		public var _word:String;
		public var _def:String;

		public function word_sensor() {
			this.visible = true;
		}
		override public function create_event(ett:Entity): void {
			dispatchEvent(new EntityEvent(EntityEvent.WORDDEF, _def));
		}

	}
	
}

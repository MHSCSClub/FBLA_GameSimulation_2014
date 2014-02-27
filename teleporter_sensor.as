package  {
	
	import API.*;
	
	public class teleporter_sensor extends Sensor {
		
		private var _gave:Boolean = false;
		
		public var x_coor:int = -1000;
		public var y_coor:int = 390;

		public function teleporter_sensor() { 
				this.visible = true;
		}
		
		override public function create_event(ett:Entity): void {
			if(ett is Player && !_gave) {
				Entity.envObj[Player.p_sig].y = y_coor;
				for(var i:int = 0; i < Entity.envObj.length; ++i){
					Entity.envObj[i].scroll_obj(x_coor, 0);
				}
				this.visible = false;
				_gave = true;
			}
		}
	}
	
}

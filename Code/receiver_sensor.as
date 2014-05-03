package  {
	
	import API.*;
	import flash.events.Event;
	import flash.display.Shape;
	import flash.display.MovieClip;
	
	public class receiver_sensor extends Sensor{
		
		private var _gave:Boolean = false;
		
		public function receiver_sensor() {
			this.visible = true;
		}
		override public function create_event(ett:Entity): void {
			if(ett is Player && Player.smile_count > 0 && !_gave) {
				Player.negotiation_skill = true;
				var c = new negotiation_plus();
				c.x = (this.width - c.width) / 2 + this.x;
				c.y = (this.height - c.height) / 2 + this.y;
				c.addEventListener(Event.ENTER_FRAME, c.bindEnterFrame);
				c.addEventListener(EntityEvent.DEATH + "c", c.despawn);
				(root as MovieClip).addChild(c);
				Entity.envObj.push(c);
				this.gotoAndPlay(2);
				_gave = true;
			}
		}
	}
	
}

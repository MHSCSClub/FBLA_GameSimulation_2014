package  {
	
	import API.*;
	import flash.events.Event;
	import flash.display.Shape;
	import flash.display.MovieClip;
	
	public class fdestination_sensor extends Sensor{
		
		private var _gave:Boolean = false;

		public function fdestination_sensor() {
			this.visible = true;
		}
		
		override public function create_event(ett:Entity): void {
			if(ett is Follower && !_gave) {
				Player.leadership_skill = true;
				dispatchEvent(new EntityEvent(EntityEvent.HITSENSOR + "REACHEDDEST", "REACHEDDEST"));
				var c = new leadership_plus();
				c.x = (this.width - c.width) / 2 + this.x;
				c.y = (this.height - c.height) / 2 + this.y;
				c.addEventListener(Event.ENTER_FRAME, c.bindEnterFrame);
				c.addEventListener(EntityEvent.DEATH + "l", c.despawn);
				(root as MovieClip).addChild(c);
				Entity.envObj.push(c);
				this.nextFrame();
				_gave = true;
			}
		}

	}
	
}

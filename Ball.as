package  {
	
	import flash.display.MovieClip;
	import API.Entity
	import flash.events.Event;
	
	public class Ball extends Entity{
		
		public function Ball() {
			super(this.x, this.y);
			this.frictionEnabled = false; //We don't want friction
			this.slideDecreaseMultiplier = .998;
			this.bounceBasePower = 30;
			this.bounceBackHeight = .9;
		}
		public function bindEnterFrame(evt:Event){
			this.entity_update();
		}
	}
}

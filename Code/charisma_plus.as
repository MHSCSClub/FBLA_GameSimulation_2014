package  {
	
	import flash.display.MovieClip;
	import API.*;
	import flash.events.Event;
	
	public class charisma_plus extends Environment{
		
		
		public function charisma_plus() {
			this.moveThroughEnabled = false;
			this.fallThroughEnabled = false;
			this.jumpThroughEnabled = false;
		}
		public function bindEnterFrame(evt:Event): void {
			this.alpha -= .04;
		}
		public function despawn(eevt:EntityEvent): void {
			this.removeEventListener(Event.ENTER_FRAME, bindEnterFrame);
			this.removeEventListener(EntityEvent.DEATH + "c", despawn);
			(root as MovieClip).removeChild(this);
		}
	}
	
}

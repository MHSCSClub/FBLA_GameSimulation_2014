package  {
	
	import flash.display.MovieClip;
	import API.*;
	import flash.events.Event;
	
	public class leadership_plus extends Environment{
		
		
		public function leadership_plus() {
			this.moveThroughEnabled = true;
			this.fallThroughEnabled = true;
			this.jumpThroughEnabled = true;
		}
		public function bindEnterFrame(evt:Event): void {
			this.alpha -= .04;
		}
		public function despawn(eevt:EntityEvent): void {
			this.removeEventListener(Event.ENTER_FRAME, bindEnterFrame);
			this.removeEventListener(EntityEvent.DEATH + "l", despawn);
			(root as MovieClip).removeChild(this);
		}
	}
	
}

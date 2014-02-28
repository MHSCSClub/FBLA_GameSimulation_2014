package  {
	
	import API.*;
	import flash.events.Event;
	
	public class Infotable extends Environment{

		public function Infotable() {
			this.fallThroughEnabled = true;
			this.eventFrameBind = true;
			trace(Player.current_level);
			if(Player.current_level >= 7) {
				this.gotoAndPlay(2);
			}
		}
		public function construct(): void {
			this.addEventListener(Event.ENTER_FRAME, this.bindEnterFrame);
		}
		public function destruct(): void {
			this.removeEventListener(Event.ENTER_FRAME, this.bindEnterFrame);
		}
		public function bindEnterFrame(evt:Event): void {
			this.text_hf.text = String(Player.people_skill_count);
			this.text_led.text = String(Player.leadership_skill_count);
			this.text_neg.text = String(Player.negotiation_skill_count);
		}
		override public function scroll_obj(movex:Number, movey:Number): void { }
	}
	
}

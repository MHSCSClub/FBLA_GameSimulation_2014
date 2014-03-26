package {

	import API.*;
	import flash.events.*;

	public class DefinitionPanel extends Environment {
		
		private var _wait:int = 60;

		public function DefinitionPanel() {
			this.visible = false;
			this.eventFrameBind = true;
			this.fallThroughEnabled = true;
		}
		public function construct(): void {
			stage.addEventListener(EntityEvent.WORDDEF, displayDef, true);
			stage.addEventListener("LEVEL_DONE", dissappear, true);
		}
		public function destruct(): void {
			stage.removeEventListener(EntityEvent.WORDDEF, displayDef, true);
			stage.removeEventListener("LEVEL_DONE", dissappear, true);
		}
		public function displayDef(etvt:EntityEvent): void {
			this.visible = true;
			this.text_def.text = etvt.sig;
			this.alpha = 1;
			_wait = 120;
			this.addEventListener(Event.ENTER_FRAME, this.bindEnterFrame);
		}
		private function dissappear(evt:Event): void {
			this.visible = false;
		}
		private function bindEnterFrame(evt: Event): void {
			if(_wait-- >= 0)
				return;
			if (this.alpha <= 0) {
				this.visible = false;
				this.alpha = 1;
				_wait = 120;
				this.removeEventListener(Event.ENTER_FRAME, this.bindEnterFrame);
				return;
			}
			this.alpha -= .01;
		}
		override public function scroll_obj(movex: Number, movey: Number): void {}
	}

}
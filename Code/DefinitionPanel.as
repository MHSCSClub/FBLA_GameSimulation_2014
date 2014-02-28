package  {
	
	import API.*;
	
	public class DefinitionPanel extends Environment {
		
		public function DefinitionPanel() {
			stage.addEventListener(EntityEvent.WORDDEF, displayDef, true);
			this.visible = true;
			this.fallThroughEnabled = true;
		}
		public function displayDef(etvt:EntityEvent): void {
			this.text_def.text = etvt.sig;
		}
		override public function scroll_obj(movex:Number, movey:Number): void { }
	}
	
}

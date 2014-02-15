package {

	import API.*;
	import flash.events.Event;

	public class QuizPanel extends Environment {

		private var _correct:int = 0;
		public var _ini:Boolean = false;
		public static var WordDef: Array = [];

		public function QuizPanel() {
			this.fallThroughEnabled = true;
			this.eventFrameBind = true;
			this.visible = false;
		}
		public function construct(): void {
			stage.addEventListener("LEVEL_DONE", quiz, true);
		}
		public function destruct(): void {
			stage.removeEventListener("LEVEL_DONE", quiz, true);
		}
		public function quiz(evt:Event): void {
			dispatchEvent(new Event("PAUSE"));
			for (var i: Number = 0; i < WordDef.length; i++) {
				var randomNum_num = Math.floor(Math.random() * WordDef.length)
				var arrayIndex = WordDef[i];
				WordDef[i] = WordDef[randomNum_num];
				WordDef[randomNum_num] = arrayIndex;
			}
			_correct = Math.random() * 3 + 1;
			trace(_correct);
			this.text_question.appendText(" " + WordDef[_correct - 1]._word + " mean?");
			this.text_ans1.appendText(WordDef[0]._def);
			this.text_ans2.appendText(WordDef[1]._def);
			this.text_ans3.appendText(WordDef[2]._def);
			this.visible = true;
			stage.addEventListener(EntityEvent.BUTTONPRESS, checkans, true);
			return;
		}
		public function checkans(etvt:EntityEvent): void {
			if(etvt.sig == _correct) {
				dispatchEvent(new Event("NEXT_LEVEL"));
			} else {
				dispatchEvent(new Event("NO_TIME"));
			}
		}
		override public function scroll_obj(movex:Number, movey:Number): void { }
	}

}
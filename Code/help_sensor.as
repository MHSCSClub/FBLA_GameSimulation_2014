package  {
	
	import API.*;
	
	public class help_sensor extends Sensor {
		
		private var _id:int = 0;
		
		public static var help_prompts:Array = [
		"Use arrow keys to move.",
		"Am I being annoying? Space to close me.",
		"Skill 1: Time management! Finish the level in the given time.",
		"Press up to jump",
		"Hold up for a higher jump",
		"Skill 2: Charisma! Shake my hand.",
		"Skill 3: Leadership! Touch me and I'll follow you",
		"Lead me to the computer",
		"Skill 4: Learning! Learn new words each level.",
		"Skill 5: Negotiation! Pick up this smile.",
		"Bring it to me! The more smiles you bring the higher the score!",
		"Go in the elevator to finish the level.",
		"Go to the table!",
		"P to pause"
		];
		
		public function help_sensor() {
			this.visible = true;
		}
		public function setID(id:int): void { _id = id }
		override public function create_event(ett:Entity): void {
			dispatchEvent(new EntityEvent(EntityEvent.WORDDEF, help_prompts[_id]));
		}
	}
	
}

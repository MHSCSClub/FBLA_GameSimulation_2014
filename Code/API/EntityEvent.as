package API {
	
	import flash.events.*;
	
	public class EntityEvent extends Event {
		
		private var _sig;
		
		public static const DEATH:String = "entityDeath";
		public static const HITSENSOR:String = "hitSensor";
		public static const WORDDEF:String = "wordDef";
		public static var BUTTONPRESS:String = "buttonPress";
		public static var APPEAR:String = "appear";
		public static var COMPETITION_CHOICE:String = "competitionChoice";

		public function EntityEvent(type:String, sig, bubbles:Boolean=false, cancelable:Boolean=true) {
			super(type, bubbles, cancelable);
			_sig = sig;
		}
		public function get sig() {
			return _sig;
		}
		override public function clone(): Event {
			return new EntityEvent(type, sig, bubbles, cancelable);
		}
		override public function toString(): String {
			return formatToString("EntityEvent " + type + " " + sig);
		}
	}
	
}
/*
	Entity class
	An entity is anything that is affected by gravity/physics
	THIS CLASS SHOULD NOT BE CONSTRUCTED DIRECTLY
	Use this class only through inheritance
*/
package  {
	
	import flash.display.MovieClip;
	
	public class Entity extends MovieClip{
		private var _currentGravity = gravityBasePower;
		
		protected var onGround:Boolean = true;		
		protected var movex:Number = 0;
		protected var movey:Number = 0;
		
		public var gravityEnabled:Boolean = true;
		public var gravityBasePower:Number = 8;
		public var gravityIncreaseMultiplier:Number = 1.4;
		
		
		public function Entity(nx:int = 0, ny:int = 0) {
			this.x = nx + this.width / 2;
			this.y = ny + this.height / 2;
		}
		
		//Functionality, physics is provided by update
		public function entity_update():void {
			var stage_limit_l:Number = 0 + this.width / 2;
			var stage_limit_r:Number = this.stage.stageWidth - this.width / 2;
			
			var nx:Number = this.x + movex;
			if(nx > stage_limit_l && nx < stage_limit_r)
				this.x = nx;
			
			//temporary variable for debugging purposes
			var t_ground:Number = this.stage.stageHeight - this.height / 2;
			var ny:Number = this.y + movey;
			if(ny <= t_ground) //Limit still has to be implemented
				this.y = ny;
			
			//Gravity
			if(gravityEnabled){
				ny = this.y + _currentGravity;
				if(ny <= t_ground){
					this.y = ny;
					_currentGravity *= gravityIncreaseMultiplier;
					onGround = false;
				}else if(!onGround){
					this.y = t_ground;
					_currentGravity = gravityBasePower;
					onGround = true;
				}
				
			}
			
			//Reset variables
			movex = 0;
			movey = 0;
		}
		

	}
	
}

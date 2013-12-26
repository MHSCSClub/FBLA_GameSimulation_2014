/*
	Entity class
	An entity is anything that is affected by gravity/physics
	THIS CLASS SHOULD NOT BE CONSTRUCTED DIRECTLY
	Use this class only through inheritance
	List of physics:
	Gravity (imp)
	Bouncing (imp)
	Friction (imp)
	Bouncing (TODO)
*/
package  {
	
	import flash.display.MovieClip;
	
	public class Entity extends MovieClip{
		private var _currentGravity:Number = gravityBasePower;
		
		private var _currentBounce:Number = bounceBasePower;
		private var _maxHeightReached:Number = Number.MAX_VALUE;
		private var _bounceHeight:int = 0;
		
		protected var onGround:Boolean = false;		
		protected var movex:Number = 0;
		protected var movey:Number = 0;
		
		public var gravityEnabled:Boolean = true;
		public var gravityBasePower:Number = 8;
		public var gravityIncreaseMultiplier:Number = 1.4;
		
		public var bounceEnabled:Boolean = true;
		public var bounceBackHeight:Number = 0.5;
		public var bounceBasePower:Number = 20;
		public var bounceIncreaseMultiplier:Number = 1;
		
		public var frictionEnabled:Boolean = true;
		public var frictionMultiplier:Number = 0.2;
		
		public function Entity(nx:int = 0, ny:int = 0) {
			this.x = nx + this.width / 2;
			this.y = ny + this.height / 2;
		}
		
		//Functionality, physics is provided by update
		public function entity_update(): void {
			var stage_limit_l:Number = 0 + this.width / 2;
			var stage_limit_r:Number = this.stage.stageWidth - this.width / 2;
			
			//Friction
			if(frictionEnabled && onGround)
				movex *= frictionMultiplier;
			
			var nx:Number = this.x + movex;
			if(nx > stage_limit_l && nx < stage_limit_r)
				this.x = nx;
			
			//temporary variable for debugging purposes
			var t_ground:Number = this.stage.stageHeight - this.height / 2;
			var ny:Number = this.y + movey;
			if(ny <= t_ground) //Limit still has to be implemented
				this.y = ny;
			
			if(!onGround && this.y < _maxHeightReached)
				_maxHeightReached = this.y;
			
			//Bounce
			if(bounceEnabled){
				if(onGround){
					_bounceHeight = this.y - (this.y - _maxHeightReached) * bounceBackHeight;
					gravityEnabled = false;
					onGround = false;
				}
				if(_bounceHeight != 0){
					ny = this.y - _currentBounce;
					if(ny >= _bounceHeight){
						this.y = ny;
						_currentBounce *= bounceIncreaseMultiplier;
					}else{
						this.y = _bounceHeight;
						_currentBounce = bounceBasePower;
						_maxHeightReached = _bounceHeight;
						_bounceHeight = 0;
						gravityEnabled = true;
					}
				}
			}
			
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
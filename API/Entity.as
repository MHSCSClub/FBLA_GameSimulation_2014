/*
	Entity class
	An entity is anything that is affected by gravity/physics
	THIS CLASS SHOULD NOT BE CONSTRUCTED DIRECTLY
	Use this class only through inheritance
	List of physics:
	Gravity
	Bouncing
	Friction 
	Sliding
*/
package API {
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.display.Shape;
	
	public class Entity extends MovieClip{
		private var _currentGravity:Number = gravityBasePower;
		
		private var _currentBounce:Number = bounceBasePower;
		private var _maxHeightReached:Number = Number.MAX_VALUE;
		private var _bounceHeight:int = 0;
		
		private var _currentSlide:int = 0;
		private var _isSliding:Boolean = false;
		
		protected var onGround:Boolean = false;
		protected var movex:Number = 0;
		protected var movey:Number = 0;
		
		protected var testPoint:Array = [];
		
		public var gravityEnabled:Boolean = true;
		public var gravityBasePower:Number = 8;
		public var gravityIncreaseMultiplier:Number = 1.4;
		
		public var bounceEnabled:Boolean = true;
		public var bounceBackHeight:Number = 0.5;
		public var bounceBasePower:Number = 20;
		public var bounceIncreaseMultiplier:Number = 1;
		
		public var frictionEnabled:Boolean = true;
		public var frictionMultiplier:Number = 0.2;
		
		public var slidingEnabled:Boolean = true;
		public var slideDecreaseMultiplier = .9;
		
		public static var envObj:Array = [];
		
		public function Entity(nx:int = 0, ny:int = 0) {
			this.x = nx + this.width / 2;
			this.y = ny + this.height / 2;
			var np:Point = new Point();
			testPoint.push(np);
		}
		
		//Functionality, physics is provided by update
		public function entity_update(): void {
			var stage_limit_l:Number = 0 + this.width / 2;
			var stage_limit_r:Number = this.stage.stageWidth - this.width / 2;
			
			//Friction
			if(frictionEnabled && onGround)
				movex *= frictionMultiplier;
			
			//Sliding
			if(slidingEnabled){
				if(movex != 0 && !_isSliding){
					_currentSlide = movex;
				} else if(movex == 0 && !_isSliding) {
					_isSliding = true;
				} else if(movex != 0 && _isSliding){
					_isSliding = false;
				}
				if(_isSliding && movex == 0){
					movex += _currentSlide;
					_currentSlide *= slideDecreaseMultiplier;
				}
			}
			
			var nx:Number = this.x + movex;
			if(nx > stage_limit_l && nx < stage_limit_r)
				this.x = nx;
			else{
				var closer:Number = nx <= stage_limit_l ? stage_limit_l : stage_limit_r;			
				this.x = closer;
			}
			
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
					_bounceHeight = Math.ceil(this.y - (this.y - _maxHeightReached) * bounceBackHeight);
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
				if(!gravity_collision(ny)){
					_currentGravity *= gravityIncreaseMultiplier;
					onGround = false;
				}else if(!onGround){
					gravity_collision(ny);
					_currentGravity = gravityBasePower;
					onGround = true;
				}
			}
			
			//Reset variables
			movex = 0;
			movey = 0;
		}
		public function gravity_collision(ny:Number): Boolean {
			var nl:Shape = new Shape();
			var isCollision:Boolean = false;
			var collidobj:Environment;
			nl.graphics.lineStyle(1, 0xFF0000, 1);
			nl.graphics.moveTo(this.x, this.y + this.height / 2);
			nl.graphics.lineTo(this.x, ny + this.height / 2);
			//stage.addChild(nl);
			for(var i:int = 0; i < envObj.length; ++i){
				if(envObj[i].hitTestObject(nl)){
					isCollision = true;
					collidobj = envObj[i];
					//trace("Collision!");
					break;
				}
			}
			nl.graphics.clear();
			
			//If there are no collisions, return
			if(!isCollision){
				this.y = ny;
				return false;
			}
			
			for(var p:int = this.y + this.height / 2; p < ny + this.height / 2; ++p){
				if(collidobj.hitTestPoint(this.x, p, true)){
/*					nl.graphics.moveTo(this.x, this.y);
					nl.graphics.lineTo(this.x, p);
					stage.addChild(nl);
					nl.graphics.lineStyle(1, 0x00FF00, 1);*/
					//trace(p);
					this.y = p - this.height / 2;
					break;
				}
			}
			return true;
		}
	}
}
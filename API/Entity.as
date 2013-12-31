/*
	Entity class
	An entity is anything that is affected by gravity/physics
	THIS CLASS SHOULD NOT BE CONSTRUCTED DIRECTLY
	Use this class ohly through inheritance
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
		
		//Testpoint: 0-none, 1-left, 2-right, 3-down, 4-up
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
		
		public var environmentSetVariablesEnabled:Boolean = true;
		
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
			
/*			var nx:Number = this.x + movex;
			if(nx > stage_limit_l && nx < stage_limit_r)
				this.x = nx;
			else{
				var closer:Number = nx <= stage_limit_l ? stage_limit_l : stage_limit_r;			
				this.x = closer;
			}*/
			if(movex != 0)
				move_collision(this.x + movex);
			
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
			var vl:Shape = new Shape();
			var isCollision:Boolean = false;
			var collidobj:Array = [];
			
			vl.graphics.lineStyle(1, 0xFF0000, 1);
			for(var i:int = 0; i < envObj.length; ++i){
				for(var p:int = 1; p <= 2; ++p){
					vl.graphics.moveTo(this.x + testPoint[p], this.y + testPoint[3]);
					vl.graphics.lineTo(this.x + testPoint[p], ny + testPoint[3]);
					
					//stage.addChild(vl); //Uncomment for debug
					
					if(envObj[i].hitTestObject(vl)){
						collidobj.push(envObj[i]);
					}
				}
			}
			vl.graphics.clear(); //Comment for debug
			
			//If there are no collisions, return
			if(collidobj.length == 0){
				this.y = ny;
				return false;
			}
			
			var dl:Shape = new Shape();
			collidobj.sort(Environment.less_y);
			for(var q:int = 0; q < collidobj.length; ++q){
				for(p = 1; p <= 2; ++p){
				for(i = this.y + testPoint[3]; i < ny + testPoint[3]; ++i){
						if(collidobj[q].hitTestPoint(this.x + testPoint[p], i, true) && 
							!collidobj[q].hitTestPoint(this.x + testPoint[p], i - 1, true)){
							//Debugging lines
/*							dl.graphics.lineStyle(10, 0x00FF00, 10);
							dl.graphics.moveTo(this.x + testPoint[p], i);
							dl.graphics.lineTo(this.x + testPoint[p], i - 1);
							stage.addChild(dl);*/
							
							this.y = i - this.height / 2;
							if(environmentSetVariablesEnabled)
								collidobj[q].setVariables(this);
							return true;
						}
					}
				}
			}
			this.y = ny;
			return false;
		}
		public function move_collision(nx:Number) : Boolean {
			var hl:Shape = new Shape;
			var isCollision:Boolean = false;
			var collidobj:Array = [];
			
			hl.graphics.lineStyle(1, 0xFF0000, 1);
			for(var i:int = 0; i < envObj.length; ++i){
				for(var p:int = 3; p <= 4; ++p){
					for(var q:Number = -this.height / 4; q < this.height / 2; q += this.height / 4){
						var setPoint:Number;
						if(nx - this.x > 0){
							setPoint = this.x + testPoint[2]; //moving to the right
						} else {
							setPoint = this.x + testPoint[1]; //moving to the left
						}
						hl.graphics.moveTo(setPoint, this.y + q);
						hl.graphics.lineTo(nx + setPoint - this.x, this.y + q);
						//stage.addChild(hl);
						if(envObj[i].hitTestObject(hl)){
							collidobj.push(envObj[i]);
						}
					}
				}
			}
			hl.graphics.clear();
			if(collidobj.length == 0){
				this.x = nx;
				return false;
			}
			collidobj.sort(Environment.less_x);
//			for(i = setPoint; i < nx; ++i){
//				for(var r:int = 0; q < collidobj.length; ++q){
//					if(collidobj[q].hitTestPoint(i, this.y, true)){
//						//Debugging lines
///*						dl.graphics.lineStyle(10, 0x00FF00, 10);
//						dl.graphics.moveTo(this.x + testPoint[p], i);
//						dl.graphics.lineTo(this.x + testPoint[p], i - 1);
//						stage.addChild(dl);*/
//						
//						this.x = i;
//						return true;
//					}
//				}
//			}
			return true;
		}
	}
}
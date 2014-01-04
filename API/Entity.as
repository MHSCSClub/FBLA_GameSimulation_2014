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
		
		protected var g_testpoint:Array = [];
		protected var x_testpoint:Array = [];
		
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
			this.x = nx;
			this.y = ny;
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
			} else {
				_currentSlide = 0;
			}
			
			if(movex != 0)
				move_collision(this.x + movex);
			
			if(movey < 0){
				jump_collision(this.y + movey)
			}else if(movey > 0) {
				gravity_collision(this.y + movey);
			}
			
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
					var ny:Number = this.y - _currentBounce;
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
					//trace("air");
				}else if(!onGround){
					gravity_collision(ny);
					_currentGravity = gravityBasePower;
					onGround = true;
					//trace("onground");
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
				for(var p:int = 0; p < g_testpoint.length; ++p){
					vl.graphics.moveTo(this.x + g_testpoint[p], this.y + this.height / 2);
					vl.graphics.lineTo(this.x + g_testpoint[p], ny + this.height / 2);
					
					//stage.addChild(vl); //Uncomment for debug
					
					if(envObj[i].hitTestObject(vl) && !envObj[i].fallThroughEnabled){
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
			for(i = 0; i < collidobj.length; ++i){
				for(p = 0; p <= g_testpoint.length; ++p){
					for(var q:Number = this.y; q < ny + this.height / 2; ++q){
						if(collidobj[i].hitTestPoint(this.x + g_testpoint[p], q, true) && 
							!collidobj[i].hitTestPoint(this.x + g_testpoint[p], q - 1, true)){
							
/*							dl.graphics.lineStyle(10, 0x00FF00, 10);
							dl.graphics.moveTo(this.x + g_testpoint[p], q - 1);
							dl.graphics.lineTo(this.x + g_testpoint[p], q);
							stage.addChild(dl);*/
							
							this.y = q - this.height / 2;
							if(environmentSetVariablesEnabled)
								collidobj[i].setVariables(this);
							return true;
						}
					}
				}
			}
			this.y = ny;
			return false;
		}
		public function jump_collision(ny:Number): Boolean {
			var vl:Shape = new Shape();
			var isCollision:Boolean = false;
			var collidobj:Array = [];
			
			vl.graphics.lineStyle(1, 0xFF0000, 1);
			for(var i:int = 0; i < envObj.length; ++i){
				for(var p:int = 0; p < g_testpoint.length; ++p){
					vl.graphics.moveTo(this.x + g_testpoint[p], this.y - this.height / 2);
					vl.graphics.lineTo(this.x + g_testpoint[p], ny - this.height / 2);
					
					//stage.addChild(vl); //Uncomment for debug
					
					if(envObj[i].hitTestObject(vl) && !envObj[i].jumpThroughEnabled){
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
			for(i = 0; i < collidobj.length; ++i){
				for(p = 0; p <= g_testpoint.length; ++p){
					for(var q:Number = this.y - this.height / 2; q > ny - this.height / 2; --q){
						if(collidobj[i].hitTestPoint(this.x + g_testpoint[p], q, true)){
							
							this.y = q + this.height / 2;
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
			var setPoint:Number = 0;
			var inc:int = 0;
			
			if(nx - this.x > 0){
				setPoint = this.x + this.width / 2; //moving to the right
				inc = 1;
			} else {
				setPoint = this.x - this.width / 2; //moving to the left
				inc = -1;
			}
			
			hl.graphics.lineStyle(1, 0xFF0000, 1);
			for(var i:int = 0; i < envObj.length; ++i){
				for(var p:int = 0; p < x_testpoint.length; ++p){
					hl.graphics.moveTo(setPoint, this.y + x_testpoint[p]);
					hl.graphics.lineTo(nx + setPoint - this.x, this.y + x_testpoint[p]);
					
					//stage.addChild(hl);
					
					if(envObj[i].hitTestObject(hl) && !envObj[i].moveThroughEnabled){
						collidobj.push(envObj[i]);
					}
				}
			}
			hl.graphics.clear();
			if(collidobj.length == 0){
				scroll_x(nx);
				return false;
			}
			var nsetPoint:int = inc == -1 ? Math.ceil(setPoint) : setPoint;
			
			var tmp:int = nx + setPoint - this.x;
			var dl:Shape = new Shape;
			collidobj.sort(Environment.less_x);
			for(i = 0; i < collidobj.length; ++i){
				for(p = nsetPoint; p != tmp; p += inc){
					for(var q:int = 0; q < x_testpoint.length; ++q){
						if(collidobj[i].hitTestPoint(p, this.y + x_testpoint[q], true)){
							//Debug
/*							dl.graphics.lineStyle(10, 0x00FF00, 10);
							dl.graphics.moveTo(setPoint, this.y + x_testpoint[q]);
							dl.graphics.lineTo(p, this.y + x_testpoint[q]);*/
							
							stage.addChild(dl);
							scroll_x(p - (setPoint - this.x));
							return true;
						}
					}
				}
			}
			scroll_x(nx);
			return false;
		}
		public function scroll_x(nx:Number): void{
			this.x = nx;
		}
	}
}
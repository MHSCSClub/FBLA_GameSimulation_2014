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
	import flash.events.Event;
	import API.*;
	import flash.utils.Dictionary;
	
	public class Entity extends Environment {
		private var _currentGravity:Number = gravityBasePower;
		
		private var _currentBounce:Number = bounceBasePower;
		private var _maxHeightReached:Number = Number.MAX_VALUE;
		private var _bounceHeight:int = 0;
		private var _isBounce:Boolean = false;
		
		private var _currentSlide:int = 0;
		private var _isSliding:Boolean = false;
		
		protected var onGround:Boolean = false;
		protected var movex:Number = 0;
		protected var movey:Number = 0;
		
		protected var g_testpoint:Array = [];
		protected var x_testpoint:Array = [];
		
		public var health:int = 1;
		
		public var gravityEnabled:Boolean = true;
		public var gravityBasePower:Number = gravityBasePower_default;
		public var gravityIncreaseMultiplier:Number = gravityIncreaseMultiplier_default;
		
		public var bounceEnabled:Boolean = true;
		public var bounceBackHeight:Number = bounceBackHeight_default;
		public var bounceBasePower:Number = bounceBasePower_default;
		public var bounceIncreaseMultiplier:Number = bounceIncreaseMultiplier_default;
		
		public var frictionEnabled:Boolean = true;
		public var frictionMultiplier:Number = frictionMultiplier_default;
		
		public var slidingEnabled:Boolean = true;
		public var slideDecreaseMultiplier = slideDecreaseMultiplier_default;
		
		public static var envObj:Array = [];
		
		public static const gravityBasePower_default:Number = 8;
		public static const gravityIncreaseMultiplier_default:Number = 3.5;
		
		public static const bounceBackHeight_default:Number = 0.5;
		public static const bounceBasePower_default:Number = 25;
		public static const bounceIncreaseMultiplier_default:Number = 2;
		
		public static const frictionMultiplier_default:Number = 0.2;
		
		public static const slideDecreaseMultiplier_default:Number = .9;
		
		public var yRect:Shape = new Shape();
		public var yLines:Array = [];
		public var xLines:Array = [];
		
		public function Entity(nsig:int, nx:Number = 0, ny:Number = 0) {
			this.sig = nsig;
			this.x = nx;
			this.y = ny;
		}
		
		public function reset_all_default(): void {
			gravityBasePower = gravityBasePower_default;
			gravityIncreaseMultiplier = gravityIncreaseMultiplier_default;
			bounceBackHeight = bounceBackHeight_default;
			bounceBasePower = bounceBasePower_default;
			bounceIncreaseMultiplier = bounceIncreaseMultiplier_default;
			frictionMultiplier = frictionMultiplier_default;
			slideDecreaseMultiplier = slideDecreaseMultiplier_default;
		}
		public function bindEnterFrame(evt:Event): void { }
		
		//Functionality, physics is provided by update
		public function entity_update(): void {
			for(var i:int = 0; i < g_testpoint.length; ++i) {
				yLines.push(new Shape());
			}
			for(i = 0; i < x_testpoint.length; ++i) {
				xLines.push(new Shape());
			}
			
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
			
			move_collision(this.x + movex);
			
			if(movey < 0){
				jump_collision(this.y + movey)
			}else if(movey > 0) {
				gravity_collision(this.y + movey);
			}
			
			if(!onGround && this.y < _maxHeightReached)
				_maxHeightReached = this.y;
			else if(onGround && !bounceEnabled)
				_maxHeightReached = Number.MAX_VALUE;
			
			//Bounce
			if(bounceEnabled){
				if(onGround){
					_isBounce = true
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
					_currentGravity += gravityIncreaseMultiplier;
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
			var isCollision:Boolean = false;
			var collidobj:Array = [];

			for(var i:int = 0; i < envObj.length; ++i){
				var count:int = 0;
				for(var p:int = 0; p < g_testpoint.length; ++p){
					yLines[p].graphics.clear();
					yLines[p].graphics.beginFill(0xFF0000);
					yLines[p].graphics.moveTo(this.x + g_testpoint[p], this.y + this.height);
					yLines[p].graphics.lineTo(this.x + g_testpoint[p], ny);
					
					if(g_collid_hit_test(envObj[i], yLines[p]) && !envObj[i].fallThroughEnabled && envObj[i] != this){
						++count;
					}
				}
				if(count > 0) {
					collidobj.push(envObj[i]);
				}

			}
			//If there are no collisions, return
			if(collidobj.length == 0){
				this.y = ny;
				return false;
			}
			
			var dl:Shape = new Shape();
			collidobj.sort(Environment.less_y);
			for(i = 0; i < collidobj.length; ++i){
				for(p = 0; p <= g_testpoint.length; ++p){
					for(var q:int = this.y + this.height - 5; q < ny + this.height; ++q){
						if(collidobj[i].hitTestPoint(this.x + g_testpoint[p], q, true)){
							
							/*dl.graphics.lineStyle(10, 0x00FF00, 10);
							dl.graphics.moveTo(this.x + g_testpoint[p], q - 1);
							dl.graphics.lineTo(this.x + g_testpoint[p], q);
							stage.addChild(dl); */
							
							this.y = q - this.height;
							g_env_set_var(collidobj[i]);
							return true;
						}
					}
				}
			}
			this.y = ny;
			return false;
		}
		public function g_collid_hit_test(c_obj:Environment, ln:Shape): Boolean {
			return c_obj.hitTestObject(ln);
		}
		public function g_env_set_var(c_obj:Environment): void {
			c_obj.g_setVariables(this);
		}
		public function jump_collision(ny:Number): Boolean {
			var isCollision:Boolean = false;
			var collidobj:Array = [];
			
			for(var i:int = 0; i < envObj.length; ++i){
				var count:int = 0;
				for(var p:int = 0; p < g_testpoint.length; ++p){
					yLines[p].graphics.clear();
					yLines[p].graphics.lineStyle(1, 0xFF0000, 1);
					yLines[p].graphics.moveTo(this.x + g_testpoint[p], this.y);
					yLines[p].graphics.lineTo(this.x + g_testpoint[p], ny);
					//stage.addChild(yLines[p]);
					
					
					if(j_collid_hit_test(envObj[i], yLines[p]) && !envObj[i].jumpThroughEnabled && envObj[i] != this){
						++count;
					}
				}
				if(count > 0) {
					collidobj.push(envObj[i]);
				}
			}
			//If there are no collisions, return
			if(collidobj.length == 0){
				this.y = ny;
				return false;
			}
			var dl:Shape = new Shape();
			collidobj.sort(Environment.less_y);
			for(i = 0; i < collidobj.length; ++i){
				for(p = 0; p <= g_testpoint.length; ++p){
					for(var q:int = this.y; q > ny; --q){
						if(collidobj[i].hitTestPoint(this.x + g_testpoint[p], q, true)){
							
							this.y = Math.ceil(q);
							j_env_set_var(collidobj[i]);
							return true;
						}
					}
				}
			}
			this.y = ny;
			return false;
		}
		public function j_collid_hit_test(c_obj:Environment, ln:Shape): Boolean {
			return c_obj.hitTestObject(ln);
		}
		public function j_env_set_var(c_obj:Environment) {
			c_obj.j_setVariables(this);
		}
		public function move_collision(nx:Number) : Boolean {
			var isCollision:Boolean = false;
			var collidobj:Array = [];
			var setPoint:Number = 0;
			var inc:int = 0;
			var tpoint = this.x;
			
			if(nx - this.x > 0){
				setPoint = this.x + this.width; //moving to the right
				inc = 1;
			} else {
				setPoint = this.x; //moving to the left
				inc = -1;
			}
			
			for(var i:int = 0; i < envObj.length; ++i){
				var count:int = 0;
				for(var p:int = 0; p < x_testpoint.length; ++p){
					xLines[p].graphics.clear();
					xLines[p].graphics.lineStyle(1, 0xFF0000, 1);
					xLines[p].graphics.moveTo(setPoint, this.y + x_testpoint[p]);
					xLines[p].graphics.lineTo(nx + setPoint - tpoint, this.y + x_testpoint[p]);
					//stage.addChild(xLines[p]);
					
					if(x_collid_hit_test(envObj[i], xLines[p]) && envObj[i] != this){
						++count;
					}
				}
				if(count > 0) {
					collidobj.push(envObj[i]);
				}
			}
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
							
							//stage.addChild(dl);
							x_env_set_var(collidobj[i]);
							if(!collidobj[i].moveThroughEnabled){
								scroll_x(p - (setPoint - this.x));
								return true;
							}
						}
					}
				}
			}
			scroll_x(nx);
			return false;
		}
		public function x_collid_hit_test(c_obj:Environment, ln:Shape): Boolean {
			return c_obj.hitTestObject(ln);
		}
		public function x_env_set_var(c_obj:Environment) {
			c_obj.x_setVariables(this);
		}
		public function scroll_x(nx:Number): void{
			this.x = nx;
		}
	}
}
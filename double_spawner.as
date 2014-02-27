package  {
	
	import API.*;
	
	public class double_spawner extends spike_spawner{

		public function double_spawner() { }
		override public function create_obj(): Entity {
			return new DoubleSpike(Entity.envObj.length, this.x, this.y);
		}

	}
	
}

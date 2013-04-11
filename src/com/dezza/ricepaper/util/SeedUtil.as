package com.dezza.ricepaper.util
{
	/**
	 * @author derek
	 */
	public class SeedUtil
	{
		public var rndSeed : Number = -1;


		public function SeedUtil(seed : Number = NaN)
		{
			setSeed(seed);
		}


		// seeded random number functions
		public function setSeed(_seed : Number = NaN) : void
		{
			if ( isNaN(_seed) )
			{
				var d : Date = new Date();
				_seed = d.getMilliseconds();
			}

			rndSeed = _seed;

			rndF(100);
		}


		public function rndBool() : Boolean
		{
			var val : Number;
			rndSeed = (rndSeed * 16807) % 2147483647;
			val = (rndSeed / 2147483647);
			return val > 0.5;
		}


		public function rndProb(prob : Number) : Boolean
		{
			var val : Number;
			rndSeed = (rndSeed * 16807) % 2147483647;
			val = (rndSeed / 2147483647);
			return val > prob;
		}


		public function rndI(min : Number, max : Number = NaN) : Number
		{
			var val : Number;
			rndSeed = (rndSeed * 16807) % 2147483647;
			val = (rndSeed / 2147483647);
			if ( isNaN(max) ) return Math.floor(val * min);
			return Math.floor(val * (max - min) + min);
		}


		public function rndF(min : Number, max : Number = NaN) : Number
		{
			var val : Number;
			rndSeed = (rndSeed * 16807) % 2147483647;
			val = (rndSeed / 2147483647);
			if ( isNaN(max) ) return val * min;
			return val * (max - min) + min;
		}
	}
}

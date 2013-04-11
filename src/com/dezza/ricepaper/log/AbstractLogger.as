package com.dezza.ricepaper.log
{

	import com.dezza.ricepaper.log.ILogger;

	/**
	 * @author derek
	 */
	public class AbstractLogger implements ILogger
	{

		protected var _logLevel : int;


		public function AbstractLogger(level : int = 2) : void
		{
			_logLevel = level;
		}


		public function log(obj : Object = null, msg : String = "", level : int = 2) : void
		{
			// implement
		}


		public function logObj(obj : Object = null, msg : String = "", level : int = 2, depthLimit : int = -1) : void
		{
			var s : String = msg + "\n" + _logObj(obj, depthLimit);
			log(obj, s, level);
		}


		public function _logObj(target : Object, depthLimit : int = -1, results : String = "", depth : int = 0) : String
		{
			if ( !target ) return results;

			if ( depth === depthLimit )
			{
				return results;
			}

			var s : String = "";

			for ( var i : int = 0; i < depth; i++)
			{
				s += "  ";
			}

			for ( var key:String in target)
			{
				results += s + "|- " + key + ":" + target[key] + "\n";

				depth++;

				// call recursively on child objects

				if ( typeof( target[key] ) == "object" )
				{
					_logObj(target[key], depth, results, depth);
				}

				depth--;
			}

			return results;
		}


		public function get logLevel() : int
		{
			return _logLevel;
		}


		public function set logLevel(level : int) : void
		{
			_logLevel = level;
		}
	}
}

package com.dezza.ricepaper.log
{
	/**
	 * @author derek
	 */
	public class TraceLogger extends AbstractLogger implements ILogger
	{

		public function TraceLogger(level : int = 2)
		{
			super(level);

			log(this, "logging started at " + (new Date()), LogLevel.INFO);
		}


		override public function log(obj : Object = null, msg : String = "", level : int = 2) : void
		{
			if ( level >= logLevel )
			{
				var s : String = LogLevel.getLevelAsString(level);

				if ( s.length < 5 )
				{
					while ( s.length < 5 ) s += " ";
				}

				trace("[ " + s + " ] " + (obj ? obj.toString() : "") + " : " + msg);
			}
		}
	}
}

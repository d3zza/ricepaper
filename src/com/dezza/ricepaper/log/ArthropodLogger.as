package com.dezza.ricepaper.log
{

	import com.carlcalderon.arthropod.Debug;

	/**
	 * @author derek
	 */
	public class ArthropodLogger extends AbstractLogger implements ILogger
	{

		public function ArthropodLogger(level : int = 2, autoClear : Boolean = true)
		{
			super(level);

			if ( autoClear ) Debug.clear();

			log(this, "logging started at " + (new Date()), LogLevel.INFO);
		}


		override public function log(obj : Object = null, msg : String = "", level : int = 2) : void
		{
			if ( level >= logLevel )
			{
				Debug.log((obj ? obj.toString() : "") + " : " + msg, LogLevel.getColor(level));
			}
		}
	}
}

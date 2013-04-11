package com.dezza.ricepaper.log
{

	import flash.system.ApplicationDomain;

	/**
	 * @author derek
	 */
	public class FlashConsoleLogger extends AbstractLogger implements ILogger
	{

		private var cc : Object;


		public function FlashConsoleLogger(level : int = 2)
		{
			super(level);

			cc = ApplicationDomain.currentDomain.getDefinition('com.junkbyte.console.Cc');

			if ( !cc ) throw new Error("Could not get definition for junkbyte console:'com.junkbyte.console.Cc'. Please ensure source libraries are compiled into project");

			log(this, "logging started at " + (new Date()), LogLevel.INFO);
		}


		override public function log(obj : Object = null, msg : String = "", level : int = 2) : void
		{
			var fn : Function;

			if ( level >= logLevel )
			{
				try
				{
					if ( level >= LogLevel.FATAL )
					{
						fn = cc.fatal;
					}
					else if ( level >= LogLevel.ERROR )
					{
						fn = cc.error;
					}
					else if ( level >= LogLevel.WARN )
					{
						fn = cc.warn;
					}
					else if ( level >= LogLevel.INFO )
					{
						fn = cc.info;
					}
					else
					{
						fn = cc.debug;
					}

					fn((obj ? obj.toString() : "") + " : " + msg);
				}
				catch( err : Error )
				{
				}
			}
		}
	}
}

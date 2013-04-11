package com.dezza.ricepaper.log
{

	import flash.external.ExternalInterface;

	/**
	 * @author derek
	 */
	public class JavascriptLogger extends AbstractLogger implements ILogger
	{

		private var jsFn : String;


		public function JavascriptLogger(level : int = 2, jsFunctionName : String = null)
		{
			super(level);

			jsFn = jsFunctionName;

			log(this, "logging started at " + (new Date()), LogLevel.INFO);
		}


		override public function log(obj : Object = null, msg : String = "", level : int = 2) : void
		{
			var fn : String;

			if ( level >= logLevel )
			{
				if ( ExternalInterface.available )
				{
					try
					{
						if ( !jsFn )
						{
							if ( level >= LogLevel.ERROR )
							{
								fn = "console.error";
							}
							else if ( level >= LogLevel.WARN )
							{
								fn = "console.warn";
							}
							else if ( level >= LogLevel.INFO )
							{
								fn = "console.info";
							}
							else if ( level >= LogLevel.DEBUG )
							{
								fn = "console.debug";
							}
							else
							{
								fn = "console.log";
							}

							ExternalInterface.call(fn, ExternalInterface.objectID + " : " + (obj ? obj.toString() : "") + " : " + msg);
						}
						else
						{
							ExternalInterface.call(fn, ExternalInterface.objectID + " : " + (obj ? obj.toString() : "") + " : " + msg, level);
						}
					}
					catch( err : Error )
					{
					}
				}
			}
		}
	}
}

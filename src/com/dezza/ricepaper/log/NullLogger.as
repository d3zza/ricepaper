package com.dezza.ricepaper.log
{
	/**
	 * @author derek
	 */
	public class NullLogger extends AbstractLogger implements ILogger
	{

		override public function log(obj : Object = null, msg : String = "", level : int = 2) : void
		{
		}
	}
}

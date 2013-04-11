package com.dezza.ricepaper.log
{
	/**
	 * @author derek
	 */
	public interface ILogger
	{

		function log(obj : Object = null, msg : String = "", logLevel : int = 2) : void;


		function logObj(obj : Object = null, msg : String = "", level : int = 2, depthLimit : int = -1) : void;


		function get logLevel() : int;


		function set logLevel(level : int) : void;
	}
}

package com.dezza.ricepaper.load
{

	import flash.events.IEventDispatcher;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;

	/**
	 * @author derek
	 */
	public interface ILoader extends IEventDispatcher
	{

		function get id() : String;


		function set id(id : String) : void;


		function get request() : URLRequest;


		function set request(request : URLRequest) : void;


		function get context() : LoaderContext;


		function set context(context : LoaderContext) : void;


		function get timeOut() : Number;


		function set timeOut(timeOut : Number) : void;


		function get preventCache() : Boolean;


		function set preventCache(preventCache : Boolean) : void;


		function get content() : Object;


		function set content(value : Object) : void;


		function start() : void;


		function stop() : void;


		function destroy() : void;
	}
}

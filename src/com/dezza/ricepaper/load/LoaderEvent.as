package com.dezza.ricepaper.load
{

	import flash.events.Event;

	/**
	 * @author derek
	 */
	public class LoaderEvent extends Event
	{

		public static const START : String = "LoaderEvent.START";

		public static const COMPLETE : String = "LoaderEvent.COMPLETE";

		public static const ERROR : String = "LoaderEvent.ERROR";

		public static const TIME_OUT : String = "LoaderEvent.TIME_OUT";

		private var _loader : ILoader;

		private var _data : Object;


		public function LoaderEvent(type : String, loader : ILoader, data : Object = null)
		{
			super(type);

			_loader = loader;

			_data = data;
		}


		public function get loader() : ILoader
		{
			return _loader;
		}


		public function get data() : Object
		{
			return _data;
		}


		override public function clone() : Event
		{
			return new LoaderEvent(type, loader, data);
		}
	}
}

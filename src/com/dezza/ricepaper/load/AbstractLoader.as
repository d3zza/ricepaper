package com.dezza.ricepaper.load
{

	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;

	/**
	 * @author derek
	 */
	public class AbstractLoader extends EventDispatcher implements ILoader
	{

		private var _id : String;

		private var _context : LoaderContext;

		private var _request : URLRequest;

		private var _timeOut : Number = 30;

		private var _preventCache : Boolean;

		// private var _timer : Timer;
		private var _content : Object;


		public function AbstractLoader()
		{
			super();
		}


		public function get id() : String
		{
			return _id;
		}


		public function set id(id : String) : void
		{
			_id = id;
		}


		public function get request() : URLRequest
		{
			return _request;
		}


		public function set request(request : URLRequest) : void
		{
			_request = request;
		}


		public function get context() : LoaderContext
		{
			return _context;
		}


		public function set context(context : LoaderContext) : void
		{
			_context = context;
		}


		public function get timeOut() : Number
		{
			return _timeOut;
		}


		public function set timeOut(timeOut : Number) : void
		{
			_timeOut = timeOut;
		}


		public function get preventCache() : Boolean
		{
			return _preventCache;
		}


		public function set preventCache(preventCache : Boolean) : void
		{
			_preventCache = preventCache;
		}


		public function get content() : Object
		{
			return _content;
		}


		public function set content(value : Object) : void
		{
			_content = value;
		}


		public function start() : void
		{
			addListeners();

			load();
		}


		public function stop() : void
		{
		}


		public function destroy() : void
		{
			stop();

			removeListeners();

			_content = null;

			_request = null;

			_context = null;

			// killTimer();
		}


		protected function load() : void
		{
			if ( !_request || !_request.url )
			{
				throw new Error("Can't start load without url request");
			}

			if ( _preventCache )
			{
				var d : Date = new Date();

				var s : String = "nocache=" + d.getTime();

				_request.url += _request.url.indexOf("?") == -1 ? "?" + s : "&" + s;
			}

			// initTimer();

			onStart();
		}


		protected function onStart() : void
		{
			dispatchEvent(new LoaderEvent(LoaderEvent.START, this));
		}


		protected function onComplete() : void
		{
			dispatchEvent(new LoaderEvent(LoaderEvent.COMPLETE, this));
		}


		protected function onError(errorMessage : String = "") : void
		{
			dispatchEvent(new LoaderEvent(LoaderEvent.ERROR, this, errorMessage));
		}


		protected function onTimeOut() : void
		{
			dispatchEvent(new LoaderEvent(LoaderEvent.TIME_OUT, this));
		}


		// protected function initTimer() : void
		// {
		// killTimer();
		// _timer = new Timer(_timeOut * 1000);
		// _timer.addEventListener(TimerEvent.TIMER, onTimer, false, 0, true );
		// _timer.start();
		// }
		//
		//
		// protected function onTimer(event : TimerEvent) : void
		// {
		// killTimer();
		//
		// onTimeOut();
		// }
		//
		//
		// protected function killTimer() : void
		// {
		// if ( _timer )
		// {
		// _timer.removeEventListener(TimerEvent.TIMER, onTimer);
		// _timer.stop();
		// _timer = null;
		// }
		// }
		protected function addListeners() : void
		{
		}


		protected function removeListeners() : void
		{
		}


		override public function toString() : String
		{
			return "[ AbstractLoader id=" + id + ", url=" + _request ? _request.url : "null" + " ]";
		}
	}
}

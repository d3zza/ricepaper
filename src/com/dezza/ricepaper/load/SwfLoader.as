package com.dezza.ricepaper.load
{

	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;

	/**
	 * @author dezza
	 */
	public class SwfLoader extends AbstractLoader
	{

		private var loader : Loader;


		public function SwfLoader()
		{
			super();
		}


		override protected function load() : void
		{
			super.load();

			try
			{
				loader.load(request, context);
			}
			catch( err : SecurityError)
			{
				onSecurityErrorHandler(new SecurityErrorEvent(SecurityErrorEvent.SECURITY_ERROR, false, false, err.message));
			}
		}


		override protected function addListeners() : void
		{
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.INIT, onCompleteHandler, false, 0, true);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onErrorHandler, false, 0, true);
			loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityErrorHandler, false, 0, true);
		}


		override public function stop() : void
		{
			if ( loader )
			{
				try
				{
					loader.close();
				}
				catch( err : Error )
				{
				}
			}
		}


		protected function onCompleteHandler(event : Event) : void
		{
			// Debug.log(this + ".onCompleteHandler() content:" + loader.content);

			try
			{
				content = loader.content;

				onComplete();
			}
			catch( err : SecurityError )
			{
				content = loader;

				onComplete();
			}
		}


		protected function onSecurityErrorHandler(event : SecurityErrorEvent) : void
		{
			// Debug.error(this + ".onSecurityErrorHandler() : " + event.text);

			onError(event.text);
		}


		protected function onErrorHandler(event : IOErrorEvent) : void
		{
			// Debug.error(this + ".onErrorHandler() : " + event.text);

			onError(event.text);
		}


		override protected function removeListeners() : void
		{
			if ( loader )
			{
				loader.contentLoaderInfo.removeEventListener(Event.INIT, onCompleteHandler);
				loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onErrorHandler);
				loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityErrorHandler);
			}
		}


		override public function destroy() : void
		{
			super.destroy();

			// TODO

			loader = null;
		}
	}
}

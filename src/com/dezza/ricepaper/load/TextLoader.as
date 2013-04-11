package com.dezza.ricepaper.load
{

	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;

	/**
	 * @author dezza
	 */
	public class TextLoader extends AbstractLoader
	{

		protected var loader : URLLoader;


		public function TextLoader()
		{
			super();
		}


		override protected function load() : void
		{
			// Debug.log( "load "+this );

			super.load();

			loader.load(request);
		}


		override protected function addListeners() : void
		{
			loader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.addEventListener(Event.COMPLETE, onCompleteHandler);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onErrorHandler);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityErrorHandler);
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
			// Debug.log( "onCompleteHandler for "+this );

			content = loader.data;

			onComplete();
		}


		protected function onSecurityErrorHandler(event : SecurityErrorEvent) : void
		{
			// Debug.error(this+".onSecurityErrorHandler() : "+event.text );

			onError(event.text);
		}


		protected function onErrorHandler(event : IOErrorEvent) : void
		{
			// Debug.error(this+".onErrorHandler() : "+event.text );

			onError(event.text);
		}


		override protected function removeListeners() : void
		{
			loader.removeEventListener(Event.COMPLETE, onCompleteHandler);
			loader.removeEventListener(IOErrorEvent.IO_ERROR, onErrorHandler);
			loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityErrorHandler);
		}
	}
}

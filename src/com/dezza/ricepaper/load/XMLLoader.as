package com.dezza.ricepaper.load
{

	import flash.events.Event;

	/**
	 * @author dezza
	 */
	public class XMLLoader extends TextLoader
	{

		public function XMLLoader()
		{
			super();
		}


		override protected function onCompleteHandler(event : Event) : void
		{
			// TODO handle parser error here
			content = new XML(loader.data);

			onComplete();
		}
	}
}

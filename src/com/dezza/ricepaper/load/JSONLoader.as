package com.dezza.ricepaper.load
{

	import com.adobe.serialization.json.JSON;


	import flash.events.Event;

	/**
	 * @author dezza
	 */
	public class JSONLoader extends TextLoader
	{

		public function JSONLoader()
		{
			super();
		}


		override protected function onCompleteHandler(event : Event) : void
		{
			content = JSON.decode(loader.data);

			onComplete();
		}
	}
}

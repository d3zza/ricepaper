package com.dezza.ricepaper.ui.mock
{

	import com.dezza.ricepaper.ui.dragger.IDraggerListener;

	import flash.events.Event;

	/**
	 * @author derek
	 */
	public class MockDraggerListener implements IDraggerListener
	{
		public var startRecieved : Boolean;

		public var changeRecieved : Boolean;

		public var stopRecieved : Boolean;

		public var changeEvents : int = 0;

		public function onDragChange(e : Event) : void
		{
			changeRecieved = true;
			
			changeEvents++;
		}


		public function onDragStart(e : Event) : void
		{
			startRecieved = true;
		}


		public function onDragStop(e : Event) : void
		{
			stopRecieved = true;
		}
	}
}

package com.dezza.ricepaper.ui.mock
{

	import com.dezza.ricepaper.ui.scrollbar.ScrollableContentEvent;

	/**
	 * @author derek
	 */
	public class MockScrollableContentListener
	{
		public var positionChangeEventsRecieved : int = 0;

		public var sizeChangeEventsRecieved : int = 0;

		public function MockScrollableContentListener() : void
		{
		}


		public function onPositionChange(e : ScrollableContentEvent) : void
		{
			positionChangeEventsRecieved++;
		}


		public function onSizeChange(e : ScrollableContentEvent) : void
		{
			sizeChangeEventsRecieved++;
		}
	}
}

package com.dezza.ricepaper.ui.mock
{

	import com.dezza.ricepaper.ui.button.RepeaterButtonEvent;
	/**
	 * @author derek
	 */
	public class MockRepeaterButtonListener
	{
		public var eventCount : uint;

		public function MockRepeaterButtonListener()
		{
			eventCount = 0;
		}
		
		public function onEvent( event:RepeaterButtonEvent ):void
		{
			eventCount++;
		}

	}
}

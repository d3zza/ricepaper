package com.dezza.ricepaper.ui.mock
{

	import com.dezza.ricepaper.ui.scrollbar.ScrollbarEvent;
	import com.dezza.ricepaper.ui.scrollbar.IScrollBar;

	import flash.events.EventDispatcher;

	/**
	 * @author derek
	 */
	public class MockScrollBar extends EventDispatcher implements IScrollBar
	{
		private var _scrollPercent : Number = 0;

		private var _axis : String;

		public function MockScrollBar(axis : String = "y")
		{
			super();

			_axis = axis;
		}


		public function get axis() : String
		{
			return _axis;
		}


		public function get scrolledPercent() : Number
		{
			return _scrollPercent;
		}


		public function set scrolledPercent(percent : Number) : void
		{
			_scrollPercent = percent;
			
			dispatchEvent( new ScrollbarEvent(ScrollbarEvent.SCROLL_CHANGE));
		}


		public function get enabled() : Boolean
		{
			return true;
		}


		public function set enabled(enabled : Boolean) : void
		{
		}
	}
}

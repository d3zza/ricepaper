package com.dezza.ricepaper.ui.mock
{

	import com.dezza.ricepaper.ui.scrollbar.IScrollBar;
	import com.dezza.ricepaper.ui.scrollbar.IScrollBarAsset;
	import com.dezza.ricepaper.ui.scrollbar.ScrollBar;
	import com.dezza.ricepaper.ui.scrollbar.ScrollbarEvent;

	/**
	 * @author derek
	 */
	public class MockScrollBar extends ScrollBar implements IScrollBar
	{
		private var _scrollPercent : Number = 0;

		private var _axis : String;

		public function MockScrollBar(asset : IScrollBarAsset, axis : String = "y", btnAlignment : String = null)
		{
			super( asset, axis, btnAlignment );

			_axis = axis;
		}


		override public function get scrolledPercent() : Number
		{
			return _scrollPercent;
		}


		override public function set scrolledPercent(percent : Number) : void
		{
			_scrollPercent = percent;
			
			dispatchEvent( new ScrollbarEvent(ScrollbarEvent.SCROLL_CHANGE));
		}
	}
}

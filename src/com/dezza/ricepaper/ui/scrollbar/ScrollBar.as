package com.dezza.ricepaper.ui.scrollbar
{

	import com.dezza.ricepaper.ui.core.UIControl;

	import flash.display.DisplayObject;

	/**
	 * @author derek
	 */
	public class ScrollBar extends UIControl implements IScrollBar
	{
		public function ScrollBar( asset:DisplayObject, axis : String = "y", btnAlignment : String = null)
		{
			super( asset );
		}


		public function get axis() : String
		{
			// TODO: Auto-generated method stub
			return null;
		}


		public function get scrolledPercent() : Number
		{
			// TODO: Auto-generated method stub
			return 0;
		}


		public function set scrolledPercent(percent : Number) : void
		{
		}
	}
}

package com.dezza.ricepaper.ui.scrollbar
{

	import com.dezza.ricepaper.ui.core.UIControl;

	import flash.display.DisplayObject;

	/**
	 * @author derek
	 */
	public class ScrollBar extends UIControl implements IScrollBar
	{

		/**
		 * @private
		 */
		private var _axis : String;


		public function ScrollBar(asset : IScrollBarAsset, axis : String = "y", btnAlignment : String = null)
		{
			super(asset.container);

			_axis = axis;
		}


		public function get axis() : String
		{
			return _axis;
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

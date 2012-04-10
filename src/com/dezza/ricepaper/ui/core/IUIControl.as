package com.dezza.ricepaper.ui.core
{

	import flash.display.DisplayObject;

	/**
	 * @author derek
	 */
	public interface IUIControl extends IDisplayObject, IEnableable
	{
		/**
		 * get the content asset
		 * 
		 * @return MovieClip
		 */
		function get asset() : DisplayObject


		/**
		 * make control available for GC
		 */
		function destroy() : void;
	}
}

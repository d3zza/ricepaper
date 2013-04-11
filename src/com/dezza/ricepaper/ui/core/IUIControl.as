package com.dezza.ricepaper.ui.core
{

	import flash.display.DisplayObject;

	/**
	 * @author derek
	 */
	public interface IUIControl extends IEnableable
	{

		/**
		 * get display asset
		 * 
		 * @return DisplayObject
		 */
		function get asset() : DisplayObject


		/**
		 * make control available for GC
		 */
		function destroy() : void;
	}
}

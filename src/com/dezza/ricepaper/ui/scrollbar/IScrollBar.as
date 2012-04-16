package com.dezza.ricepaper.ui.scrollbar
{

	import com.dezza.ricepaper.ui.core.IEnableable;

	/**
	 * @author derek
	 */
	public interface IScrollBar extends IEnableable
	{
		/**
		 * get the axis that this scrollbar operates on
		 * 
		 * @return String axis either 'x' or 'y'
		 */
		function get axis() : String;


		/**
		 * get the scrollbar dragger position as a percentage (0-1) of possible scroll
		 * 
		 * i.e. how 'scrolled' the scrollbar is
		 * 
		 * 0 means not scrolled at all
		 * 1 means maximum scroll
		 * 
		 * @return the 'scrolledness' as a percentage (0-1)
		 */
		function get scrolledPercent() : Number;


		/**
		 * set the scrollbar dragger position as a percentage (0-1) of possible scroll
		 * 
		 * i.e. how 'scrolled' the scrollbar is
		 * 
		 * 0 means not scrolled at all
		 * 1 means maximum scroll
		 * 
		 * @param Number (0-1) scroll percentage 
		 */
		function set scrolledPercent(percent : Number) : void;
	}
}

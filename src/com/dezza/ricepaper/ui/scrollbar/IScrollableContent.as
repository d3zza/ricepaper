package com.dezza.ricepaper.ui.scrollbar
{

	import flash.display.DisplayObject;

	/**
	 * @author derek
	 * 
	 * IScrollableContent defines an interface for any content that can be scrolled
	 * in a masked 'window'. 
	 * 
	 * A relationship can established with an IScrollBar implentation via the 
	 * scrollbar's setContent() method
	 */
	public interface IScrollableContent extends IScrollBarListener
	{
		/**
		 * notify listeners that position and/or size of the scrollable content has changed
		 */
		function notifyChanged() : void;


		/**
		 * get the percentage (0-1) of content visible for the passed in axis
		 * 
		 * i.e. what percentage of content is visible in the masked area in the specified axis
		 * 
		 * should never return 0
		 * 
		 * @param axis 'x' or 'y' 
		 * 
		 * @return precentage of visible content
		 */
		function getVisibleContentPercent(axis : String = "y") : Number;


		/**
		 * get the content's position as a percentage (0-1) of total scroll for the passed in axis
		 * 
		 * i.e. how 'scrolled' the content is
		 * 
		 * @param axis 'y' or 'x'
		 * 
		 * @return the 'scrolledness' as a percentage (0-1)
		 * 
		 * Note that 'scrolled' value works opposite to position value, i.e.
		 * when content is at max position it's scroll percentage is at 0
		 * and when content is at min position it's it's scroll percentage is 1
		 */
		function getPositionPercent(axis : String = "y") : Number;


		/**
		 * set the content's position as a percentage (0-1) of total scroll for the passed in axis
		 * 
		 * @param n percentage amount
		 * 
		 * @param axis to set position for 'x' or 'y'
		 * 
		 * @see getPositionPercent()
		 */
		function setPositionPercent( percent : Number, axis : String = "y") : void;


		/**
		 * get whether scrolling is required for the passed in axis
		 * 
		 * true if the content is bigger than the masked area, false if not
		 * 
		 * @param axis the axis to test 'x' or 'y'
		 * 
		 * @return true if scrolling required
		 */
		function isScrollingRequired(axis : String = "y") : Boolean;


		/**
		 * find out if the mouse is over the scroll window 
		 * 
		 * this is necessary for scrollbars using mousewheel 
		 * 
		 * return true if the mouse is over the scroll window
		 */
		function getMouseOverWindow() : Boolean;


		/**
		 * get the content to be masked
		 */
		function get content() : DisplayObject;


		/**
		 * get width of the masked area
		 * 
		 * @return Number width in pix
		 */
		function get maskWidth() : Number;


		/**
		 * set width of the masked area
		 * 
		 * @param Number width in pix
		 */
		function set maskWidth(width : Number) : void;


		/**
		 * get height of the masked area
		 * 
		 * @return Number height in pix
		 */
		function get maskHeight() : Number;


		/**
		 * set height of the masked area
		 * 
		 * @param Number height in pix
		 */
		function set maskHeight(height : Number) : void;
		
		
		/**
		 * get width of the content
		 * 
		 * @return Number width in pix
		 */
		function get contentWidth() : Number;


		/**
		 * set width of the content
		 * 
		 * <p>note this isn't intended to modify the content's width
		 * but rather set a virtual value, useful when for example the 
		 * content has a mask or some other reason that the using it's 
		 * actual width property would be problematic</p>
		 * 
		 * @param Number width in pix
		 */
		function set contentWidth(width : Number) : void;


		/**
		 * get height of the content
		 * 
		 * @return Number height in pix
		 */
		function get contentHeight() : Number;


		/**
		 * set height of the content
		 * 
		 * <p>note this isn't intended to modify the content's height
		 * but rather set a virtual value, useful when for example the 
		 * content has a mask or some other reason that the using it's 
		 * actual height property would be problematic</p>
		 * 
		 * @param Number height in pix
		 */
		function set contentHeight(height : Number) : void;
	}
}
package com.dezza.ricepaper.ui.scrollbar
{

	import com.dezza.ricepaper.ui.core.IUIControl;

	/**
	 * @author derek
	 * 
	 * IScrollableContent defines an interface for any content that can be scrolled
	 * in a masked 'window'. 
	 * 
	 * A relationship can established with an IScrollBar implentation via the 
	 * scrollbar's setContent() method
	 */
	public interface IScrollableContent extends IUIControl, IScrollBarListener
	{
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


		/**
		 * get the percentage (0-1) of content visible in the x direction
		 * 
		 * should never return 0
		 * 
		 * @return precentage of visible content (0-1)
		 */
		function get visibleContentPercentX() : Number;


		/**
		 * get the percentage (0-1) of content visible in the y direction
		 * 
		 * should never return 0
		 * 
		 * @return precentage of visible content (0-1)
		 */
		function get visibleContentPercentY() : Number;


		/**
		 * get the (masked) content's x position
		 * 
		 * @return x position in pixels
		 */
		function get contentX() : Number;


		/**
		 * set the (masked) content's x position
		 * 
		 * @param x position in pixels
		 */
		function set contentX(x : Number) : void;


		/**
		 * get the (masked) content's y position
		 * 
		 * @return y position in pixels
		 */
		function get contentY() : Number;


		/**
		 * set the (masked) content's x position
		 * 
		 * @param x position in pixels
		 */
		function set contentY(y : Number) : void;


		/**
		 * get the content's position as a percentage (0-1) of possible scroll for the x axis
		 * 
		 * i.e. how 'scrolled' the content is
		 * 
		 * 0 means not scrolled at all
		 * 1 means fully scrolled (content moved as far left as possible) 
		 * 
		 * @return the 'scrolledness' as a percentage (0-1)
		 * 
		 * Note that 'scrolled' value works opposite to position value, i.e.
		 * when content is at max position it's scroll percentage is at 0
		 * and when content is at min position it's it's scroll percentage is 1
		 */
		function get scrolledPercentX() : Number;


		/**
		 * set the content's position as a percentage (0-1) of possible scroll for the x axis
		 * 
		 * i.e. how 'scrolled' the content is
		 * 
		 * 0 means not scrolled at all
		 * 1 means fully scrolled (content moved as far left as possible) 
		 * 
		 * @return the 'scrolledness' as a percentage (0-1)
		 * 
		 * Note that 'scrolled' value works opposite to position value, i.e.
		 * when content is at max position it's scroll percentage is at 0
		 * and when content is at min position it's it's scroll percentage is 1
		 */
		function set scrolledPercentX(percent : Number) : void;


		/**
		 * get the content's position as a percentage (0-1) of possible scroll for the x axis
		 * 
		 * i.e. how 'scrolled' the content is
		 * 
		 * 0 means not scrolled at all
		 * 1 means fully scrolled (content moved as far left as possible) 
		 * 
		 * @return the 'scrolledness' as a percentage (0-1)
		 * 
		 * Note that 'scrolled' value works opposite to position value, i.e.
		 * when content is at max position it's scroll percentage is at 0
		 * and when content is at min position it's it's scroll percentage is 1
		 */
		function get scrolledPercentY() : Number;


		/**
		 * set the content's position as a percentage (0-1) of possible scroll for the x axis
		 * 
		 * i.e. how 'scrolled' the content is
		 * 
		 * 0 means not scrolled at all
		 * 1 means fully scrolled (content moved as far left as possible) 
		 * 
		 * @return the 'scrolledness' as a percentage (0-1)
		 * 
		 * Note that 'scrolled' value works opposite to position value, i.e.
		 * when content is at max position it's scroll percentage is at 0
		 * and when content is at min position it's it's scroll percentage is 1
		 */
		function set scrolledPercentY(percent : Number) : void;


		/**
		 * get whether scrolling is required in the x direction
		 * 
		 * true if the content is wider than the masked area, false if not
		 * 
		 * @return true if scrolling required
		 */
		function get isScrollingRequiredX() : Boolean;


		/**
		 * get whether scrolling is required in the y direction
		 * 
		 * true if the content is taller than the masked area, false if not
		 * 
		 * @return true if scrolling required
		 */
		function get isScrollingRequiredY() : Boolean;


		/**
		 * get the content x position when 'scrolledness' is 0
		 * 
		 * this is normally the maximum x position since content moves in opposite direction to scroll
		 * 
		 * @return Number content x position in pixels when scroll is 0
		 */
		function get minScrollContentX() : Number;


		/**
		 * set the content x position when 'scrolledness' is 0
		 * 
		 * this is normally the maximum x position since content moves in opposite direction to scroll
		 * 
		 * @param Number content x position in pixels when scroll is 0
		 */
		function set minScrollContentX(x : Number) : void;


		/**
		 * get the content x position when 'scrolledness' is 1
		 * 
		 * this is normally the minimum x position since content moves in opposite direction to scroll
		 * 
		 * @return Number content x position in pixels when scroll is 1
		 */
		function get maxScrollContentX() : Number;


		/**
		 * set the content x position when 'scrolledness' is 1
		 * 
		 * this is normally the minimum x position since content moves in opposite direction to scroll
		 * 
		 * @param Number content x position in pixels when scroll is 1
		 */
		function set maxScrollContentX(x : Number) : void;


		/**
		 * get the content y position when 'scrolledness' is 0
		 * 
		 * this is normally the maximum y position since content moves in opposite direction to scroll
		 * 
		 * @return Number content y position in pixels when scroll is 0
		 */
		function get minScrollContentY() : Number;


		/**
		 * set the content y position when 'scrolledness' is 0
		 * 
		 * this is normally the maximum y position since content moves in opposite direction to scroll
		 * 
		 * @param Number content y position in pixels when scroll is 0
		 */
		function set minScrollContentY(y : Number) : void;


		/**
		 * get the content y position when 'scrolledness' is 1
		 * 
		 * this is normally the minimum y position since content moves in opposite direction to scroll
		 * 
		 * @return Number content y position in pixels when scroll is 1
		 */
		function get maxScrollContentY() : Number;


		/**
		 * set the content y position when 'scrolledness' is 1
		 * 
		 * this is normally the minimum y position since content moves in opposite direction to scroll
		 * 
		 * @param Number content y position in pixels when scroll is 1
		 */
		function set maxScrollContentY(y : Number) : void;


		/**
		 * find out if the mouse is over the scroll window 
		 * 
		 * this is necessary for scrollbars using mousewheel 
		 * 
		 * return true if the mouse is over the scroll window
		 */
		function getMouseOverWindow() : Boolean;
	}
}
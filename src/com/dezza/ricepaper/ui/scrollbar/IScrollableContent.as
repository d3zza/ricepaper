package com.dezza.ui.scrollbar {

	import flash.display.DisplayObject;
	/**
	 * @author derek
	 * 
	 * IScrollableContent defines an interface for any content that can be scrolled
	 * in a 'scroll window'. 
	 * 
	 * A relationship can established with an IScrollBar implentation via the 
	 * scrollbar's setContent() method
	 */
	public interface IScrollableContent extends IScrollBarListener {
		
		/**
		 * notify listeners that position and/or size of the scrollable content has changed
		 * 
		 * a bunch of invalidation and content
		 * 
		 */
		function notifyChanged() : void;
		
		/**
		 * get the percentage (0-1) of content visible ( for a particular axis )
		 * in other words, what portion of the content is visible in the scroll window
		 * 
		 * should never actually be 0
		 * 
		 * @param axis 'y' or 'x'
		 * 
		 * @return precentage of visible content
		 */		
		function getVisibleContentPercent( axis : String = "y" ) : Number;

		/**
		 * get the content's position expressed as a percentage (0-1) of total scroll ( for a particular axis )
		 * i.e. how 'scrolled' the content is
		 * 
		 * @param axis 'y' or 'x'
		 * @return the 'scrolledness' as a percentage(0-1)
		 * 
		 * Note that 'scrolled' value works opposite to position value, i.e.
		 * when content is at max position it's scroll percentage is at 0
		 * and when content is at min position it's it's scroll percentage is 1
		 */		
		function getPositionPercent( axis : String = "y" ) : Number;

		/**
		 * set the content's position as a percentage (0-1) of total scroll ( for a particular axis )
		 * @param axis 'y' or 'x'
		 * @see getPositionPercent()
		 */		
		function setPositionPercent( n : Number, axis : String = "y" ) : void;
		
		/**
		 * get whether content is required for the current content / scroll window
		 * i.e. yes if the content is bigger than the window, false if not
		 * 
		 * @return true if scrolling required
		 */		
		function isScrollingRequired( axis : String = "y" ) : Boolean;
		
		/**
		 * find out if the mouse is over the scroll window 
		 * 
		 * this is necessary for scrollbars using mousewheel 
		 * 
		 * return true if the mouse is over the scroll window
		 */		
		function getMouseOverWindow() : Boolean;
		
		/**
		 * get the primary display object
		 */
		function getContent():DisplayObject;
		
	}
}
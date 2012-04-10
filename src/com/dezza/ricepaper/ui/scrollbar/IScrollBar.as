package com.dezza.ui.scrollbar {
	import flash.events.Event;

	/**
	 * @author derek
	 */
	public interface IScrollBar {
		
		/**
		 * add a listener for scrollbar changes
		 * 
		 * @param listener IScrollBarListener implementation 
		 */
		function addScrollBarListener( listener:IScrollBarListener ):void;
		
		/**
		 * remove a listener for scrollbar changes
		 * 
		 * @param listener IScrollBarListener implementation
		 */
		function removeScrollBarListener( listener:IScrollBarListener ):void;
		
		/**
		 * define the content that this scrollbar is associated with
		 * 
		 * @param content IScrollableContent implementation
		 */
		function setContent( content:IScrollableContent ):void;
		
		/**
		 * handle a change in the content this scrollbar is associated with
		 * 
		 * @param e Event
		 */
		function onContentChange( e:Event = null ):void;
		
		/**
		 * get the scrollbar's 'scrolledness' as a percentage
		 * 
		 * @return percentage as a Number between 0 (not scrolled) and 1 (fully scrolled)
		 */
		function getScrolledPercent():Number;
		
		/**
		 * set whether user interaction is allowed
		 * 
		 * @param b Boolean
		 */
		function set enabled( b:Boolean ):void
		
		/**
		 * get whether user interaction is allowed
		 * 
		 * @return Boolean
		 */
		function get enabled():Boolean

		/**
		 * get the axis that this scrollbar operates on
		 * 
		 * @return 'y' for vertical scrollbar, 'x' for horizontal
		 */		
		function get axis():String
		
		/**
		 * set the outer dimension of the scrollbar control
		 * 
		 * @param n length in px
		 */
		function set totalLength( n:Number ):void
		
		/**
		 * get the outer dimension of the scrollbar control
		 * 
		 * @return length in px
		 */
		function get totalLength():Number
		
	}
}

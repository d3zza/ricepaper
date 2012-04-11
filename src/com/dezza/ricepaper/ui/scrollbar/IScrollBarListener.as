package com.dezza.ricepaper.ui.scrollbar
{
	import flash.events.Event;

	/**
	 * @author dezza
	 */
	public interface IScrollBarListener {
		
		/**
		 * handle change in scrollbar
		 * 
		 * @param e Event
		 */
		function onScrollBarChanged( e:Event = null ):void;
	}
}

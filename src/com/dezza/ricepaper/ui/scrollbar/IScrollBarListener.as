package com.dezza.ricepaper.ui.scrollbar
{

	/**
	 * @author dezza
	 */
	public interface IScrollBarListener {
		
		/**
		 * handle change in scrollbar 'scrolled' percent
		 * 
		 * @param e ScrollbarEvent
		 */
		function onScrollBarScrollChange( e:ScrollbarEvent = null ):void;
	}
}

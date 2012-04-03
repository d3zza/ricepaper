package com.dezza.ricepaper.ui.core
{

	import flash.display.MovieClip;
	import flash.events.IEventDispatcher;

	/**
	 * @author derek
	 */
	public interface IUIControl extends IEventDispatcher, Enableable
	{
		/**
		 * get the content asset
		 * 
		 * @return MovieClip
		 */
		function get content() : MovieClip


		/**
		 * make control available for GC
		 */
		function destroy() : void;
	}
}

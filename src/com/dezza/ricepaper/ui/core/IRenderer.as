package com.dezza.ricepaper.ui.core
{
	/**
	 * @author derek
	 */
	public interface IRenderer
	{

		/**
		 * render current state
		 * 
		 * @param state String state name to render
		 */
		function render(state : String) : void;


		/**
		 * prepare for garbage collection
		 */
		function dispose() : void;
	}
}

package com.dezza.ricepaper.ui.button
{

	import com.dezza.ricepaper.ui.core.IHighlightable;
	import com.dezza.ricepaper.ui.core.IUIControl;

	/**
	 * @author derek
	 */
	public interface IButton extends IUIControl , IHighlightable
	{
		/**
		 * get whether or not the mouse state is currently locked
		 * 
		 * @return Boolean
		 */
		function get mouseStateLocked() : Boolean;


		/**
		 * set the mouse state to be locked
		 * 
		 * when the mouse state is locked attempts to set the mouseState will have no immediate effect,
		 * but will be remembered and applied if and when the mouseState is unlocked
		 * 
		 * @param locked Boolean
		 */
		function set mouseStateLocked(locked : Boolean) : void;
	}
}

package com.dezza.ricepaper.ui.button
{

	import com.dezza.ricepaper.ui.core.Enableable;

	import flash.events.IEventDispatcher;

	/**
	 * @author derek
	 */
	public interface Button extends IEventDispatcher, Enableable /*, Highlightable*/
	{
		function destroy() : void;
	}
}

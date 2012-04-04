package com.dezza.ricepaper.ui.dragger 
{
	import flash.events.Event;	
	/**
	 * DraggerListener
	 * Class Description.
	 *
	 * @author Derek McKenna
	 * @version 1.0
	 * @since Feb 15, 2009
	 */
	public interface DraggerListener 
	{
		function onDragChange(e : Event) : void;

		function onDragStart(e : Event) : void;

		function onDragStop(e : Event) : void;	
	}
}

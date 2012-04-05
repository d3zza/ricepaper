package com.dezza.ricepaper.ui.dragger
{

	import flash.events.Event;

	/**
	 * DraggerListener
	 *
	 * <p>Classes wishing to listen to all Dragger events
	 * via the Dragger.addDraggerListener method
	 * should implement this</p>
	 *
	 * @author Derek McKenna
	 * @version 1.0
	 * @since Feb 15, 2009
	 */
	public interface IDraggerListener
	{
		/**
		 * handle DraggerEvent.DRAG_CHANGE event
		 * 
		 * @param e DraggerEvent instance
		 */
		function onDragChange(e : Event) : void;


		/**
		 * handle DraggerEvent.DRAG_START event
		 * 
		 * @param e DraggerEvent instance
		 */
		function onDragStart(e : Event) : void;


		/**
		 * handle DraggerEvent.DRAG_STOP event
		 * 
		 * @param e DraggerEvent instance
		 */
		function onDragStop(e : Event) : void;
	}
}

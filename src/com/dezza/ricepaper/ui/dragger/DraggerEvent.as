package com.dezza.ricepaper.ui.dragger
{

	import flash.events.Event;

	/**
	 * @author derek
	 */
	public class DraggerEvent extends Event
	{
		/**
		 * Event type indicating dragging has started
		 */
		public static const DRAG_START : String = "DraggerEvent.DRAG_START";

		/**
		 * Event type indication dragging has stopped
		 */
		public static const DRAG_STOP : String = "DraggerEvent.DRAG_STOP";

		/**
		 * Event type indicating dragger postion change
		 */
		public static const DRAG_CHANGE : String = "DraggerEvent.DRAG_CHANGE";

		/**
		 * event data payload
		 */
		public var data : Object;

		/**
		 * Construct new DraggerEvent instance
		 */
		public function DraggerEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false, data : Object = null)
		{
			super(type, bubbles, cancelable);

			this.data = data;
		}

		/**
		 * @inheritDoc
		 */
		override public function clone() : Event
		{
			return new DraggerEvent(type, bubbles, cancelable, data);
		}
	}
}

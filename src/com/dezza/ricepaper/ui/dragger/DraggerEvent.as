package com.dezza.ricepaper.ui.dragger
{

	import flash.events.Event;

	/**
	 * @author derek
	 */
	public class DraggerEvent extends Event
	{
		public static const DRAG_START : String = "DraggerEvent.DRAG_START";

		public static const DRAG_STOP : String = "DraggerEvent.DRAG_STOP";

		public static const DRAG_CHANGE : String = "DraggerEvent.DRAG_CHANGE";

		public var data : Object;

		public function DraggerEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false, data : Object = null)
		{
			super(type, bubbles, cancelable);

			this.data = data;
		}


		override public function clone() : Event
		{
			return new DraggerEvent(type, bubbles, cancelable, data);
		}
	}
}

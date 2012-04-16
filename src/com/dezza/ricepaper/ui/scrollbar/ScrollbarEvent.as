package com.dezza.ricepaper.ui.scrollbar
{

	import flash.events.Event;

	/**
	 * @author derek
	 */
	public class ScrollbarEvent extends Event
	{
		public static const SCROLL_CHANGE : String = "ScrollbarEvent.SCROLL_CHANGE";

		public function ScrollbarEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
		}


		override public function clone() : Event
		{
			return new ScrollbarEvent(type, bubbles, cancelable);
		}
	}
}

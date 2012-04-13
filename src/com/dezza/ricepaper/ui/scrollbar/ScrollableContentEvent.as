package com.dezza.ricepaper.ui.scrollbar
{

	import flash.events.Event;

	/**
	 * @author derek
	 */
	public class ScrollableContentEvent extends Event
	{
		public static const POSITION_CHANGE : String = "POSITION_CHANGE_Y";

		public static const SIZE_CHANGE : String = "SIZE_CHANGE";

		public function ScrollableContentEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
		}


		/**
		 * @inheritDoc
		 */
		override public function clone() : Event
		{
			return new ScrollableContentEvent(type, bubbles, cancelable);
		}
	}
}

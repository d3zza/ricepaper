package com.dezza.ricepaper.ui.event {
	import flash.events.Event;

	/**
	 * @author dezza
	 */
	public class RepeaterButtonEvent extends Event {
		
		public static const BUTTON_DOWN:String = "RepeaterButtonEvent.BUTTON_DOWN";
		
		public function RepeaterButtonEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false) {
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event {
			return new RepeaterButtonEvent( type, bubbles, cancelable );
		}
	}
}

package com.dezza.ui.button {
	import flash.events.Event;

	/**
	 * @author dezza
	 */
	public class RepeaterButtonEvent extends Event {
		
		public static const BUTTON_DOWN:String = "buttonDown";
		
		public function RepeaterButtonEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false) {
			super(type, bubbles, cancelable);
		}
	}
}

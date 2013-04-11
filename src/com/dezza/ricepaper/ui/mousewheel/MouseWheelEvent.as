package com.dezza.ricepaper.ui.mousewheel
{

	import flash.events.Event;

	/**
	 * @author derek
	 */
	public class MouseWheelEvent extends Event
	{

		/**
		 * Event type representing MouseWheel scroll
		 */
		public static const MOUSE_WHEEL : String = "MouseWheelEvent.MOUSE_WHEEL";

		/**
		 * @private
		 */
		private var _x : Number;

		/**
		 * @private
		 */
		private var _y : Number;

		/**
		 * @private
		 */
		private var _delta : Number;


		/**
		 * Construct a new MouseWheelEvent instance
		 */
		public function MouseWheelEvent(type : String, x : Number, y : Number, delta : Number, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
			_x = x;
			_y = y;
			_delta = delta;
		}


		/**
		 * mouse X position
		 * 
		 * @return Number position in pixels
		 */
		public function get x() : Number
		{
			return _x;
		}


		/**
		 * mouse Y position
		 * 
		 * @return Number postion in pixels
		 */
		public function get y() : Number
		{
			return _y;
		}


		/**
		 * delta
		 * 
		 * @return mouse wheel scroll delta
		 */
		public function get delta() : Number
		{
			return _delta;
		}


		/**
		 * @inheritDoc
		 */
		override public function clone() : Event
		{
			return new MouseWheelEvent(type, x, y, delta, bubbles, cancelable);
		}
	}
}

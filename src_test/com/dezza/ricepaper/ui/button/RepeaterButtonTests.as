package com.dezza.ricepaper.ui.button
{

	import flash.events.TimerEvent;
	import flash.utils.Timer;

	import com.dezza.ricepaper.ui.mock.MockRepeaterButtonListener;
	import com.dezza.ricepaper.ui.dragger.DraggerEvent;
	import com.dezza.ricepaper.ui.mock.MockButtonAsset;

	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertTrue;
	import org.flexunit.asserts.fail;
	import org.flexunit.async.Async;

	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * @author derek
	 */
	public class RepeaterButtonTests
	{
		private var parent : DisplayObjectContainer;

		private var asset : MockButtonAsset;

		private var button : RepeaterButton;

		[Before]
		public function runBeforeEachTest() : void
		{
			parent = new Sprite();

			asset = new MockButtonAsset();

			parent.addChild(asset);

			button = new RepeaterButton(asset);
		}


		[Test]
		public function constructr() : void
		{
			assertNotNull("instance not created", button);

			assertTrue("button not enabled after creation", button.enabled);

			assertTrue("repeatEnabled not true after creation", button.repeatEnabled);

			assertEquals("incorrect value for repeat delay", 300, button.repeatDelay);

			assertEquals("incorrect value for repeat interval", 35, button.repeatInterval);
		}


		[Test]
		public function repeatDelay() : void
		{
			button.repeatDelay = 57;

			assertEquals("incorrect value", 57, button.repeatDelay);
		}


		[Test]
		public function repeatInterval() : void
		{
			button.repeatInterval = 345;

			assertEquals("incorrect value", 345, button.repeatInterval);
		}


		[ Test ]
		public function initEventDispatch() : void
		{
			var listener : MockRepeaterButtonListener = new MockRepeaterButtonListener();

			button.addEventListener(RepeaterButtonEvent.BUTTON_DOWN, listener.onEvent);

			button.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN));

			assertEquals("event dispatched incorrect number of times", 1, listener.eventCount);
			
			assertEquals("repeatCount incorrect", 0, button.repeatCount );
		}


		[ Test(async) ]
		public function repeatEventDelay() : void
		{
			button.repeatDelay = 100;

			button.repeatInterval = 500;

			var listener : MockRepeaterButtonListener = new MockRepeaterButtonListener();

			button.addEventListener(RepeaterButtonEvent.BUTTON_DOWN, listener.onEvent);

			var handler : Function = Async.asyncHandler(this, repeatEventDelayHandler, 500, listener, repeatEventDelayFailed);

			var timer : Timer = new Timer(300, 1);

			timer.addEventListener(TimerEvent.TIMER_COMPLETE, handler);

			timer.start();

			button.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN));
		}


		private function repeatEventDelayHandler(event : Event, listener : MockRepeaterButtonListener) : void
		{
			assertEquals("incorrect num of events dispatched", 2, listener.eventCount);
			
			assertEquals("repeatCount incorrect", 1, button.repeatCount );
		}


		private function repeatEventDelayFailed(event : Event) : void
		{
			fail("RepeaterButtonEvent.BUTTON_DOWN not dispatched");
		}


		[ Test(async) ]
		public function repeatEventInterval() : void
		{
			button.repeatDelay = 200;

			button.repeatInterval = 100;

			var listener : MockRepeaterButtonListener = new MockRepeaterButtonListener();

			button.addEventListener(RepeaterButtonEvent.BUTTON_DOWN, listener.onEvent);

			var handler : Function = Async.asyncHandler(this, repeatEventIntervalHandler, 750, listener, repeatEventIntervalFailed);

			var timer : Timer = new Timer(495, 1);

			timer.addEventListener(TimerEvent.TIMER_COMPLETE, handler);

			timer.start();

			button.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN));
		}


		private function repeatEventIntervalHandler(event : Event, listener : MockRepeaterButtonListener) : void
		{
			assertEquals("incorrect num of events dispatched", 4, listener.eventCount);
			
			assertEquals("repeatCount incorrect", 3, button.repeatCount );
		}


		private function repeatEventIntervalFailed(event : Event) : void
		{
			fail("RepeaterButtonEvent.BUTTON_DOWN not dispatched");
		}
		
		
		[ Test(async) ]
		public function repeatEventDisabled() : void
		{
			button.repeatDelay = 100;
			
			button.repeatInterval = 20;

			var listener : MockRepeaterButtonListener = new MockRepeaterButtonListener();

			button.addEventListener(RepeaterButtonEvent.BUTTON_DOWN, listener.onEvent);

			var handler : Function = Async.asyncHandler(this, repeatEventDisabledHandler, 750, listener, repeatEventDisabledFailed);

			var timer : Timer = new Timer(500, 1);

			timer.addEventListener(TimerEvent.TIMER_COMPLETE, handler);

			timer.start();

			button.repeatEnabled = false;
			
			button.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN));
		}


		private function repeatEventDisabledHandler(event : Event, listener : MockRepeaterButtonListener) : void
		{
			assertEquals("incorrect num of events dispatched", 1, listener.eventCount);
			
			assertEquals("repeatCount incorrect", 0, button.repeatCount );
		}


		private function repeatEventDisabledFailed(event : Event) : void
		{
			fail("RepeaterButtonEvent.BUTTON_DOWN not dispatched");
		}
		
	}
}

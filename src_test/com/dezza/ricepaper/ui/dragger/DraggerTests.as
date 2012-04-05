package com.dezza.ricepaper.ui.dragger
{

	import com.dezza.ricepaper.UIContainer;
	import com.dezza.ricepaper.ui.mock.MockDraggerListener;

	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertTrue;
	import org.flexunit.asserts.fail;
	import org.flexunit.async.Async;

	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * @author derek
	 */
	public class DraggerTests
	{
		private var parent : DisplayObjectContainer;
		
		private var asset : MovieClip;

		private var dragger : Dragger;

		[Before]
		public function runBeforeEachTest() : void
		{
			asset = new MovieClip();

			UIContainer.container.addChild( asset );

			parent = asset.parent;
			
			dragger = new Dragger(asset);
		}


		[Test]
		public function constructr() : void
		{
			assertNotNull("instance not created", dragger);

			assertEquals("dragger not attached to asset's parent", parent, dragger.parent);
			
			assertTrue("dragger not enabled after creation", dragger.enabled);
			
			assertNotNull("dragger not on stage", dragger.stage );
		}


		[ Test(async) ]
		public function dragStartEventDispatch() : void
		{
			var handler : Function = Async.asyncHandler(this, dragStartHandler, 50, null, dragStartFailed);

			dragger.addEventListener(DraggerEvent.DRAG_START, handler);

			dragger.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN));
		}


		private function dragStartHandler(event : Event, passThrough : Object ) : void
		{
			// assert
		}


		private function dragStartFailed(event : Event) : void
		{
			fail("DraggerEvent.DRAG_START not dispatched");
		}
		
		
		[ Test(async) ]
		public function dragChangeEventDispatch() : void
		{
			var handler : Function = Async.asyncHandler(this, dragChangeHandler, 100, null, dragChangeFailed);

			dragger.addEventListener(DraggerEvent.DRAG_CHANGE, handler);

			dragger.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN));
		}


		private function dragChangeHandler(event : Event, passThrough : Object ) : void
		{
			// assert
		}


		private function dragChangeFailed(event : Event) : void
		{
			fail("DraggerEvent.DRAG_CHANGE not dispatched");
		}
		
		
		[ Test(async) ]
		public function dragStopEventDispatch() : void
		{
			var handler : Function = Async.asyncHandler(this, dragStopHandler, 100, null, dragStopFailed);

			dragger.addEventListener(DraggerEvent.DRAG_STOP, handler);

			dragger.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN));
			
			dragger.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP));
		}


		private function dragStopHandler(event : Event, passThrough : Object ) : void
		{
			// assert
		}


		private function dragStopFailed(event : Event) : void
		{
			fail("DraggerEvent.DRAG_STOP not dispatched");
		}
		
		
		[ Test ]
		public function addDraggerListener() : void
		{
			var listener:MockDraggerListener = new MockDraggerListener();
			
			dragger.addDraggerListener(listener);

			dragger.dispatchEvent( new DraggerEvent( DraggerEvent.DRAG_START ) );
			
			dragger.dispatchEvent( new DraggerEvent( DraggerEvent.DRAG_CHANGE ) );
			
			dragger.dispatchEvent( new DraggerEvent( DraggerEvent.DRAG_STOP ) );
			
			assertTrue("listener didn't recieve DraggerEvent.DRAG_START event", listener.startRecieved );
			
			assertTrue("listener didn't recieve DraggerEvent.DRAG_CHANGED event", listener.changeRecieved );
			
			assertTrue("listener didn't recieve DraggerEvent.DRAG_STOP event", listener.stopRecieved );
		}
		
		
		[ Test ]
		public function removeDraggerListener() : void
		{
			var listener:MockDraggerListener = new MockDraggerListener();
			
			dragger.addDraggerListener(listener);
			
			dragger.removeDraggerListener(listener);

			dragger.dispatchEvent( new DraggerEvent( DraggerEvent.DRAG_START ) );
			
			dragger.dispatchEvent( new DraggerEvent( DraggerEvent.DRAG_CHANGE ) );
			
			dragger.dispatchEvent( new DraggerEvent( DraggerEvent.DRAG_STOP ) );
			
			assertFalse("listener recieved DraggerEvent.DRAG_START event", listener.startRecieved );
			
			assertFalse("listener recieved DraggerEvent.DRAG_CHANGED event", listener.changeRecieved );
			
			assertFalse("listener recieved DraggerEvent.DRAG_STOP event", listener.stopRecieved );
		}


		[ Test(async) ]
		public function dragChangeOnlyDispatchedWhenPositionChanges() : void
		{
			
			var listener:MockDraggerListener = new MockDraggerListener();
			
			dragger.addDraggerListener(listener);
			
			var handler : Function = Async.asyncHandler(this, dragChangeODWPCHandler, 100, listener, dragChangeODWPCFailed);

			dragger.addEventListener(DraggerEvent.DRAG_CHANGE, handler);

			dragger.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN));
		}


		private function dragChangeODWPCHandler(event : Event, listener : MockDraggerListener ) : void
		{
			assertEquals("listener recieved event too many times", 1, listener.changeEvents );
		}


		private function dragChangeODWPCFailed(event : Event) : void
		{
			fail("DraggerEvent.DRAG_CHANGE not dispatched");
		}



	}
}

package com.dezza.ricepaper.ui.button
{

	import com.dezza.ricepaper.ui.mock.MockButtonAsset;

	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertTrue;

	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;



	/**
	 * @author derek
	 */
	public class SelectableButtonTests
	{
		private var parent : DisplayObjectContainer;

		private var asset : MockButtonAsset;

		private var button : SelectableButton;

		[Before]
		public function runBeforeEachTest() : void
		{
			parent = new Sprite();

			asset = new MockButtonAsset();

			parent.addChild(asset);

			button = new SelectableButton(asset);
		}


		[Test]
		public function constructr() : void
		{
			assertNotNull("instance not created", button);

			assertTrue("button not enabled after creation", button.enabled);
			
			assertFalse("button should not be selected after creation", button.selected );
			
			assertEquals("content on incorrect frame", ButtonState.OFF, asset.frame);
		}
		
		
		[Test]
		public function select() : void
		{
			button.selected = true;
			
			assertTrue("button not selected", button.selected );

			assertEquals("content on incorrect frame", ButtonState.OFF_SELECTED, asset.frame);
		}


		[Test]
		public function disable() : void
		{
			button.selected = true;
			
			button.enabled = false;

			assertEquals("content on incorrect frame", ButtonState.DISABLED, asset.frame);
		}


		[Test]
		public function onRollOverSelected() : void
		{
			button.selected = true;
			
			button.dispatchEvent(new MouseEvent(MouseEvent.ROLL_OVER));

			assertEquals("content on incorrect frame", ButtonState.ON_SELECTED, asset.frame);
		}


		[Test]
		public function onRollOutSelected() : void
		{
			button.selected = true;
			
			button.dispatchEvent(new MouseEvent(MouseEvent.ROLL_OVER));

			button.dispatchEvent(new MouseEvent(MouseEvent.ROLL_OUT));

			assertEquals("content on incorrect frame", ButtonState.OFF_SELECTED, asset.frame);
		}


		[Test]
		public function onRollOverDeselected() : void
		{
			button.selected = true;
			
			button.dispatchEvent(new MouseEvent(MouseEvent.ROLL_OVER));
			
			button.selected = false;

			assertEquals("content on incorrect frame", ButtonState.ON, asset.frame);
		}


		[Test]
		public function onRollOutDeselected() : void
		{
			button.selected = true;

			button.dispatchEvent(new MouseEvent(MouseEvent.ROLL_OVER));
			
			button.dispatchEvent(new MouseEvent(MouseEvent.ROLL_OUT));

			button.selected = false;
			
			assertEquals("content on incorrect frame", ButtonState.OFF, asset.frame);
		}


		[Test]
		public function onRollOverMouseStateLocked() : void
		{
			button.selected = true;
			
			button.dispatchEvent(new MouseEvent(MouseEvent.ROLL_OVER));
			
			button.mouseStateLocked = true;

			button.dispatchEvent(new MouseEvent(MouseEvent.ROLL_OUT));
			
			assertEquals("content on incorrect frame", ButtonState.ON_SELECTED, asset.frame);
			
			button.mouseStateLocked = false;
			
			assertEquals("content on incorrect frame", ButtonState.OFF_SELECTED, asset.frame);
		}

	}
}

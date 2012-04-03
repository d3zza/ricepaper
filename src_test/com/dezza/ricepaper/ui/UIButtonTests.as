package com.dezza.ricepaper.ui
{

	import flash.events.MouseEvent;
	import flash.display.Sprite;
	import flash.display.DisplayObjectContainer;

	import com.dezza.ricepaper.ui.button.ButtonState;
	import com.dezza.ricepaper.ui.button.UIButton;
	import com.dezza.ricepaper.ui.mock.MockUIButtonAsset;

	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertTrue;

	/**
	 * @author derek
	 */
	public class UIButtonTests
	{
		private var parent : DisplayObjectContainer;

		private var asset : MockUIButtonAsset;

		private var button : UIButton;

		[Before]
		public function runBeforeEachTest() : void
		{
			parent = new Sprite();

			asset = new MockUIButtonAsset();

			asset.x = 97;

			asset.y = 56;

			parent.addChild(asset);

			button = new UIButton(asset);
		}


		[Test]
		public function constructr() : void
		{
			assertNotNull("instance not created", button);

			assertEquals("button has incorrect x posn", 97, button.x);

			assertEquals("button has incorrect y posn", 56, button.y);

			assertEquals("button not attached to asset's parent", parent, button.parent);

			assertTrue("button not enabled after creation", button.enabled);
		}


		[Test]
		public function content() : void
		{
			assertNotNull("content not attached correctly", asset, button.getChildAt(0));

			assertEquals("content on incorrect frame", ButtonState.OFF, asset.frame);
		}


		[Test]
		public function disable() : void
		{
			button.enabled = false;

			assertFalse("button return false state", button.enabled);

			assertEquals("content on incorrect frame", ButtonState.DISABLED, asset.frame);
		}


		[Test]
		public function onRollOver() : void
		{
			button.dispatchEvent(new MouseEvent(MouseEvent.ROLL_OVER));

			assertEquals("content on incorrect frame", ButtonState.ON, asset.frame);
		}


		[Test]
		public function onRollOut() : void
		{
			button.dispatchEvent(new MouseEvent(MouseEvent.ROLL_OVER));

			button.dispatchEvent(new MouseEvent(MouseEvent.ROLL_OUT));

			assertEquals("content on incorrect frame", ButtonState.OFF, asset.frame);
		}


		[Test]
		public function onRollOverDisabled() : void
		{
			button.enabled = false;

			button.dispatchEvent(new MouseEvent(MouseEvent.ROLL_OVER));

			assertEquals("content on incorrect frame", ButtonState.DISABLED, asset.frame);
		}


		[Test]
		public function onRollOutDisabled() : void
		{
			button.enabled = false;

			button.dispatchEvent(new MouseEvent(MouseEvent.ROLL_OVER));

			button.dispatchEvent(new MouseEvent(MouseEvent.ROLL_OUT));

			assertEquals("content on incorrect frame", ButtonState.DISABLED, asset.frame);
		}


		[Test]
		public function onRollOverMouseStateLocked() : void
		{
			button.mouseStateLocked = true;

			button.dispatchEvent(new MouseEvent(MouseEvent.ROLL_OVER));
			
			assertEquals("content on incorrect frame", ButtonState.OFF, asset.frame);
			
			button.mouseStateLocked = false;
			
			assertEquals("content on incorrect frame", ButtonState.ON, asset.frame);
		}

	}
}

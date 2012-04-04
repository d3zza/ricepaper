package com.dezza.ricepaper.ui.core
{

	import com.dezza.ricepaper.ui.button.ButtonState;
	import com.dezza.ricepaper.ui.mock.MockButtonAsset;

	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertTrue;

	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;

	/**
	 * @author derek
	 */
	public class UIControlTests
	{
		private var parent : DisplayObjectContainer;

		private var asset : MockButtonAsset;

		private var control : UIControl;

		[Before]
		public function runBeforeEachTest() : void
		{
			parent = new Sprite();

			asset = new MockButtonAsset();

			asset.x = 97;

			asset.y = 56;

			parent.addChild(asset);

			control = new UIControl(asset);
		}


		[Test]
		public function constructr() : void
		{
			assertNotNull("instance not created", control);

			assertEquals("button has incorrect x posn", 97, control.x);

			assertEquals("button has incorrect y posn", 56, control.y);

			assertEquals("button not attached to asset's parent", parent, control.parent);

			assertTrue("button not enabled after creation", control.enabled);
		}


		[Test]
		public function content() : void
		{
			assertNotNull("content not attached correctly", asset, control.getChildAt(0));

			assertEquals("content on incorrect frame", ButtonState.OFF, asset.frame);
		}


		[Test]
		public function disable() : void
		{
			control.enabled = false;

			assertFalse("button return false state", control.enabled);

			assertEquals("content on incorrect frame", ButtonState.DISABLED, asset.frame);
		}

	}
}

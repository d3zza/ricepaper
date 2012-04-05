package com.dezza.ricepaper.ui.core
{

	import com.dezza.ricepaper.UIContainer;
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertNotNull;
	import org.fluint.uiImpersonation.UIImpersonator;

	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;

	/**
	 * @author derek
	 */
	public class UIControlTests
	{
		private var parent : DisplayObjectContainer;

		private var asset : MovieClip;

		private var control : UIControl;

		[Before]
		public function runBeforeEachTest() : void
		{
			asset = new MovieClip();
			
			UIContainer.container.addChild(asset);

			parent = asset.parent;
			
			asset.x = 97;

			asset.y = 56;

			parent.addChild(asset);

			control = new UIControl(asset);
		}


		[Test]
		public function constructr() : void
		{
			assertNotNull("instance not created", control);

			assertEquals("control has incorrect x posn", 97, control.x);

			assertEquals("control has incorrect y posn", 56, control.y);

			assertEquals("control not attached to asset's parent", parent, control.parent);

		}


		[Test]
		public function content() : void
		{
			assertNotNull("asset not attached correctly", asset, control.getChildAt(0));
		}


		[Test]
		public function disable() : void
		{
			control.enabled = false;

			assertFalse("should return false state", control.enabled);

		}

	}
}

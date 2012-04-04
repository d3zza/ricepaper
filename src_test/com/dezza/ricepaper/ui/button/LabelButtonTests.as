package com.dezza.ricepaper.ui.button
{

	import com.dezza.ricepaper.ui.mock.MockButtonAsset;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertTrue;



	/**
	 * @author derek
	 */
	public class LabelButtonTests
	{
		private var parent : DisplayObjectContainer;

		private var asset : MockButtonAsset;

		private var button : LabelButton;

		[Before]
		public function runBeforeEachTest() : void
		{
			parent = new Sprite();

			asset = new MockButtonAsset();

			parent.addChild(asset);

			button = new LabelButton(asset, asset.label );
		}


		[Test]
		public function constructr() : void
		{
			assertNotNull("instance not created", button);

			assertEquals("button not attached to asset's parent", parent, button.parent);
			
		}


		[Test]
		public function text() : void
		{
			button.text = "test123";
			
			assertEquals("incorrect value", "test123", button.text );
			
			assertEquals("text not changed in asset", "test123", asset.label.text );
		}

	}
}

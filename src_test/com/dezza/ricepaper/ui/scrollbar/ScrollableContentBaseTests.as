package com.dezza.ricepaper.ui.scrollbar
{

	import flash.display.DisplayObject;

	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNotNull;

	import com.dezza.ricepaper.UIContainer;

	import flash.display.Sprite;

	/**
	 * @author derek
	 */
	public class ScrollableContentBaseTests
	{
		private var content : Sprite;

		private var scrollableContent : ScrollableContentBase;

		[Before]
		public function runBeforeEachTest() : void
		{
			content = new Sprite();
			content.graphics.beginFill(0);
			content.graphics.drawRect(0, 0, 1000, 2000);
			content.graphics.endFill();
			content.x = 300;
			content.y = 100;

			UIContainer.container.addChild(content);

			scrollableContent = new ScrollableContentBase(content);
		}


		[Test]
		public function constructr() : void
		{
			assertNotNull("failed to create instance", scrollableContent);

			assertEquals("new instance has wrong x position", 300, scrollableContent.x);

			assertEquals("new instance has wrong y position", 100, scrollableContent.y);
		}


		[Test( expects="Error")]
		public function invalidConstructr() : void
		{
			var invalidAsset : DisplayObject = null;

			scrollableContent = new ScrollableContentBase(invalidAsset);
		}


		[Test]
		public function defaultMaskSize() : void
		{
			assertEquals("incorrect default value for maskWidth", 100, scrollableContent.maskWidth);

			assertEquals("incorrect default value for maskHeight", 100, scrollableContent.maskHeight);
		}


		[Test]
		public function defaultContentSize() : void
		{
			assertEquals("incorrect default value for maskWidth", content.width, scrollableContent.contentWidth);

			assertEquals("incorrect default value for maskHeight", content.height, scrollableContent.contentHeight);
		}


		[Test]
		public function maskWidth() : void
		{
			scrollableContent.maskWidth = 33;

			assertEquals("incorrect value for maskWidth", 33, scrollableContent.maskWidth);
		}


		[Test]
		public function maskHeight() : void
		{
			scrollableContent.maskHeight = 56;

			assertEquals("incorrect value for maskWidth", 56, scrollableContent.maskHeight);
		}


		[Test]
		public function contentWidth() : void
		{
			scrollableContent.contentWidth = 1512.37;

			assertEquals("incorrect value", 1512.37, scrollableContent.contentWidth);
		}


		[Test]
		public function contentHeight() : void
		{
			scrollableContent.contentHeight = 454.1;

			assertEquals("incorrect value", 454.1, scrollableContent.contentHeight);
		}


		[Test]
		public function getVisibleContentPercentX() : void
		{
			assertEquals("incorrect value", scrollableContent.maskWidth / scrollableContent.contentWidth, scrollableContent.getVisibleContentPercent('x'));
		}
		
		[Test]
		public function getVisibleContentPercentY() : void
		{
			assertEquals("incorrect value", scrollableContent.maskHeight / scrollableContent.contentHeight, scrollableContent.getVisibleContentPercent('y'));
		}


		[Test]
		public function setPositionPercentX() : void
		{
			scrollableContent.setPositionPercent(0.5, "x");

			assertEquals("incorrect value for getPositionPercent(x)", 0.5, scrollableContent.getPositionPercent("x") );
		}
	}
}

package com.dezza.ricepaper.ui.scrollbar
{

	import com.dezza.ricepaper.UIContainer;
	import com.dezza.ricepaper.ui.mock.MockScrollBarAsset;
	import com.dezza.ricepaper.ui.mock.MockSpriteAsset;

	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNotNull;

	import flash.display.Sprite;
	/**
	 * @author derek
	 */
	public class ScrollbarTests
	{
		private var scrollBarAsset : MockScrollBarAsset;
		
		private var contentAsset : Sprite;

		private var content : ScrollableContentBase;

		private var scrollbar : ScrollBar;
		
		[Before]
		public function runBeforeEachTest() : void
		{
			scrollBarAsset = new MockScrollBarAsset();
			
			UIContainer.container.addChild( scrollBarAsset );
			
			contentAsset = new MockSpriteAsset( 1000, 2000 );
			
			contentAsset.x = 300;
			
			contentAsset.y = 100;
			
			UIContainer.container.addChild( contentAsset );
			
			content = new ScrollableContentBase( contentAsset );
			
			scrollbar = new ScrollBar( scrollBarAsset );
		}
		
		
		[After]
		public function runAfterEachTest() : void
		{
			if ( content.parent ) content.parent.removeChild(content);
			content = null;

			if( scrollbar.parent ) scrollbar.parent.removeChild(scrollbar);
			scrollbar = null;
		}

		[Test]
		public function constructr() : void
		{
			assertNotNull("failed to create instance", scrollbar );
		}
		
		[Test]
		public function defaultAxis() : void
		{
			assertEquals("incorrect value", "y", scrollbar.axis );
		}
		
		[Test]
		public function defaultScrolledPercent() : void
		{
			assertEquals("incorrect value", 0, scrollbar.scrolledPercent );
		}
		
		[Test]
		public function setGetScrolledPercent() : void
		{
			scrollbar.scrolledPercent = 0.37;
			assertEquals("incorrect value", 0.37, scrollbar.scrolledPercent );
		}
		
		
		
	}
}

package com.dezza.ricepaper.ui.scrollbar
{

	import com.dezza.ricepaper.ui.mock.MockSpriteAsset;
	import com.dezza.ricepaper.ui.mock.MockScrollBarAsset;
	import com.dezza.ricepaper.ui.mock.MockScrollBar;
	import com.dezza.ricepaper.ui.mock.MockScrollableContentListener;

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

		private var scrollableContent : IScrollableContent;

		private var listener : MockScrollableContentListener;


		[Before]
		public function runBeforeEachTest() : void
		{
			content = new MockSpriteAsset( 1000, 2000 );
			content.x = 300;
			content.y = 100;

			UIContainer.container.addChild(content);

			scrollableContent = new ScrollableContentBase(content, 100, 500);

			listener = new MockScrollableContentListener();

			(scrollableContent as ScrollableContentBase).addEventListener(ScrollableContentEvent.POSITION_CHANGE, listener.onPositionChange);

			(scrollableContent as ScrollableContentBase).addEventListener(ScrollableContentEvent.SIZE_CHANGE, listener.onSizeChange);
		}


		[After]
		public function runAfterEachTest() : void
		{
			if ( content.parent ) content.parent.removeChild(content);
			content = null;

			(scrollableContent as ScrollableContentBase).removeEventListener(ScrollableContentEvent.POSITION_CHANGE, listener.onPositionChange);

			(scrollableContent as ScrollableContentBase).removeEventListener(ScrollableContentEvent.SIZE_CHANGE, listener.onSizeChange);
		}


		[Test]
		public function constructr() : void
		{
			assertNotNull("failed to create instance", scrollableContent);
			
			assertEquals("incorrect value for asset", content, scrollableContent.asset);

			assertEquals("new instance has wrong x position", 300, (scrollableContent as ScrollableContentBase).x);

			assertEquals("new instance has wrong y position", 100, (scrollableContent as ScrollableContentBase).y);
		}


		[Test( expects="Error")]
		public function invalidConstructr() : void
		{
			var invalidAsset : DisplayObject = null;

			scrollableContent = new ScrollableContentBase(invalidAsset);
		}


		[Test]
		public function maskSize() : void
		{
			assertEquals("incorrect default value for maskWidth", 100, scrollableContent.maskWidth);

			assertEquals("incorrect default value for maskHeight", 500, scrollableContent.maskHeight);
		}


		[Test]
		public function contentSize() : void
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
			assertEquals("incorrect value", scrollableContent.maskWidth / scrollableContent.contentWidth, scrollableContent.visibleContentPercentX);
		}


		[Test]
		public function getVisibleContentPercentY() : void
		{
			assertEquals("incorrect value", scrollableContent.maskHeight / scrollableContent.contentHeight, scrollableContent.visibleContentPercentY);
		}


		[Test]
		public function initContentX() : void
		{
			assertEquals("incorrect value", 0, scrollableContent.contentX);
		}


		[Test]
		public function initContentY() : void
		{
			assertEquals("incorrect value", 0, scrollableContent.contentY);
		}


		[Test]
		public function setContentX() : void
		{
			scrollableContent.contentX = -100;

			assertEquals("incorrect value", -100, scrollableContent.contentX);
		}


		[Test]
		public function setContentY() : void
		{
			scrollableContent.contentY = -50;

			assertEquals("incorrect value", -50, scrollableContent.contentY);
		}


		[Test]
		public function getDefaultMinScrollContentX() : void
		{
			assertEquals("incorrect value", 0, scrollableContent.minScrollContentX);
		}


		[Test]
		public function getDefaultMinScrollContentY() : void
		{
			assertEquals("incorrect value", 0, scrollableContent.minScrollContentY);
		}


		[Test]
		public function getDefaultMaxScrollContentX() : void
		{
			assertEquals("incorrect value", -900, scrollableContent.maxScrollContentX);
		}


		[Test]
		public function getDefaultMaxScrollContentY() : void
		{
			assertEquals("incorrect value", -1500, scrollableContent.maxScrollContentY);
		}


		[Test]
		public function setScrolledPercentX0() : void
		{
			scrollableContent.scrolledPercentX = 0;

			assertEquals("incorrect value", scrollableContent.minScrollContentX, scrollableContent.contentX);
		}


		[Test]
		public function setScrolledPercentY0() : void
		{
			scrollableContent.scrolledPercentY = 0;

			assertEquals("incorrect value", scrollableContent.minScrollContentY, scrollableContent.contentY);
		}


		[Test]
		public function setScrolledPercentX1() : void
		{
			scrollableContent.scrolledPercentX = 1;

			assertEquals("incorrect value", scrollableContent.maxScrollContentX, scrollableContent.contentX);

			assertEquals("event not recieved", 1, listener.positionChangeEventsRecieved);

			scrollableContent.scrolledPercentX = 1;

			assertEquals("redundant event dispatch", 1, listener.positionChangeEventsRecieved);
		}


		[Test]
		public function setScrolledPercentY1() : void
		{
			scrollableContent.scrolledPercentY = 1;

			assertEquals("incorrect value", scrollableContent.maxScrollContentY, scrollableContent.contentY);

			assertEquals("event not recieved", 1, listener.positionChangeEventsRecieved);

			scrollableContent.scrolledPercentY = 1;

			assertEquals("redundant event dispatch", 1, listener.positionChangeEventsRecieved);
		}


		[Test]
		public function setScrolledPercentX() : void
		{
			scrollableContent.scrolledPercentX = 0.33;
			assertEquals("incorrect value", -900 * 0.33, scrollableContent.contentX);
		}


		[Test]
		public function setScrolledPercentY() : void
		{
			scrollableContent.scrolledPercentY = 0.25;
			assertEquals("incorrect value", 0.25 * -1500, scrollableContent.contentY);
		}


		[Test]
		public function getScrolledPercentX() : void
		{
			scrollableContent.contentX = -900 * 0.33;
			assertEquals("incorrect value", 0.33, scrollableContent.scrolledPercentX);
		}


		[Test]
		public function getScrolledPercentY() : void
		{
			scrollableContent.contentY = -1500 * 0.33;
			assertEquals("incorrect value", 0.33, scrollableContent.scrolledPercentY);
		}


		[Test]
		public function setGetScrolledPercentX() : void
		{
			scrollableContent.scrolledPercentX = 0.33;
			assertEquals("incorrect value", 0.33, scrollableContent.scrolledPercentX);
		}


		[Test]
		public function setGetScrolledPercentY() : void
		{
			scrollableContent.scrolledPercentY = 0.25;
			assertEquals("incorrect value", 0.25, scrollableContent.scrolledPercentY);
		}


		[Test]
		public function setMinScrollContentX() : void
		{
			scrollableContent.minScrollContentX = 100;

			assertEquals("incorrect value", 100, scrollableContent.minScrollContentX);

			assertEquals("incorrect value", scrollableContent.minScrollContentX, scrollableContent.contentX);
		}


		[Test]
		public function setMinScrollContentY() : void
		{
			scrollableContent.minScrollContentY = 150;

			assertEquals("incorrect value", 150, scrollableContent.minScrollContentY);

			assertEquals("incorrect value", scrollableContent.minScrollContentY, scrollableContent.contentY);
		}


		[Test]
		public function setMaxScrollContentX() : void
		{
			scrollableContent.scrolledPercentX = 1;

			scrollableContent.maxScrollContentX = -1000;

			assertEquals("incorrect value", -1000, scrollableContent.maxScrollContentX);

			assertEquals("incorrect value", scrollableContent.maxScrollContentX, scrollableContent.contentX);
		}


		[Test]
		public function setMaxScrollContentY() : void
		{
			scrollableContent.scrolledPercentY = 1;

			scrollableContent.maxScrollContentY = -2000;

			assertEquals("incorrect value", -2000, scrollableContent.maxScrollContentY);

			assertEquals("incorrect value", scrollableContent.maxScrollContentY, scrollableContent.contentY);
		}


		[Test]
		public function maskWidthEventDispatch() : void
		{
			scrollableContent.maskWidth = 75;

			assertEquals("event not recieved", 1, listener.sizeChangeEventsRecieved);

			scrollableContent.maskWidth = 75;

			assertEquals("redundant event dispatch", 1, listener.sizeChangeEventsRecieved);
		}


		[Test]
		public function maskHeightEventDispatch() : void
		{
			scrollableContent.maskHeight = 56;

			assertEquals("event not recieved", 1, listener.sizeChangeEventsRecieved);

			scrollableContent.maskHeight = 56;

			assertEquals("redundant event dispatch", 1, listener.sizeChangeEventsRecieved);
		}


		[Test]
		public function contentWidthEventDispatch() : void
		{
			scrollableContent.contentWidth = 1512.37;

			assertEquals("event not recieved", 1, listener.sizeChangeEventsRecieved);

			scrollableContent.contentWidth = 1512.37;

			assertEquals("redundant event dispatch", 1, listener.sizeChangeEventsRecieved);
		}


		[Test]
		public function contentHeightEventDispatch() : void
		{
			scrollableContent.contentHeight = 454.1;

			assertEquals("event not recieved", 1, listener.sizeChangeEventsRecieved);

			scrollableContent.contentHeight = 454.1;

			assertEquals("redundant event dispatch", 1, listener.sizeChangeEventsRecieved);
		}


		[Test]
		public function contentXEventDispatch() : void
		{
			scrollableContent.contentX = -100;

			assertEquals("event not recieved", 1, listener.positionChangeEventsRecieved);

			scrollableContent.contentX = -100;

			assertEquals("redundant event dispatch", 1, listener.positionChangeEventsRecieved);
		}


		[Test]
		public function contentYEventDispatch() : void
		{
			scrollableContent.contentY = -50;

			assertEquals("event not recieved", 1, listener.positionChangeEventsRecieved);

			assertEquals("incorrect value", -50, scrollableContent.contentY);

			assertEquals("redundant event dispatch", 1, listener.positionChangeEventsRecieved);
		}


		[Test]
		public function scrolledPercentXEventDispatch() : void
		{
			scrollableContent.scrolledPercentX = 0.33;

			assertEquals("event not recieved", 1, listener.positionChangeEventsRecieved);

			scrollableContent.scrolledPercentX = 0.33;

			assertEquals("redundant event dispatch", 1, listener.positionChangeEventsRecieved);
		}


		[Test]
		public function scrolledPercentYEventDispatch() : void
		{
			scrollableContent.scrolledPercentY = 0.33;

			assertEquals("event not recieved", 1, listener.positionChangeEventsRecieved);

			scrollableContent.scrolledPercentY = 0.33;

			assertEquals("redundant event dispatch", 1, listener.positionChangeEventsRecieved);
		}
		
		[Test]
		public function scrollBarListenerY():void
		{
			var mockScrollBarAsset : MockScrollBarAsset = new MockScrollBarAsset();
			
			var mockScrollBar:MockScrollBar = new MockScrollBar( mockScrollBarAsset, "y" );
			
			mockScrollBar.addScrollBarListener( scrollableContent );
			
			mockScrollBar.scrolledPercent = 0.33;
			
			assertEquals("scrollBar scroll change didn't trigger content scroll change", 0.33, scrollableContent.scrolledPercentY );
		}
		
		
		[Test]
		public function scrollBarListenerX():void
		{
			var mockScrollBarAsset : MockScrollBarAsset = new MockScrollBarAsset();
			
			var mockScrollBar:MockScrollBar = new MockScrollBar( mockScrollBarAsset, "x" );
			
			mockScrollBar.addScrollBarListener( scrollableContent );
			
			mockScrollBar.scrolledPercent = 0.63;
			
			assertEquals("scrollBar scroll change didn't trigger content scroll change", 0.63, scrollableContent.scrolledPercentX );
		}
	}
}

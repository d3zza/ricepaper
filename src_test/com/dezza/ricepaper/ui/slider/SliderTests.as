package com.dezza.ricepaper.ui.slider
{

	import com.dezza.ricepaper.UIContainer;
	import com.dezza.ricepaper.ui.button.Button;
	import com.dezza.ricepaper.ui.button.ButtonState;
	import com.dezza.ricepaper.ui.mock.MockButtonAsset;

	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertTrue;

	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	/**
	 * @author derek
	 */
	public class SliderTests
	{
		private var parent : DisplayObjectContainer;
		
		private var draggerAsset : MockButtonAsset;
		
		private var trackAsset : MockButtonAsset;
		
		private var trackBtn : Button;
		
		private var draggerBtn : Button;

		private var slider : Slider;
		
		private var sliderRect : Rectangle;

		[Before]
		public function runBeforeEachTest() : void
		{
			draggerAsset = new MockButtonAsset();
			
			trackAsset = new MockButtonAsset();
			
			UIContainer.container.addChild( trackAsset );
			
			UIContainer.container.addChild( draggerAsset );

			trackBtn = new Button( trackAsset );
			
			draggerBtn = new Button( draggerAsset );
			
			parent = draggerBtn.parent;
			
			sliderRect = new Rectangle( -50, 0, 100, 0 );
			
			slider = new Slider( draggerBtn, sliderRect, true, 0.25, trackBtn );
		}


		[Test]
		public function constructr() : void
		{
			assertNotNull("instance not created", slider);

			assertEquals("slider not attached to asset's parent", parent, slider.parent);
			
			assertTrue("slider not enabled after creation", slider.enabled);
			
			assertNotNull("slider not on stage", slider.stage );
			
			assertFalse("new slider should not be dragging", slider.isDragging );
		}
		
		
		[Test]
		public function defaultAxis():void
		{
			assertEquals("slider has wrong value for axis", "x", slider.axis );
		}
		

		[Test]
		public function startingPercent():void
		{
			assertEquals("slider has wrong starting percent", 0.25, slider.percent);
		}
		
		
		[Test]
		public function startingPosition():void
		{
			assertEquals("slider asset has wrong starting position", -25, slider.x );
		}
		
		[Test]
		public function dragMin():void
		{
			assertEquals("incorrect value", -50, slider.dragMin );
		}
		
		[Test]
		public function dragMax():void
		{
			assertEquals("icorrect value", 50, slider.dragMax );
		}
		
		[Test]
		public function setDragRect():void
		{
			slider.setDragRect( new Rectangle( 0, 0, 400, 0 ) );
			
			assertEquals("icorrect value for dragMin", 0, slider.dragMin );
			
			assertEquals("icorrect value for dragMax", 400, slider.dragMax );
			
			assertEquals("slider in wrong position", 100, slider.x );
		}
		
		
		[Test]
		public function trackClick():void
		{
			trackBtn.dispatchEvent( new MouseEvent(MouseEvent.MOUSE_DOWN));
			
			assertTrue("track click did not start dragging", slider.isDragging );
			
		}
		
		[Test]
		public function disable( ):void
		{
			slider.enabled = false;
			
			slider.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN));
			
			assertFalse("dragging should not start when disabled", slider.isDragging );
			
			assertEquals("content on incorrect frame", ButtonState.DISABLED, draggerAsset.frame);
			
			assertEquals("content on incorrect frame", ButtonState.DISABLED, trackAsset.frame);
			
		}
	}
}

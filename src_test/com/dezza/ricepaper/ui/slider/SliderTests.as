package com.dezza.ricepaper.ui.slider
{

	import com.dezza.ricepaper.UIContainer;

	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertTrue;

	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.geom.Rectangle;

	/**
	 * @author derek
	 */
	public class SliderTests
	{
		private var parent : DisplayObjectContainer;
		
		private var asset : MovieClip;
		
		private var track : MovieClip;

		private var slider : Slider;
		
		private var sliderRect : Rectangle;

		[Before]
		public function runBeforeEachTest() : void
		{
			asset = new MovieClip();
			
			track = new MovieClip();
			
			UIContainer.container.addChild( asset );
			
			UIContainer.container.addChild( track );

			parent = asset.parent;
			
			sliderRect = new Rectangle( -50, 0, 100, 0 );
			
			slider = new Slider(asset, sliderRect, true, 0.25, track );
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
	}
}

package com.dezza.ricepaper.ui.mock
{

	import com.dezza.ricepaper.ui.scrollbar.ScrollBarAsset;

	import flash.display.MovieClip;
	import flash.display.Sprite;

	/**
	 * @author derek
	 */
	public class MockScrollBarAsset extends ScrollBarAsset
	{
		public function MockScrollBarAsset()
		{
			var container:Sprite = new Sprite();
			
			var bg : Sprite = new Sprite();
			bg.name = "background";
			drawFill(bg, 24, 300);
			container.addChild(bg);
			
			var track : MovieClip = new MovieClip();
			track.name = "track";
			drawFill(track, 24, 100);
			container.addChild(track);
			
			var upBtn : MovieClip = new MovieClip();
			upBtn.name = "up";
			drawFill(upBtn, 24, 24);
			container.addChild(upBtn);
			
			var downBtn : MovieClip = new MovieClip();
			downBtn.name = "down";
			drawFill(downBtn, 24, 24);
			container.addChild(downBtn);
			
			var dragger : MovieClip = new MovieClip();
			dragger.name = "dragger";
			drawFill(dragger, 24, 50);
			container.addChild(dragger);
			
			super(container);
		}
		
		private function drawFill( asset : Sprite, width:Number, height:Number ):void
		{
			asset.graphics.beginFill(0);
			asset.graphics.drawRect( 0, 0, width, height);
			asset.graphics.endFill();
		}
		
	}
}

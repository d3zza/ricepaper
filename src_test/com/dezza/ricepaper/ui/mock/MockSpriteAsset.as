package com.dezza.ricepaper.ui.mock
{

	import flash.display.Sprite;

	/**

	 * @author derek
	 */
	public class MockSpriteAsset extends Sprite
	{
		public function MockSpriteAsset( width:Number, height:Number )
		{
			graphics.beginFill(0);
			graphics.drawRect(0, 0, width, height);
			graphics.endFill();
		}
	}
}

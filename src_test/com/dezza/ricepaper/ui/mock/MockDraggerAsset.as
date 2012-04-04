package com.dezza.ricepaper.ui.mock
{

	import flash.display.MovieClip;
	import flash.display.Sprite;

	/**
	 * @author derek
	 */
	public class MockDraggerAsset extends MovieClip
	{
		public var asset : Sprite;

		public function MockDraggerAsset()
		{
			addChildren();
		}


		private function addChildren() : void
		{
			asset = new Sprite();

			addChild(asset);
		}
	}
}

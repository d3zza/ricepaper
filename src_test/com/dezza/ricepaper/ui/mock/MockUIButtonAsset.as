package com.dezza.ricepaper.ui.mock
{

	import com.dezza.ricepaper.ui.button.ButtonState;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.text.TextField;

	/**
	 * @author derek
	 */
	public class MockUIButtonAsset extends MovieClip
	{

		private var labelContainer : Sprite;

		private var label : TextField;

		private var _frame : Object = ButtonState.OFF;

		public function MockUIButtonAsset()
		{
			addChildren();
		}


		private function addChildren() : void
		{
			labelContainer = new Sprite();

			label = new TextField();

			labelContainer.addChild(label);

			addChild(labelContainer);
		}


		override public function gotoAndStop(frame : Object, scene : String = null) : void
		{
			_frame = frame;
		}


		public function get frame() : Object
		{
			return _frame;
		}
	}
}

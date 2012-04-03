package com.dezza.ricepaper.ui.button
{

	import flash.text.TextField;

	import com.dezza.ricepaper.ui.button.Button;

	import flash.display.MovieClip;

	/**
	 * @author derek
	 */
	public class LabelButton extends Button implements ILabelButton
	{
		protected var _textField : TextField;

		public function LabelButton(content : MovieClip, textField : TextField)
		{
			super(content);

			_textField = textField;
		}


		public function get text() : String
		{
			if ( _textField )
			{
				return _textField.text;
			}

			return null;
		}


		public function set text(text : String) : void
		{
			if ( _textField )
			{
				_textField.text = text;
			}
		}


		public function get textField() : TextField
		{
			return _textField;
		}
	}
}

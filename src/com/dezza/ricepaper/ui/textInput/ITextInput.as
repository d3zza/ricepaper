package com.dezza.ricepaper.ui.textInput
{

	import com.dezza.ricepaper.ui.core.IUIControl;


	import flash.display.DisplayObject;
	import flash.text.TextField;

	/**
	 * @author derek
	 */
	public interface ITextInput extends IUIControl
	{

		function get textField() : TextField;


		function set textField(textField : TextField) : void;


		function get value() : String;


		function set value(text : String) : void;


		function get emptyValue() : String;


		function set emptyValue(text : String) : void;


		function set valid(b : Boolean) : void;


		function get valid() : Boolean;


		function get asDisplayObject() : DisplayObject;


		function get hasValue() : Boolean;


		function get state() : String;


		function focus() : void;


		function unfocus() : void


		function reset() : void;
	}
}

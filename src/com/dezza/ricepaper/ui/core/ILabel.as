package com.dezza.ricepaper.ui.core
{

	import flash.text.TextField;

	/**
	 * @author derek
	 */
	public interface ILabel
	{

		/**
		 * get label text
		 * 
		 * @return String
		 */
		function get text() : String;


		/**
		 * set label text
		 * 
		 * @param text String
		 */
		function set text(text : String) : void;


		/**
		 * get textfield
		 * 
		 * @return TextField
		 */
		function get textField() : TextField;
	}
}

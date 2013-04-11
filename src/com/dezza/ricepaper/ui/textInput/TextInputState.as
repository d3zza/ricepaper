package com.dezza.ricepaper.ui.textInput
{
	/**
	 * @author derek
	 */
	public class TextInputState
	{

		/**
		 * Represents input state of focused
		 */
		public static const FOCUSED : String = "focused";

		/**
		 * Represents input state of unfocussed
		 */
		public static const UNFOCUSED : String = "unfocused";

		/**
		 * Represents input state of 'invalid' i.e. when validation error has occurred
		 */
		public static const INVALID : String = "invalid";

		/**
		 * Represents input state of 'valid' i.e. validation succeeded
		 */
		public static const VALID : String = "valid";

		/**
		 * Represents input state of 'disabled'
		 */
		public static const DISABLED : String = "disabled";

		/**
		 * Array of all states 
		 */
		public static const STATES : Array = [FOCUSED, UNFOCUSED, INVALID, VALID, DISABLED];
	}
}

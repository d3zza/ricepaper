package com.dezza.ricepaper.ui.slider
{

	import com.dezza.ricepaper.ui.dragger.IDragger;

	/**
	 * Slider
	 * Class description.
	 *
	 *	@author Derek McKenna
	 *	@since  11 Aug 2008
	 */
	public interface ISlider extends IDragger
	{
		function set percent(percent : Number) : void;


		function get percent() : Number;


		function get axis() : String;
	}
}

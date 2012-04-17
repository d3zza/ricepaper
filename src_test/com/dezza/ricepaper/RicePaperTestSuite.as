package com.dezza.ricepaper
{

	import com.dezza.ricepaper.ui.button.ButtonTests;
	import com.dezza.ricepaper.ui.button.LabelButtonTests;
	import com.dezza.ricepaper.ui.button.RepeaterButtonTests;
	import com.dezza.ricepaper.ui.button.SelectableButtonTests;
	import com.dezza.ricepaper.ui.core.UIControlTests;
	import com.dezza.ricepaper.ui.dragger.DraggerTests;
	import com.dezza.ricepaper.ui.scrollbar.ScrollableContentBaseTests;
	import com.dezza.ricepaper.ui.scrollbar.ScrollbarTests;
	import com.dezza.ricepaper.ui.slider.SliderTests;

	/**
	 * @author dezza
	 */
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class RicePaperTestSuite
	{
		public var uiControlTests : UIControlTests;

		public var buttonTests : ButtonTests;

		public var selectableButtonTests : SelectableButtonTests;

		public var repeaterButtonTests : RepeaterButtonTests;

		public var labelButtonTests : LabelButtonTests;

		public var draggerTests : DraggerTests;

		public var sliderTests : SliderTests;
		
		public var scrollableContentBaseTests : ScrollableContentBaseTests;
		
		public var scrollBarTests : ScrollbarTests;
	}
}

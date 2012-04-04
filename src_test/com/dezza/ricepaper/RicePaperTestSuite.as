package com.dezza.ricepaper
{

	import com.dezza.ricepaper.ui.button.ButtonTests;
	import com.dezza.ricepaper.ui.button.LabelButtonTests;
	import com.dezza.ricepaper.ui.core.UIControlTests;

	/**
	 * @author dezza
	 */
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class RicePaperTestSuite
	{
		public var uiControlTests : UIControlTests;

		public var buttonTests : ButtonTests;

		public var labelButtonTests : LabelButtonTests;
	}
}

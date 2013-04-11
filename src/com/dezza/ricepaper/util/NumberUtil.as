package com.dezza.ricepaper.util
{
	/**
	 * @author dezza
	 */
	public class NumberUtil
	{

		public static function numberWithCommas(x : Number) : String
		{
			var a : Array = x.toString().split(".");
			return a[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",") + (a.length > 1 ? "." + a[1] : "");
		}
		
		public static function padZeroes( x : int, digits:int ) : String
		{
			var s : String = "" + x;
			while ( s.length < digits ) s = "0" + s;
			return s;
		}
	}
}

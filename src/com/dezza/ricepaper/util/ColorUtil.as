package com.dezza.ricepaper.util
{
	/**
	 * @author Derek McKenna
	 */
	public class ColorUtil
	{
		public static function rgbToColor( r:uint, g:uint, b:uint ):uint
		{
			return ( r << 16 ) | ( g << 8 ) | b;
		}
	}
}

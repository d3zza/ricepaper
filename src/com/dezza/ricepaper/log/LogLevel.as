package com.dezza.ricepaper.log
{
	/**
	 * @author derek
	 */
	public class LogLevel
	{

		public static const NONE : int = int.MAX_VALUE;

		public static const FATAL : int = 1000;

		public static const ERROR : int = 8;

		public static const WARN : int = 6;

		public static const INFO : int = 4;

		public static const DEBUG : int = 2;


		public static function getLevelAsString(logLevel : int) : String
		{
			switch( logLevel )
			{
				case NONE :
					return "none";
				case FATAL :
					return "fatal";
				case ERROR :
					return "error";
				case WARN :
					return "warn";
				case INFO :
					return "info";
				case DEBUG :
					return "debug";
			}

			return null;
		}


		public static function getColor(logLevel : int) : uint
		{
			switch( logLevel )
			{
				case NONE :
					return 0x666666;
				case FATAL :
					return 0xFF99CC;
				case ERROR :
					return 0xCC0000;
				case WARN :
					return 0xCCCC00;
				case INFO :
					return 0x00CCCC;
				case DEBUG :
					return 0x00CC00;
			}

			return 0xffffff;
		}
	}
}


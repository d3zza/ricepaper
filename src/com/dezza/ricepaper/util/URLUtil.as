package com.dezza.ricepaper.util
{

	import flash.net.URLRequest;
	import flash.net.URLVariables;

	/**
	 * @author derek
	 * 
	 * Tools for manipulating URLRequests
	 */
	public class URLUtil
	{

		public static function joinPathParts(...args) : String
		{
			if ( args.length == 1 ) return args[0];

			var result : String = "";

			var part : String;

			for (var i : int = 0; i < args.length; i++)
			{
				part = args[i];

				if ( part == "" || part == null ) continue;

				// strip leading slashes except in first part

				if ( i > 0 )
				{
					if ( part.substr(0, 1) == "/" )
					{
						part = part.substr(1);
					}
				}

				// insert trailing slashes if they don't exist except in last part
				if ( i < args.length - 1 )
				{
					if ( part.substr(-1) != "/" )
					{
						part += "/";
					}
				}

				result += part;
			}

			return result;
		}


		/**
		 * pull any vars out of the query string and insert into the data property as a URLVariables instance
		 * 
		 * @param request URLRequest
		 * 
		 * @return URLRequest with any query string vars replaced by a URLVariables object (data) 
		 */
		public static function conformURLRequest(request : URLRequest) : void
		{
			var vars : URLVariables;

			if ( request.url.indexOf("?") == -1 ) return;

			// in case the request had a URLVars obj already
			if ( request.data is URLVariables )
			{
				vars = request.data as URLVariables;
			}
			else
			{
				// warning this could wipe out any other type of data
				vars = new URLVariables();
			}

			// split url and query
			var a : Array = request.url.split("?");

			var url : String = a[0];

			request.url = url;

			vars.decode(a[1]);

			request.data = vars;
		}


		public static function splitQueryString(queryString : String) : Object
		{
			var o : Object = {};

			var a : Array = queryString.split("?");

			var vars : URLVariables = new URLVariables();

			if ( a.length > 0 )
			{
				o.url = a[0];
			}

			if ( a.length > 1 )
			{
				vars.decode(a[1]);
				o.data = vars;
			}

			return o;
		}


		public static function appendQueryParameters(queryString : String, parameters : Object) : String
		{
			var s : String = queryString;

			var delim : String;

			for (var key : String in parameters)
			{
				delim = s.indexOf("?") == -1 ? "?" : "&";

				s += delim + key + "=" + parameters[key];
			}

			return s;
		}
	}
}

package com.dezza.ricepaper.util
{

	import flash.net.SharedObject;

	/**
	 * SharedObjectUtil
	 * 
	 * Utilities for accessing shared object data
	 * 
	 * @author Derek McKenna
	 * @version 1.0
	 * @since Sep 6, 2008
	 */
	public class SharedObjUtil
	{

		public static var throwErrors : Boolean = true;
		
		/**
		 * Get a value stored in a local SharedObject.
		 * 
		 * <p>Callers of this method can decide if they want any errors to fail
		 * silently (<code>throwError=false</code>) and return <code>null</code> OR
		 * forward errors to the caller for handling (<code>throwErrors=true</code>)</p>
		 * 
		 * @param	 cookieName	Name of the cookie.
		 * @param	 name	Field to retreive.
		 * @param	 localPath		String (by default cookie belongs to current swf only)
		 * 							
		 * @return	 The value stored in the field or <code>null</code>.
		 * 
		 */
		public static function load(cookieName : String, name : String, localPath : String = null) : *
		{
			try
			{
				var save : SharedObject = SharedObject.getLocal(cookieName, localPath);
				return save.data[name];
			}
			catch(e : Error)
			{
				if( throwErrors ) throw ( e );
			}
			return null;
		}


		/**
		 * Save a data in a local SharedObject.
		 * 
		 * <p>Callers of this method can decide if they want any errors to fail
		 * silently (<code>throwError=false</code>) and return <code>false</code> OR
		 * forward errors to the caller for handling (<code>throwErrors=true</code>)</p>
		 * 
		 * @param	cookieName		Name of the cookie.
		 * @param	name			Field to retreive.
		 * @param	localPath 		String (by default cookie belongs to current swf only) 
		 * @param	vale 			Value to save.
		 * @return	<code>true</code> if the data was saved.
		 */
		public static function save(cookieName : String, name : String, value : *, localPath : String = null) : Boolean
		{
			try
			{
				var save : SharedObject = SharedObject.getLocal(cookieName, localPath);
				save.data[name] = value;
				save.flush();
				return true;
			}
			catch(e : Error)
			{
				if( throwErrors ) throw ( e );
			}
			return false;
		}


		/**
		 * Clear all values stored in a local SharedObject.
		 * 
		 * <p>Callers of this method can decide if they want any errors to fail
		 * silently (<code>throwError=false</code>) and return <code>false</code> OR
		 * forward errors to the caller for handling (<code>throwErrors=true</code>)</p>
		 * 
		 * @param	cookieName 	Name of the cookie.
		 * @param	localPath		String (by default look for cookie belonging to current swf only)
		 * @return	<code>true</code> if the data cleared successfully.
		 */
		public static function clear(cookieName : String, localPath : String = null) : Boolean
		{
			try
			{
				var save : SharedObject = SharedObject.getLocal(cookieName, localPath);
				save.clear();
				return true;
			}
			catch( e : Error )
			{
				if( throwErrors ) throw ( e );
			}
			return false;
		}
	}
}
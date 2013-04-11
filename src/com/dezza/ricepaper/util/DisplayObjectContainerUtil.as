package com.dezza.ricepaper.util
{

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;

	/**
	 * @author derek
	 */
	public class DisplayObjectContainerUtil
	{

		/**
		 * Collect child DisplayObjectContainers (recursively) and return as flattened array
		 * 
		 * This can be useful for searching a DisplayObjectContainer (and all its children) for a particular instance
		 * 
		 * @return Array of DisplayObjectContainers (parents added first, then children)  
		 */
		public static function getChildContainers(target : DisplayObjectContainer, depthLimit : int = -1, results : Array = null, depth : int = 0) : Array
		{
			if ( !results ) results = [];

			if ( !target ) return results;

			var s : String = "";
			for (var j : int = 0; j < depth; j++)
			{
				s += "  ";
			}
			// trace(s + "adding child container "+ target+" current depth: "+depth );

			results.push(target);

			if ( depth === depthLimit ) return results;

			// call recursively on child objects that are DisplayObjectContainers
			for (var i : int = 0;i < target.numChildren;i++)
			{
				depth++;
				if ( target.getChildAt(i) is DisplayObjectContainer )
				{
					getChildContainers(target.getChildAt(i) as DisplayObjectContainer, depthLimit, results, depth);
				}
				depth--;
			}

			return results;
		}


		public static function callRecursively(target : Object, method : String, targetType : Class, args:Array = null ) : void
		{
			// call method in target
			if ( target is targetType )
			{
				//trace("target " + target + " is a " + targetType);
				if ( typeof( target[method]) == "function" )
				{
					//trace("target has a method " + method);
					(target[method] as Function).apply( null, args );
				}
			}

			// call recursively on children
			if ( target is DisplayObjectContainer )
			{
				var l : int = (target as DisplayObjectContainer).numChildren;
				var child : DisplayObject;

				while ( --l > -1 )
				{
					child = (target as DisplayObjectContainer).getChildAt(l);
					callRecursively(child, method, targetType, args );
				}
			}
		}

	}
}

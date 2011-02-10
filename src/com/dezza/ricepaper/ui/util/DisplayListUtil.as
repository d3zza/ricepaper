package com.dezza.ricepaper.ui.util {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	/**
	 * @author dezza
	 */
	public class DisplayListUtil {
		
		public static function replaceAddChild( content:DisplayObject, target:DisplayObjectContainer ):DisplayObjectContainer {
			var parent:DisplayObjectContainer = content.parent;
			target.addChild(content);
			
			if( parent ){
				parent.addChild( target );
			}
			
			target.x = content.x;
			target.y = content.y;
			target.rotation = content.rotation;
			
			content.x = 0;
			content.y = 0;
			content.rotation = 0;
			
			return target;
		}
	}
}

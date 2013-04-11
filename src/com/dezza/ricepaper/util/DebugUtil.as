package com.dezza.ricepaper.util
{

	import flash.text.TextFormat;


	import com.carlcalderon.arthropod.Debug;


	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	/**
	 * DebugUtil
	 *
	 * @author Derek McKenna
	 * @version 1.0
	 * @since Nov 12, 2007
	 */
	public class DebugUtil
	{

		public function DebugUtil(access : PrivateConstructorAccess)
		{
			// not intended to be instantiated
		}


		public static function attachMarker(mc : DisplayObjectContainer, x : Number = 0, y : Number = 0, col : uint = 0x0000ff, label : String = "") : Sprite
		{
			var cmc : Sprite = new Sprite();
			mc.addChild(cmc);

			cmc.x = x;
			cmc.y = y;
			cmc.graphics.lineStyle(0, col, 1);
			cmc.graphics.moveTo(0, -10);
			cmc.graphics.lineTo(0, 10);
			cmc.graphics.moveTo(-10, 0);
			cmc.graphics.lineTo(10, 0);
			// trace ("text:"+label)
			if (label.length)
			{
				var t : TextField = new TextField();
				t.x = 15;
				t.y = 15;
				t.width = 10;
				t.height = 10;
				// t.textColor = col;
				// t.selectable = true;
				t.autoSize = TextFieldAutoSize.LEFT;
				t.background = true;
				t.border = true;
				t.borderColor = col;

				var f : TextFormat = new TextFormat();
				f.size = 10;
				f.font = "_sans";
				f.color = col;

				t.defaultTextFormat = f;

				t.text = label;

				cmc.addChild(t);
			}
			return cmc;
		}


		public static function traceObject(obj : *, level : uint = 0) : void
		{
			var indent : String = "";
			for ( var n : uint = 0; n <= level; n++ )
			{
				indent += " ";
			}

			for ( var prop:* in obj )
			{
				if ( typeof obj[ prop ] == "object" )
				{
					trace(indent + prop + ":" + obj[prop]);
					traceObject(obj[ prop ], level + 1);
				}
				else
				{
					if ( typeof obj[ prop ] != "function" )
					{
						trace(indent + prop + " : " + obj[ prop ]);
					}
				}
			}
		}
	}
}
internal class PrivateConstructorAccess
{
}
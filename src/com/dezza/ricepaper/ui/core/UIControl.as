package com.dezza.ricepaper.ui.core
{

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;

	/**
	 * UIControl
	 * Class Description.
	 *
	 * @author Derek McKenna
	 * @version 1.0
	 * @since Feb 15, 2009
	 */
	public class UIControl extends Sprite implements IUIControl
	{
		/**
		 * content asset MovieClip 
		 */
		protected var _content : MovieClip;

		/**
		 * whether or not the control is currently enabled
		 */
		private var _enabled : Boolean;

		/**
		 * Constructor
		 * 
		 * <p>if content is already attached to a parent the UIControl 
		 * will attach itself in place and add the asset as it's child</p>
		 * 
		 * @param content MovieClip 
		 */
		public function UIControl(content : MovieClip)
		{
			if (content)
			{
				x = content.x;
				y = content.y;
				rotation = content.rotation;

				content.x = 0;
				content.y = 0;
				content.rotation = 0;

				if (content.parent)
				{
					content.parent.addChildAt(this, content.parent.getChildIndex(content));
				}

				addChild(content);

				_content = content;
			}
			else
			{
				throw new ArgumentError("UIButton content is undefined");
			}
		}


		public function asDisplayObject() : DisplayObject
		{
			return this;
		}


		/**
		 * @inheritDoc
		 * 
		 * // TODO not really sure this should be public
		 */
		public function get content() : MovieClip
		{
			return _content;
		}


		/**
		 * @inheritDoc
		 */
		public function get enabled() : Boolean
		{
			return _enabled;
		}


		/**
		 * @inheritDoc
		 */
		public function set enabled(enabled : Boolean) : void
		{
			_enabled = enabled;
		}


		/**
		 * @inheritDoc
		 */
		public function destroy() : void
		{
			if ( _content.parent == this )
			{
				removeChild(_content);
			}
			_content = null;
		}
	}
}
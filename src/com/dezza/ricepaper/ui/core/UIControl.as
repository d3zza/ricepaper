package com.dezza.ricepaper.ui.core
{

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;

	/**
	 * UIControl
	 * 
	 * Abstract Superclass for UIControls
	 * 
	 * <p>UIControls are intended to be AS3 UI components that contain
	 * a visual asset and some code to control the interaction</p>
	 * 
	 * <p>assets can either be already attached to some parent, which 
	 * may be convenient if creating layouts in the Flash IDE, or can
	 * be supplied as a new unattached instance.</p>
	 * 
	 * <p>The UIControl is a display object too, so it will attach the 
	 * asset content and then (if the child was already attached)
	 * add itself in place of the asset.</p>
	 * 
	 * <p>This gives us the best of both worlds; visual assets that are
	 * free of any code references, but code assets that are part of the
	 * display list and can access stage properties, display list events
	 * etc.</p>
	 *
	 * @author Derek McKenna
	 * @version 1.0
	 * @since Feb 15, 2009
	 */
	public class UIControl extends Sprite implements IUIControl
	{
		/**
		 * @private
		 */
		protected var _content : MovieClip;

		/**
		 * @private
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
		public function get asset() : MovieClip
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
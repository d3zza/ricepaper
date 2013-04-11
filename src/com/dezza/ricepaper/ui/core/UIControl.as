package com.dezza.ricepaper.ui.core
{

	import com.dezza.ricepaper.ui.movieclip.NullStateRenderer;


	import flash.display.DisplayObject;
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
		protected var _asset : DisplayObject;

		/**
		 * @private
		 */
		private var _enabled : Boolean;

		/**
		 * delegate rendering of state to IRenderer instance
		 */
		protected var _stateRenderer : IRenderer;


		/**
		 * Constructor
		 * 
		 * <p>if content is already attached to a parent the UIControl 
		 * will attach itself in place and add the asset as it's child</p>
		 * 
		 * @param content MovieClip 
		 */
		public function UIControl(asset : DisplayObject)
		{
			if (asset)
			{
				x = asset.x;
				y = asset.y;
				rotation = asset.rotation;

				asset.x = 0;
				asset.y = 0;
				asset.rotation = 0;

				if (asset.parent)
				{
					asset.parent.addChildAt(this, asset.parent.getChildIndex(asset));
				}

				addChild(asset);

				_asset = asset;
			}
			else
			{
				throw new ArgumentError("UIControl content is null");
			}

			initStates();
		}


		/**
		 * @inheritDoc
		 * 
		 * // TODO not really sure this should be public
		 */
		public function get asset() : DisplayObject
		{
			return _asset;
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
			if ( _asset.parent == this )
			{
				removeChild(_asset);
			}
			_asset = null;
		}


		protected function initStates() : void
		{
			_stateRenderer = new NullStateRenderer();
		}


		public function get stateRenderer() : IRenderer
		{
			return _stateRenderer;
		}


		public function set stateRenderer(stateRenderer : IRenderer) : void
		{
			_stateRenderer = stateRenderer;
		}
	}
}
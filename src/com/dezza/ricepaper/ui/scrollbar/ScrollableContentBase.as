package com.dezza.ricepaper.ui.scrollbar
{

	import com.dezza.ricepaper.ui.core.UIControl;

	import flash.display.DisplayObject;
	import flash.events.Event;

	/**
	 * @author derek
	 */
	public class ScrollableContentBase extends UIControl implements IScrollableContent
	{
		/**
		 * @private
		 */
		protected var _maskWidth : Number;

		/**
		 * @private
		 */
		protected var _maskHeight : Number;

		/**
		 * @private
		 */
		protected var _contentWidth : Number;

		/**
		 * @private
		 */
		protected var _contentHeight : Number;

		public function ScrollableContentBase(asset : DisplayObject, maskWidth : Number = 100, maskHeight : Number = 100)
		{
			super(asset);

			this.maskWidth = maskWidth;

			this.maskHeight = maskHeight;
		}


		public function onScrollBarChanged(e : Event = null) : void
		{
		}


		public function notifyChanged() : void
		{
		}


		public function getVisibleContentPercent(axis : String = "y") : Number
		{
			return getMaskLength(axis) / getContentLength(axis);
		}


		public function getPositionPercent(axis : String = "y") : Number
		{
			return (getMaxPosition(axis) - getContentPosition(axis)) / (getMaxPosition(axis) - getMinPosition(axis));
		}


		public function setPositionPercent(n : Number, axis : String = "y") : void
		{
			var lastPosition : Number = getContentPosition(axis);
			
			setContentPosition( ( getMaxPosition(axis) - getMinPosition(axis) ) * n);
			
			if ( getContentPosition( axis ) != lastPosition ) notifyChanged();
		}


		public function isScrollingRequired(axis : String = "y") : Boolean
		{
			// TODO: Auto-generated method stub
			return false;
		}


		public function getMouseOverWindow() : Boolean
		{
			if ( mouseXPercent < 0) return false;
			if ( mouseXPercent > 1) return false;
			if ( mouseYPercent < 0) return false;
			if ( mouseYPercent > 1) return false;
			return true;
		}


		// TODO duplication with get asset
		public function get content() : DisplayObject
		{
			return _asset;
		}


		/**
		 * @inheritDoc
		 */
		public function get maskWidth() : Number
		{
			return _maskWidth;
		}


		/**
		 * @inheritDoc
		 */
		public function set maskWidth(width : Number) : void
		{
			_maskWidth = width;
		}


		/**
		 * @inheritDoc
		 */
		public function get maskHeight() : Number
		{
			return _maskHeight;
		}


		/**
		 * @inheritDoc
		 */
		public function set maskHeight(height : Number) : void
		{
			_maskHeight = height;
		}


		public function get contentWidth() : Number
		{
			return isNaN(_contentWidth) ? _asset.width : _contentWidth;
		}


		public function set contentWidth(width : Number) : void
		{
			_contentWidth = width;
		}


		public function get contentHeight() : Number
		{
			return isNaN(_contentHeight) ? _asset.height : _contentHeight;
		}


		public function set contentHeight(height : Number) : void
		{
			_contentHeight = height;
		}


		/**
		 * @private
		 * 
		 * get mouseX as a percentage (0-1) of the mask window width
		 */
		protected function get mouseXPercent() : Number
		{
			return mouseX / maskWidth;
		}


		/**
		 * @private
		 * 
		 * get mouseY as a percentage (0-1) of the mask window height
		 */
		protected function get mouseYPercent() : Number
		{
			return mouseY / maskHeight;
		}


		/**
		 * @private
		 */
		protected function getContentLength(axis : String = "y") : Number
		{
			return axis == "y" ? contentHeight : contentWidth;
		}


		/**
		 * @private
		 */
		protected function getMaskLength(axis : String = "y") : Number
		{
			return axis == "y" ? maskHeight : maskWidth;
		}


		/**
		 * @private
		 */
		protected function getContentPosition(axis : String = "y") : Number
		{
			return asset[ axis ];
		}


		/**
		 * @private
		 */
		protected function setContentPosition(position : Number, axis : String = "y") : Number
		{
			return asset[ axis ] = position;
		}


		/**
		 * @private
		 */
		protected function getMinPosition(axis : String = "y") : Number
		{
			return getMaskLength(axis) - getContentLength(axis) ;
		}


		/**
		 * @private
		 */
		protected function getMaxPosition(axis : String = "y") : Number
		{
			return 0;
		}


//		/**
//		 * @private
//		 */
//		protected function getScrollRange(axis : String = "y") : Number
//		{
//			return getMaxPosition(axis) - getMinPosition(axis);
//		}
	}
}

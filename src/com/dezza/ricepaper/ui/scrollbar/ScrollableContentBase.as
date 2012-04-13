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

		/**
		 * @private
		 */
		protected var _minScrollContentX : Number;

		/**
		 * @private
		 */
		protected var _minScrollContentY : Number;

		/**
		 * @private
		 */
		protected var _maxScrollContentX : Number;

		/**
		 * @private
		 */
		protected var _maxScrollContentY : Number;

		public function ScrollableContentBase(asset : DisplayObject, maskWidth : Number = 100, maskHeight : Number = 100)
		{
			super(asset);

			this.maskWidth = maskWidth;

			this.maskHeight = maskHeight;

			initScrollParams();
		}


		public function onScrollBarChanged(e : Event = null) : void
		{
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
			if ( _maskWidth != width )
			{
				_maskWidth = width;

				notifySizeChange();
			}
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
			if ( _maskHeight != height )
			{
				_maskHeight = height;

				notifySizeChange();
			}
		}


		public function get contentWidth() : Number
		{
			return isNaN(_contentWidth) ? _asset.width : _contentWidth;
		}


		public function set contentWidth(width : Number) : void
		{
			if ( _contentWidth != width )
			{
				_contentWidth = width;

				notifySizeChange();
			}
		}


		public function get contentHeight() : Number
		{
			return isNaN(_contentHeight) ? _asset.height : _contentHeight;
		}


		public function set contentHeight(height : Number) : void
		{
			if ( _contentHeight != height )
			{
				_contentHeight = height;

				notifySizeChange();
			}
		}


		public function get contentX() : Number
		{
			return _asset.x;
		}


		public function set contentX(x : Number) : void
		{
			if ( _asset.x != x )
			{
				_asset.x = x;

				notifyPositionChange();
			}
		}


		public function get contentY() : Number
		{
			return _asset.y;
		}


		public function set contentY(y : Number) : void
		{
			if ( _asset.y != y )
			{
				_asset.y = y;

				notifyPositionChange();
			}
		}


		public function get visibleContentPercentX() : Number
		{
			return maskWidth / contentWidth;
		}


		public function get visibleContentPercentY() : Number
		{
			return maskHeight / contentHeight;
		}


		public function get scrolledPercentX() : Number
		{
			return (minScrollContentX - contentX) / ( minScrollContentX - maxScrollContentX);
		}


		public function set scrolledPercentX(percent : Number) : void
		{
			contentX = minScrollContentX - (minScrollContentX - maxScrollContentX) * percent;
		}


		public function get scrolledPercentY() : Number
		{
			return (minScrollContentY - contentY) / (minScrollContentY - maxScrollContentY);
		}


		public function set scrolledPercentY(percent : Number) : void
		{
			contentY = minScrollContentY - (minScrollContentY - maxScrollContentY) * percent;
		}


		public function get isScrollingRequiredX() : Boolean
		{
			return contentWidth > maskWidth;
		}


		public function get isScrollingRequiredY() : Boolean
		{
			return contentHeight > maskHeight;
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
		 * @inheritDoc
		 */
		public function get minScrollContentX() : Number
		{
			return _minScrollContentX;
		}


		/**
		 * @inheritDoc
		 */
		public function set minScrollContentX(x : Number) : void
		{
			var percent : Number = scrolledPercentX;

			_minScrollContentX = x;

			scrolledPercentX = percent;
		}


		/**
		 * @inheritDoc
		 */
		public function get maxScrollContentX() : Number
		{
			return _maxScrollContentX;
		}


		/**
		 * @inheritDoc
		 */
		public function set maxScrollContentX(x : Number) : void
		{
			var percent : Number = scrolledPercentX;

			_maxScrollContentX = x;

			scrolledPercentX = percent;
		}


		/**
		 * @inheritDoc
		 */
		public function get minScrollContentY() : Number
		{
			return _minScrollContentY;
		}


		/**
		 * @inheritDoc
		 */
		public function set minScrollContentY(y : Number) : void
		{
			var percent : Number = scrolledPercentY;

			_minScrollContentY = y;

			scrolledPercentY = percent;
		}


		/**
		 * @inheritDoc
		 */
		public function get maxScrollContentY() : Number
		{
			return _maxScrollContentY;
		}


		/**
		 * @inheritDoc
		 */
		public function set maxScrollContentY(y : Number) : void
		{
			var percent : Number = scrolledPercentY;

			_maxScrollContentY = y;

			scrolledPercentY = percent;
		}


		/**
		 * @inheritDoc
		 */
		public function getMouseOverWindow() : Boolean
		{
			if ( mouseXPercent < 0) return false;
			if ( mouseXPercent > 1) return false;
			if ( mouseYPercent < 0) return false;
			if ( mouseYPercent > 1) return false;
			return true;
		}


		/**
		 * @private
		 */
		protected function initScrollParams() : void
		{
			_minScrollContentX = 0;

			_minScrollContentY = 0;

			_maxScrollContentX = maskWidth - contentWidth;

			_maxScrollContentY = maskHeight - contentHeight;
		}


		/**
		 * @private
		 */
		protected function notifyPositionChange() : void
		{
			dispatchEvent(new ScrollableContentEvent(ScrollableContentEvent.POSITION_CHANGE));
		}


		/**
		 * @private
		 */
		protected function notifySizeChange() : void
		{
			dispatchEvent(new ScrollableContentEvent(ScrollableContentEvent.SIZE_CHANGE));
		}
	}
}

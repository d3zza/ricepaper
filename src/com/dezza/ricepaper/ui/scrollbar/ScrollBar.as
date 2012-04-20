package com.dezza.ricepaper.ui.scrollbar
{

	import com.dezza.ricepaper.ui.button.RepeaterButton;
	import com.dezza.ricepaper.ui.core.UIControl;
	import com.dezza.ricepaper.ui.dragger.Dragger;
	import com.dezza.ricepaper.ui.dragger.IDragger;

	/**
	 * @author derek
	 */
	public class ScrollBar extends UIControl implements IScrollBar
	{
		/**
		 * @private
		 */
		private var _axis : String;

		/**
		 * @private
		 */
		private var _dragger : IDragger;
		
		/**
		 * @private
		 */
		private var _track : RepeaterButton;
		
		/**
		 * @private
		 */
		private var _upBtn : RepeaterButton;
		
		/**
		 * @private
		 */
		private var _downBtn : RepeaterButton;

		/**
		 * @private
		 */
		private var _btnAlignment : String;
		
		/**
		 * @private
		 */
		private var _renderer : IScrollBarRender;

		public function ScrollBar(asset : IScrollBarAsset, axis : String = "y", scrollbarRenderer:IScrollBarRender = null )
		{
			super(asset.container);

			initDragger(asset);

			initTrack(asset);

			initScrollBtns(asset);

			_btnAlignment = btnAlignment == null ? ScrollBarButtonAlignment.SPLIT : btnAlignment;

			if ( axis.toLowerCase() != 'x' && axis.toLowerCase() != 'y' )
			{
				throw new ArgumentError("Invalid axis parameter (" + axis + ") 'x' and 'y' only acceptable values");
			}

			_axis = axis.toLowerCase();
		}


		/**
		 * @inheritDoc
		 */
		public function get axis() : String
		{
			return _axis;
		}


		/**
		 * @inheritDoc
		 */
		public function get scrolledPercent() : Number
		{
			// TODO: Auto-generated method stub
			return 0;
		}


		/**
		 * @inheritDoc
		 */
		public function set scrolledPercent(percent : Number) : void
		{
			// TODO
		}


		/**
		 * @inheritDoc
		 */
		public function addScrollBarListener(listener : IScrollBarListener) : void
		{
			addEventListener(ScrollbarEvent.SCROLL_CHANGE, listener.onScrollBarScrollChange);
		}


		/**
		 * @inheritDoc
		 */
		public function removeScrollBarListener(listener : IScrollBarListener) : void
		{
			removeEventListener(ScrollbarEvent.SCROLL_CHANGE, listener.onScrollBarScrollChange);
		}


		protected function initDragger(asset : IScrollBarAsset) : void
		{
			if( asset.draggerAsset )
			{
				_dragger = new Dragger( asset.draggerAsset );
			}
		}


		protected function initTrack(asset : IScrollBarAsset) : void
		{
			if( asset.trackAsset )
			{
				_track = new RepeaterButton( asset.trackAsset );
			}
		}


		protected function initScrollBtns(asset : IScrollBarAsset) : void
		{
			if( asset.upBtnAsset )
			{
				_upBtn = new RepeaterButton( asset.upBtnAsset );
			}
			
			if( asset.downBtnAsset )
			{
				_downBtn = new RepeaterButton( asset.downBtnAsset );
			}
		}
		// /**
		// * @private
		// */
		// protected function set draggerPosition(position : Number) : void
		// {
		// var pos:Number = 
		// }
	}
}

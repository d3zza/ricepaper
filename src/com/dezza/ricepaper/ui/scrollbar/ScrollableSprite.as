package com.dezza.ui.scrollbar {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;

	/**
	 * @author dezza
	 */
	public class ScrollableSprite extends EventDispatcher implements IScrollableContent {
		// TODO use scrollrect instead of mask
		/**
		 * content to be scrolled
		 */
		protected var _content : Sprite;

		/**
		 * shape to use as mask
		 * should be the size of the required scrolling window
		 * as it's dimensions to set up the scrolling relationships
		 * 
		 * NB assume inside mask shape 0,0 is top left
		 */
		protected var _mask : Sprite;

		public function ScrollableSprite( content : Sprite, msk : Sprite) {
			super();
			_content = content;
			_mask = msk;
			init();
		}

		protected function init( ) : void {
			_content.mask = _mask;
		}

		/**
		 * @private
		 * 
		 * get mouseX as a percentage (0-1) of the scroll window width
		 */
		public function get mouseXPercent() : Number {
			return _mask.mouseX / (_mask.width / _mask.scaleX);
		}

		/**
		 * @private
		 * 
		 * get mouseY as a percentage (0-1) of the scroll window height
		 */		
		public function get mouseYPercent() : Number {
			return _mask.mouseY / (_mask.height / _mask.scaleY);
		}		

		/**
		 * @private
		 * 
		 * get the content's position ( for a particular axis )
		 * @param axis 'y' or 'x'
		 * @return content position in pixels
		 */
		public function getPosition(  axis : String = "y"  ) : Number {
			return _content[axis];
		}

		/**
		 * @private
		 * 
		 * get the minimum possible content position ( for a particular axis )
		 * @param axis 'y' or 'x'
		 * @return minimum content position in pixels
		 */
		public function getMinPosition( axis : String = "y" ) : Number {
			return _mask[axis] + getMaskLength(axis) - getContentLength(axis) ;
		}

		/**
		 * @private
		 * 
		 * get the maximum possible content position ( for a particular axis )
		 * @param axis 'y' or 'x'
		 * @return maximum content position in pixels
		 */		
		public function getMaxPosition( axis : String = "y" ) : Number {
			return _mask[axis];
		}

		/**
		 * @private
		 * 
		 * get the content length ( for a particular axis )
		 * @param axis 'y' or 'x'
		 * @return content length in pixels
		 */
		public function getContentLength( axis : String = "y" ) : Number {
			return axis == "y" ? _content.height : _content.width;
		}

		/**
		 * @private
		 * 
		 * get the scroll window ( mask ) length ( for a particular axis )
		 * @param axis 'y' or 'x'
		 * @return mask length in pixels
		 */		
		public function getMaskLength( axis : String = "y" ) : Number {
			return axis == "y" ? _mask.height : _mask.width;
		}

		/**
		 * @private
		 * 
		 * get the (absolute) distance content can scroll ( for a particular axis )
		 * @param axis 'y' or 'x'
		 * @return the possible range of scrolling in pixels 
		 */
		public function getScrollRange( axis : String = "y" ) : Number {
			return getMaxPosition(axis) - getMinPosition(axis);
		}		

		/**
		 * @inheritDoc
		 */
		public function notifyChanged() : void {
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		/**
		 * @inheritDoc
		 */
		public function onScrollBarChanged(e : Event = null) : void {
			var scrollBar : ScrollBar = e.target as ScrollBar;
			setPositionPercent(scrollBar.getScrolledPercent(), scrollBar.axis);
		}

		/**
		 * @inheritDoc
		 */
		public function onScrollBarDragStart(e : Event = null) : void {
		}

		/**
		 * @inheritDoc
		 */
		public function onScrollBarDragEnd(e : Event = null) : void {
		}

		/**
		 * @inheritDoc
		 */			
		public function getVisibleContentPercent( axis : String = "y" ) : Number {
			return getMaskLength(axis) / getContentLength(axis);
		}
		
		/**
		 * @inheritDoc
		 */
		public function getPositionPercent( axis : String = "y" ) : Number {
			return (getMaxPosition(axis) - getPosition(axis)) / (getMaxPosition(axis) - getMinPosition(axis));
		}

		/**
		 * @inheritDoc
		 */
		public function setPositionPercent( n : Number, axis : String = "y" ) : void {
			var lastPosition : Number = _content[axis];
			_content[axis] = getMaxPosition(axis) - getScrollRange(axis) * n;
			if( _content[axis] != lastPosition ) notifyChanged();
		}

		/**
		 * @inheritDoc
		 */
		public function isScrollingRequired( axis : String = "y" ) : Boolean {
			return getContentLength(axis) > getMaskLength(axis);
		}
		
		/**
		 * @inheritDoc
		 */
		public function getMouseOverWindow() : Boolean {
			if( mouseXPercent < 0) return false;
			if( mouseXPercent > 1) return false;
			if( mouseYPercent < 0) return false;
			if( mouseYPercent > 1) return false;
			return true;
		}
		
		public function getContent():DisplayObject {
			return _content;	
		}
	}
}

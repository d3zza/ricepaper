package com.dezza.ricepaper.ui.scrollbar
{

	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.text.TextField;

	/**
	 * @author dezza
	 */
	public class ScrollableText extends EventDispatcher implements IScrollableContent {

		protected var _content : TextField;
		
		public function ScrollableText( textfield:TextField ) {
			super();
			_content = textfield;
			_content.addEventListener(Event.CHANGE, onTextFieldChange, false, 0, true );			_content.addEventListener(Event.SCROLL, onTextFieldChange, false, 0, true );
		}

		public function release():void {
			_content.removeEventListener(Event.CHANGE, onTextFieldChange );
			_content.removeEventListener(Event.SCROLL, onTextFieldChange );			
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
		public function getVisibleContentPercent(axis : String = "y") : Number {
			return axis == 'y' ? _content.height / _content.textHeight : _content.width / _content.textWidth;
		}

		/**
		 * @inheritDoc
		 * 
		 * For text fields, calculating the scrollV position as a percent:
		 * 
		 * e.g. textfield with 6 lines of text and 3 lines visible (shown with +)
		 * 
		 * 	scrollV	'scrolledness'
		 * +1 		-> 0
		 * +2 		->.33
		 * +3 		->.66
		 *	4 		-> 1	[maxScrollV]
		 *	5
		 *	6
		 *	
		 *	therefore:
		 *	
		 *	posn perc = (scrollV - 1) * 1 / (maxscroll - 1)
		 *	
		 *	rearrange for scrollV:
		 *
		 *  scrollV = (posn perc / (1 / (maxscroll - 1))) + 1
		 *  
		 *  scrollH is based on pixel position so can use simple percentage calc for 'x' axis
		 */
		public function getPositionPercent(axis : String = "y") : Number {
			return axis == 'y' ? (_content.scrollV - 1) * (1 / (_content.maxScrollV - 1) ) : _content.scrollH / _content.maxScrollH;
		}
		
		/**
		 * @inheritDoc
		 */
		public function setPositionPercent(n : Number, axis : String = "y") : void {
//			Debug.log(this+".setPositionPercent("+n+")");
			var lastPosition : int;
			if( axis == "y" ) {
				lastPosition = _content.scrollV;
				_content.scrollV = (n / (1 / (_content.maxScrollV - 1))) + 1;
				if( _content.scrollV != lastPosition ) notifyChanged();
			} else {
				lastPosition = _content.scrollH;
				_content.scrollH = _content.maxScrollH * n;
				if( _content.scrollH != lastPosition ) notifyChanged();
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function isScrollingRequired(axis : String = "y") : Boolean {
			return axis == "y" ? _content.maxScrollV > 1: _content.maxScrollH > 0;
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
		 * @private
		 * 
		 * get mouseX as a percentage (0-1) of the scroll window width
		 */
		public function get mouseXPercent() : Number {
			return _content.mouseX / (_content.width / _content.scaleX);
		}

		/**
		 * @private
		 * 
		 * get mouseY as a percentage (0-1) of the scroll window height
		 */		
		public function get mouseYPercent() : Number {
			return _content.mouseY / (_content.height / _content.scaleY);
		}
		
		private function onTextFieldChange( e:Event ):void {
			notifyChanged();
		}
		
		public function getContent():DisplayObject {
			return _content;	
		}


		public function get content() : DisplayObject
		{
			return null;
		}


		public function get maskWidth() : Number
		{
			return 0;
		}


		public function set maskWidth(width : Number) : void
		{
		}


		public function get maskHeight() : Number
		{
			return 0;
		}


		public function set maskHeight(height : Number) : void
		{
		}


		public function get contentWidth() : Number
		{
			return 0;
		}


		public function set contentWidth(width : Number) : void
		{
		}


		public function get contentHeight() : Number
		{
			return 0;
		}


		public function set contentHeight(height : Number) : void
		{
		}
	}
}

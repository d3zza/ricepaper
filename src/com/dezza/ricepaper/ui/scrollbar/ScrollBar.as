package com.dezza.ricepaper.ui.scrollbar
{

	import com.dezza.ricepaper.ui.button.RepeaterButton;
	import com.dezza.ricepaper.ui.button.RepeaterButtonEvent;
	import com.dezza.ricepaper.ui.mousewheel.MouseOverHelper;
	import com.dezza.ricepaper.ui.mousewheel.MouseWheel;
	import com.dezza.ricepaper.ui.mousewheel.MouseWheelEvent;
	import com.dezza.ricepaper.ui.mousewheel.MouseWheelListener;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Timer;

	/**
	 * @author dezza
	 */
	public class ScrollBar extends Sprite implements MouseWheelListener, IScrollBar {

		public static const DRAG_START:String = "onDragStart";
		public static const DRAG_END:String = "onDragEnd";
		
		protected var _dragger:Sprite;
		protected var _track:Sprite;	
		protected var _upBtn:Sprite;
		protected var _downBtn:Sprite;
				
		public var _content:IScrollableContent;
		
		protected var _uiEnabled : Boolean;
		protected var _autoEnable:Boolean = true;
		protected var _isEnabled:Boolean;
		
		protected var _axis:String;
//		protected var _trackLength:Number;
		
		protected var _minDraggerLength : Number = 10;
		
		protected var _dragUpdateTimer : Timer;
		protected var _trackScrollTimer : Timer;
		
		protected var _scrollDirection : int;
		
		protected var _mouseWheelSpeed:Number = 5;

		protected var mouseOverHelper:MouseOverHelper;
		
		private var _dragBounds:Rectangle;
		private var _dragClickOffset:Point;
		private var _dragging:Boolean;
		

		
		// TODO makek configable
		private var _btnDownScrollIncrement:Number = 10; //pix
		
		private var _btnAlignment:String;
		
		private var _availableTrackMin:Number;
		private var _availableTrackMax:Number;
		private var _availableTrackLength:Number;
		
		private var _scaleDragger:Boolean = true;
		
		public function ScrollBar( dragger:Sprite, track:Sprite, upBtn:Sprite = null, downBtn:Sprite = null, axis:String = "y", btnAlignment:String = null ) {
			_dragger = dragger;
			_track = track;
			_upBtn = upBtn;
			_downBtn = downBtn;
			buttonAlignment = btnAlignment == null ? ScrollBarButtonAlignment.SPLIT : btnAlignment;
			
			if( axis.toLowerCase() != 'x' && axis.toLowerCase() != 'y' ) 
				throw new ArgumentError("Invalid axis parameter ("+axis+") 'x' and 'y' only acceptable values");
			_axis = axis.toLowerCase();
			_setScrollingEnabled(false);
			
			totalLength = _track[ dimension ];
			
			initUI();
		}
		
		private function init():void {
			
		}
		
		
		public function set scaleDragger( b:Boolean ):void {
			_scaleDragger = b;
		}
		
		public function get scaleDragger():Boolean {
			return _scaleDragger;
		}

		protected function initUI():void {
			_dragger.addEventListener(MouseEvent.MOUSE_DOWN, onDraggerMouseDown, false, 0, true );
			_dragger.addEventListener(MouseEvent.MOUSE_UP, onDraggerMouseUp, false, 0, true );	
			_track.addEventListener(MouseEvent.MOUSE_DOWN, onTrackMouseDown, false, 0, true );
			_track.addEventListener(MouseEvent.MOUSE_UP, onTrackMouseUp, false, 0, true );
			_dragUpdateTimer = new Timer( 50);
			_dragUpdateTimer.addEventListener(TimerEvent.TIMER, onDragUpdate, false, 0, true);
			_trackScrollTimer = new Timer( 50 );
			_trackScrollTimer.addEventListener(TimerEvent.TIMER, onTrackScroll, false, 0, true);
			
			if( _upBtn && _upBtn is RepeaterButton) {
				_upBtn.addEventListener(RepeaterButtonEvent.BUTTON_DOWN, onUpBtnDown, false, 0, true );
			} else {
				_upBtn.addEventListener(MouseEvent.CLICK, onUpBtnDown, false, 0, true );
			}
			
			if( _downBtn && _downBtn is RepeaterButton){
				_downBtn.addEventListener(RepeaterButtonEvent.BUTTON_DOWN, onDownBtnDown, false, 0, true );
			} else {
				_downBtn.addEventListener(MouseEvent.CLICK, onDownBtnDown, false, 0, true);
			}
			
		}

		
		protected function onDraggerMouseDown( e:MouseEvent ):void {
			// NB Flash bug startDrag() doesn't work with 3d sprites!
			//_dragger.startDrag( false, getDragRect() );
			startDragging( false, getDragRect() );
			_dragger.stage.addEventListener(MouseEvent.MOUSE_UP, onDraggerMouseUp, false, 0, true);
			dispatchEvent(new Event( DRAG_START ) );
			_dragUpdateTimer.start();
		}
		
		protected function onDraggerMouseUp( e:MouseEvent ):void {
			stopDragging();
			_dragger.stage.removeEventListener(MouseEvent.MOUSE_UP, onDraggerMouseUp);
			dispatchEvent(new Event( DRAG_END ) );
			_dragUpdateTimer.stop();
		}
		
		protected function onTrackMouseDown(e:MouseEvent = null):void {
			var clickPosition:Number = _axis == 'y' ? _dragger.parent.mouseY : _dragger.parent.mouseX; 
			if( clickPosition < _dragger[ _axis ] ) _scrollDirection = -1;
			else if( clickPosition > _dragger[ _axis ] + _dragger[ dimension ]  ) _scrollDirection = 1;
			else return;
			
			_trackScrollTimer.start();
		}

		protected function onTrackMouseUp( e:MouseEvent = null ):void {
			_trackScrollTimer.stop();
		}
		
		protected function onTrackScroll( e:TimerEvent ):void {
			var clickPosition:Number = _axis == 'y' ? _dragger.parent.mouseY : _dragger.parent.mouseX;
			// cancel track scrolling when dragger is under mouse
			if( clickPosition >= _dragger[ _axis ] && clickPosition <= _dragger[ _axis ] + _dragger[ dimension ]  ){
				onTrackMouseUp();
			} else {
				_dragger[ _axis ] += 0.5 * _dragger[ dimension ] * _scrollDirection;
				keepDraggerWithinLimits();
				notifyChanged();
			}
		}
		
		protected function onDragUpdate( e:TimerEvent ):void {
			notifyChanged();
		}

		protected function onUpBtnDown( e:Event ):void{
			_dragger[ _axis ] -= _btnDownScrollIncrement;
			keepDraggerWithinLimits();
			notifyChanged();
		}
		
		protected function onDownBtnDown( e:Event ):void{
			_dragger[ _axis ] += _btnDownScrollIncrement;
			keepDraggerWithinLimits();
			notifyChanged();			
		}
		
		/**
		 * NB custom startDrag operation created because startDrag didn't work with 3d sprites
		 */
		 // TODO private
		public function startDragging( lockCenter:Boolean, dragBounds:Rectangle = null ):void{
			_dragBounds = dragBounds;
			_dragging = true;
			if( lockCenter ){
				// move so center is under mouse
				var bounds:Rectangle = _dragger.getBounds(_dragger.parent);
				x += (_dragger.parent.mouseX - (bounds.left + bounds.width * 0.5));
				y += (_dragger.parent.mouseY - (bounds.top + bounds.height * 0.5));
			}
			_dragClickOffset = new Point( _dragger.x - _dragger.parent.mouseX, _dragger.y - _dragger.parent.mouseY );
			_dragger.stage.addEventListener(MouseEvent.MOUSE_MOVE, onDraggingMouseMove, false, 0, true );			_dragger.stage.addEventListener(Event.MOUSE_LEAVE, onDraggingMouseLeaveStage, false, 0, true );
		}

		// TODO private ??
		public function stopDragging():void{
			_dragger.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onDraggingMouseMove );
			_dragger.stage.removeEventListener(Event.MOUSE_LEAVE, onDraggingMouseLeaveStage );
			_dragBounds = null;
			_dragging = false;
		}
		
		private function onDraggingMouseMove( e:MouseEvent ):void {
			_dragger.x = _dragger.parent.mouseX + _dragClickOffset.x;
			_dragger.y = _dragger.parent.mouseY + _dragClickOffset.y;
			if( _dragBounds )keepDraggerWithinBounds();
			e.updateAfterEvent();
		}
		
		private function onDraggingMouseLeaveStage( e:Event ):void {
			stopDragging();
		}
		
		private function keepDraggerWithinBounds():void{
			if( _dragger.x < _dragBounds.left ) _dragger.x = _dragBounds.left;
			if( _dragger.x > _dragBounds.right ) _dragger.x = _dragBounds.right;
			if( _dragger.y < _dragBounds.top ) _dragger.y = _dragBounds.top;
			if( _dragger.y > _dragBounds.bottom ) _dragger.y = _dragBounds.bottom;
		}
			
		/**
		 * set a ScrollableContent instance to scroll / listen to
		 * @param content Scrollable content instance
		 * @see com.pokelondon.orange.rockcorps.view.components.scrollbar.ScrollableContent
		 */
		 // TODO inteface
		public function setContent( content:IScrollableContent ):void {
			//Debug.log(this+".setContent():"+content);
			_content = content;
			addScrollBarListener(_content);
			// TODO unsafe cast
			(_content as EventDispatcher).addEventListener( Event.CHANGE, onContentChange, false, 0, true );
			enabled = true;
			onContentChange();
			enableMouseWheel();
			if(!mouseOverHelper){
				mouseOverHelper = new MouseOverHelper();
				mouseOverHelper.autolockBrowserScroll = true;
			}
			
			mouseOverHelper.mouseTarget = content.content;
		}
		
		// TODO interface
		public function addScrollBarListener( listener:IScrollBarListener ):void{
			addEventListener( Event.CHANGE, listener.onScrollBarChanged, false, 0, true );
//			addEventListener( DRAG_START, listener.onScrollBarDragStart, false, 0, true );
//			addEventListener( DRAG_END, listener.onScrollBarDragEnd, false, 0, true );
		}
		
		// TODO interface
		public function removeScrollBarListener( listener:IScrollBarListener ):void{
			removeEventListener( Event.CHANGE, listener.onScrollBarChanged );
//			removeEventListener( DRAG_START, listener.onScrollBarDragStart );
//			removeEventListener( DRAG_END, listener.onScrollBarDragEnd );
		}
		
		/**
		 * respond to a change in the ScrollableContent
		 * @param e Event
		 */
		 // TODO interface
		public function onContentChange( e:Event = null ):void {
			// ignore updates while dragging
			if( _dragging ) return;
			
			// scale dragger
			if( scaleDragger ){
				_dragger[ dimension ] = Math.round(_content.getVisibleContentPercent( axis ) * _availableTrackLength);
				if( _dragger[ dimension ] < _minDraggerLength ){
					_dragger[ dimension ] = _minDraggerLength;
				} else if( _dragger[ dimension ] > _availableTrackLength) {
					_dragger[ dimension ] = _availableTrackLength;
				}
//				if(_dragger is UISprite) (_dragger as UISprite).draw();
			}
			// position dragger
			_dragger[ _axis ] = getDraggerPositionMin() + _content.getPositionPercent( axis ) * (getDraggerPositionMax() - getDraggerPositionMin());
			// check scrolling required
			_updateEnabled();
		}

		/**
		 * prepare scrollbar instance to be released from memory
		 */
		 //
		public function release():void {
			if( _content ) {
				// FIXME unsafe cast
				(_content as EventDispatcher).removeEventListener(Event.CHANGE, onContentChange );
				removeScrollBarListener(_content);		
				_content = null;
			}
			
			if(_dragger){
				_dragger.removeEventListener(MouseEvent.MOUSE_DOWN, onDraggerMouseDown );
				_dragger.removeEventListener(MouseEvent.MOUSE_UP, onDraggerMouseUp );
				_dragger = null;
			}
			
			if( _track){
				_track.removeEventListener(MouseEvent.MOUSE_DOWN, onTrackMouseDown );
				_track.removeEventListener(MouseEvent.MOUSE_UP, onTrackMouseUp );
				_track = null;			
			}
			
			if( _dragUpdateTimer ){
				_dragUpdateTimer.stop();
				_dragUpdateTimer.removeEventListener(TimerEvent.TIMER, onDragUpdate);
				_dragUpdateTimer = null;
			}
			
			if( _trackScrollTimer ) {
				_trackScrollTimer.stop();
				_trackScrollTimer.removeEventListener(TimerEvent.TIMER, onTrackScroll);
				_trackScrollTimer = null;
			}
			
			if( _upBtn && _upBtn is RepeaterButton){
				_upBtn.removeEventListener(RepeaterButtonEvent.BUTTON_DOWN, onUpBtnDown );
			} else {
				_upBtn.removeEventListener(MouseEvent.CLICK, onUpBtnDown );
			}
			
			if( _downBtn && _upBtn is RepeaterButton ){
				_downBtn.removeEventListener(RepeaterButtonEvent.BUTTON_DOWN, onDownBtnDown );
			} else {
				_downBtn.removeEventListener(MouseEvent.CLICK, onDownBtnDown );
			}		

		}
		
		// TODO try private
		public function notifyChanged():void {
			dispatchEvent(new Event( Event.CHANGE ) );
		}
		
		/**
		 * get the current 'scrolledness' as a percentage (0-1) of
		 * @return Number 0 for not scrolled at all, 1 for maximum scroll
		 */
		 
		 // TODO interface
		public function getScrolledPercent():Number {
			return (_dragger[ _axis ] - getDraggerPositionMin()) / (getDraggerPositionMax() - getDraggerPositionMin());
		}
		
		/**
		 * called by elsewhere in application to disable user interaction completely
		 * @param b Boolean true/false to enable/disable scrollbar respectively
		 */
		 
		 // TODO interface
		public function set enabled( b:Boolean ):void {
			_uiEnabled = b;
			_updateEnabled();
		}

		/**
		 * internal implementation decide whether to enable/disable
		 * based on autoEnable and uiEnabled
		 */
		protected function _updateEnabled():void{
			if( !_uiEnabled ){
				_setScrollingEnabled(false);
			} else {
				if( _autoEnable ){
					_setScrollingEnabled( _content.isScrollingRequired( axis ) );
				} else {
					_setScrollingEnabled(true);
				}
			}
		}
		
		/**
		 * set user interaction enabled/disabled
		 * 
		 * @param b Boolean tru to enable scrollbar

 * 		 * TODO should maybe be configgable what is hidden when disabled
		 */	
		protected function _setScrollingEnabled( b:Boolean ):void{
			_dragger.visible = b;
			if( _downBtn )_downBtn.visible = b;
			if( _upBtn ) _upBtn.visible = b;
			_track.visible = b;
//			if( _track is SkinnedButton ) {
//				(_track as SkinnedButton).enabled = b;				
//			} else {
				_track.mouseEnabled = b;
//			}
			_isEnabled = b;
		}

		/**
		 * get whether scrollbar is currently enabled/disabled
		 * @return Boolean true if scrolbar is currently enabled
		 */
		 // TODO interface
		public function get enabled():Boolean {
			return _isEnabled;
		}

		/**

		 * get scrollbar axis string e.g. 'x' or 'y'
		 * @return the axis that the scrollbar operates on 
		 */
		 
		  // TODO interface
		public function get axis():String {
			return _axis;
		}
		
		
/**
		 * DEPRECATED
		 * get the length of the track for the current axis
		 * track length is also the range that the dragger may move within
		 */
		 
		public function get trackLength():Number {
			return _track[ dimension ]; //_axis == 'y' ? _track.height : _track.width;
		}
		
		/**
		 * DEPRECATED
		 * set the length of the track for the current axis
		 */
		public function set trackLength( n:Number ):void {
			_track[ dimension ] = n;
			onContentChange();
		}
		
		
		/**
		 * get the length dimension for the current axis
		 * i.e. height for y, width for x
		 * @return String of dimension property
		 */
		 // TODO private
		public function get dimension():String {
			return _axis == 'y' ? 'height' : 'width';
		}

		/**
		 * get the opposite dimension for the current axis
		 * i.e. width for y, height for x
		 * @return String of opposite dimension property
		 */
		 
		  // TODO private
		public function get oppositeDimension():String {
			return _axis == 'y' ? 'width' : 'height';
		}		
		
		/**

		 * get the dragger position (for the current axis) at min scroll
		 * @return Number minimum poisition in pixels
		 * TODO separate from track sprite use min and max vals already def
		 */
		  // TODO private
		public function getDraggerPositionMin():Number {
			return _availableTrackMin;
		}
		
		
/**
		 * get the dragger position (for the current axis) at max scroll
		 * @return Number maximum position in pixels
		 */
		  // TODO private
		 
		public function getDraggerPositionMax():Number {
			return _availableTrackMax - _dragger[ dimension ];
		}


		/**
		 * get Rectangle representing the limits of dragger drag operation
		 * @return Rectangle containing drag limits
		 */
		public function getDragRect():Rectangle {
			var r:Rectangle = new Rectangle();
			if( _axis == 'y' ){
				r.left = _dragger.x;
				r.right = _dragger.x;
				r.top = getDraggerPositionMin();
				r.bottom = getDraggerPositionMax();
			} else {
				r.left = getDraggerPositionMin();
				r.right = getDraggerPositionMax();
				r.top = _dragger.y;
				r.bottom = _dragger.y;
			}
			return r;
		}
		
		/**
		 * set the minimum length of the dragger to prevent it getting 
		 * too small when scrollable content is very large
		 * @param n minum length in pixels
		 */
		public function set draggerLengthMin( n:Number ):void {
			_minDraggerLength = n;
		}
		
		/**
		 * get the minimum length of the dragger
		 * @return minimum dragger length in pix
		 */
		public function get draggerLengthMin():Number {
			return _minDraggerLength;
		}
		
//		/**
//		 * get the maximum length of the dragger
//		 * i.e. the track length or the size of the dragger when no scrolling required
//		 */
//		public function getDraggerLengthMax():Number {
//			return availableTrackMax - _dragger[ dimension ];
//		}		
		
		/**
		 * keep the dragger sprite with in lims
		 */
		protected function keepDraggerWithinLimits():void{
			if( _dragger[ _axis ] < getDraggerPositionMin() ) _dragger[ _axis ] = getDraggerPositionMin();
			else if( _dragger[ _axis ] > getDraggerPositionMax() ) _dragger[ _axis ] = getDraggerPositionMax();
		}
		
		/**
		 * set whether the scrollbar will automatically disable
		 * when it's scrollable content does not require scrolling
		 * @param Boolean true to turn autoEnable on
		 */
		public function set autoEnable( b:Boolean ):void {
			_autoEnable = b;
		}
		
		/**
		 * get auto enable setting
		 * @return boolean true if autoEnable is on 
		 */
		public function get autoEnable():Boolean {
			return _autoEnable;
		}

		public function enableMouseWheel():void {
			MouseWheel.getInstance().removeMouseWheelListener(this);
			MouseWheel.getInstance().addMouseWheelListener(this);
		}
		
		public function disableMouseWheel():void {
			MouseWheel.getInstance().removeMouseWheelListener(this);
		}
		
		/**
		 * respond to mouse wheel scrolling (requires MacMouseWheel js listener on Mac)
		 */
		public function onMouseWheel ( e:MouseWheelEvent ) : void {
			var delta : Number = e.delta;
			if (_isEnabled && _axis == 'y' && mouseOverHelper && mouseOverHelper.mouseIsOver ) {
				_dragger[ _axis ] += -delta * _mouseWheelSpeed;
				keepDraggerWithinLimits();
				notifyChanged();
			}
		}
		
		/**
		 * set the scroll up and down btns alignment
		 */
		public function set buttonAlignment( alignment:String ):void {
			_btnAlignment = alignment;
		}
		
		/**
		 * get the buttonAlignment setting
		 */
		public function get buttonAlignment():String {
			return _btnAlignment;
		}

		/**
		 * TODO 
		 * replacement for deprecated set trackLength at the moment
		 * should be the only publicly used method to set scrollbar length
		 */
		  // TODO interface
		  
		public function set totalLength( n:Number ):void {
			_track[ dimension ] = n;
			
			_availableTrackMin = _track[ _axis ];
			_availableTrackMax = _track[ _axis ] + _track[ dimension ];
			
			postionUpBtn();
			postionDownBtn();
			
			_availableTrackLength = _availableTrackMax - _availableTrackMin;
			// TODO will need to do an update
			//onContentChange();
		}
		
		protected function postionUpBtn():void {
			if(!_upBtn) return;
			
			switch( _btnAlignment )
			{
				case ScrollBarButtonAlignment.SPLIT :
				case ScrollBarButtonAlignment.BOTH_UP :
				{
					_upBtn[ axis ] = _track[ _axis ];
					_availableTrackMin += _upBtn[ dimension ];
					break;
				}	
				case ScrollBarButtonAlignment.BOTH_DOWN :
				{
					_upBtn[ axis ] = _track[ _axis ] + _track[ dimension ] - _upBtn[ dimension ] - (_downBtn ? _downBtn[dimension] : 0);
					_availableTrackMax -= _upBtn[ dimension ];				
					break;
				}
			}				
		}
		
		protected function postionDownBtn():void {
			if(!_downBtn) return;
			switch( _btnAlignment )
			{
				case ScrollBarButtonAlignment.BOTH_UP :
				{
					_downBtn[ axis ] = _track[ _axis ] + (_upBtn ? _upBtn[dimension] : 0);
					_availableTrackMin += _downBtn[ dimension ];
					break;
				}
				case ScrollBarButtonAlignment.SPLIT :
				case ScrollBarButtonAlignment.BOTH_DOWN :
				{
					_downBtn[ axis ] = _track[ _axis ] + _track[ dimension ] - _downBtn[ dimension ];
					_availableTrackMax -= _downBtn[ dimension ];
					break;
				}
			}				
		}
		
		public function get totalLength():Number {
			return _track[ dimension ];
		}

		// TODO make woek with all cases
//		public function get availableTrackMin():Number {
//			return _track[ _axis ];
//		}
//		
//		public function get availableTrackMax():Number {
//			return _track[ _axis ] + _track[ dimension ];
//		}
//
//		public function get availableTrackLength():Number {
//			return _track[ dimension ];
//		}
		
	}
}

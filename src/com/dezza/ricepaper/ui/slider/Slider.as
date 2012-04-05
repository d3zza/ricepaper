package com.dezza.ricepaper.ui.slider
{

	import com.dezza.ricepaper.ui.dragger.Dragger;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Rectangle;

	/**
	 * @author derek
	 */
	public class Slider extends Dragger implements ISlider
	{
		protected var _axis : String;

		protected var _track : Sprite;

		protected var _percent : Number;

		/**
		 * construct Slider instance
		 * 
		 * @param dragger MovieClip asset
		 * 
		 * @param dragRect Rectangle containing slider bounds - note dimension opposite to axis will be ignored
		 * 
		 * @param buttonMode Boolean indicating whether or not use buttonMode on the dragger
		 * 
		 * @param startingPercent Number initial dragger position as a percentage between min and max
		 * 
		 * @param track MovieClip optional element to use as clickable track element that will reposition slider
		 * 
		 * @param axis String either 'x' or 'y' to use as the axis of dragging
		 */
		public function Slider(content : MovieClip, dragRect : Rectangle = null, buttonMode : Boolean = true, startingPercent : Number = 0.25, track : Sprite = null, axis : String = "x")
		{
			super(content, dragRect, buttonMode);

			setAxis(axis);

			percent = startingPercent;

			// if ( track ) _setTrack(track);
		}


		/**
		 * get the axis
		 * 
		 * @return String instance "x" or "y"
		 */
		public function get axis() : String
		{
			return _axis;
		}


		/**
		 * get the slider percentage
		 * 
		 * @return Number between 0 and 1
		 */
		public function get percent() : Number
		{
			return ( ( this[_axis] - dragMin) / (dragMax - dragMin) * 10000) / 10000;

//			return _percent;
		}


		/**
		 * set dragger position as percent 
		 * 
		 * 0 would set dragger to minimum position
		 * 1 would set dragger to maximum position
		 * 
		 * @param percent Number between 0 and 1
		 */
		public function set percent(percent : Number) : void
		{
			if ( percent > 1) percent = 1;
			else if ( percent < 0 ) percent = 0;

			if (_percent != percent)
			{
				_percent = percent;
				if ( !isDragging ) updatePos();
			}
		}


		/**
		 * set the bounds of the slider
		 * 
		 * note dimensions opposite to axis will be ignored
		 * 
		 * @param rect Rectangle containing min and max slider postions
		 * 
		 */
		override public function setDragRect(rect : Rectangle) : void
		{
			_dragRect = rect;
		}


		public function get dragMin() : Number
		{
			return _axis == "x" ? _dragRect.left : _dragRect.top;
		}


		public function get dragMax() : Number
		{
			return _axis == "x" ? _dragRect.right : _dragRect.bottom;
		}


		public function updatePos() : void
		{
			this[_axis] = dragMin + (dragMax - dragMin) * _percent;
		}


		/**
		 * @private
		 */
		private function setAxis(axis : String) : void
		{
			if ( axis != "x" && axis != "y" )
			{
				throw new ArgumentError("invalid argument passed for axis");
			}

			_axis = axis;
		}
		
		
		// protected function _onDragUpdate() : void
		// {
		// var n : Number = Math.round((_dragger[_axis] - _dragMin) / (_dragMax - _dragMin) * 10000) / 10000;
		// if ( _percent == n) return;
		// percent = n;
		// dispatchEvent(new Event(BasicSlider.sliderChangedEVENT));
		// }
		
		
		// protected function dispatchChangeEvent() : void
		// {
		// dispatchEvent(new DraggerEvent(DraggerEvent.DRAG_CHANGE, true, false));
		// }
		
		//
		// public function onDraggerChanged(e : Event) : void
		// {
		// _onDragUpdate( );
		// }
	
		// override public function release():void {
		// _dragger.removeDraggerListener( this );
		// _dragger = null;
		// _releaseTrack();
		// _track = null;
		// }
		//				
		// protected function _setTrack( sprite : Sprite ) : void
		// {
		// if( !sprite ) throw new ArgumentError( this + ".setTrackBar() fails with invalid arg" );
		// if( _track ) _releaseTrack( );
		// _track = sprite;
		// _track.addEventListener( MouseEvent.MOUSE_DOWN, _onTrackMouseDown );
		// }
		//
		// protected function _releaseTrack() : void
		// {
		// if(_track) _track.removeEventListener( MouseEvent.MOUSE_DOWN, _onTrackMouseDown );
		// }


		// /**
		// * set the min and max dragger positions
		// */
		// public function setDragLimits(n1 : Number, n2 : Number) : void 
		// {
		// if (isNaN( n1 ) || isNaN( n2 ))
		// {
		// var msg : String = "Invalid parameter passed to setDragLimits(" + n1 + ", " + n2 + ")";
		//				//  DezzaDebug.ERROR( msg );
		// throw new ArgumentError( msg );
		// }
		//			//  floor values to match way flash returns posns during drag
		// _dragMin = Math.floor( n1 ); 
		// _dragMax = Math.floor( n2 ); 
		// _updateDragRect( );
		// updateDraggerPos();
		// }	
		//
		// /**
		// * update the drag rectangle i.e. the area that the dragger can move in
		// */
		// protected function _updateDragRect() : void 
		// {
		// if (_axis == "x")
		// {
		// _dragRect.left = _dragMin;
		// _dragRect.right = _dragMax;
		// _dragRect.top = _dragRect.bottom = _dragger.y;
		// } else 
		// {
		// _dragRect.top = _dragMin;
		// _dragRect.bottom = _dragMax;
		// _dragRect.left = _dragRect.right = _dragger.x;
		// }
		// if (_dragger) _dragger.setDragRect( _dragRect );
		// else 
		// {
		//				//  DezzaDebug.WARN( this + "._updateDragRect() was called and no dragger is registered" );
		// }
		// }
		//
		// /**
		// * called every frame during drag operation to update drag percentage value
		// */
		// protected function _onDragUpdate() : void
		// {
		// var n:Number = Math.round((_dragger[_axis] - _dragMin) / (_dragMax - _dragMin) * 10000)/10000;
		// if( _percent == n) return;
		// percent = n;
		// dispatchEvent(new Event(BasicSlider.sliderChangedEVENT));
		//		
		// }
		//
		//
		// /**
		// * handler for track mouse down event - i.e. start dragging operation
		// * 
		// * @param e MouseEvent
		// */
		// protected function _onTrackMouseDown(e : MouseEvent) : void
		// {
		// if( !_enabled ) return;
		// if( _dragger && _dragger.dragger.parent){
		// var mousePos : Number = _axis == "x" ? _dragger.dragger.parent.mouseX : _dragger.dragger.parent.mouseY;
		// percent = (mousePos - _dragMin) / (_dragMax - _dragMin);
		// _dragger.startDrag();
		// }
		//			
		// }
	}
}

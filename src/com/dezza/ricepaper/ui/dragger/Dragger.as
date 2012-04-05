package com.dezza.ricepaper.ui.dragger
{

	import com.dezza.ricepaper.ui.core.UIControl;

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	/**
	 * BasicDragger
	 * 
	 * Abstracts dragging functionality and provides and event system for
	 * the following events:
	 * 
	 * dragging starts;
	 * dragged asset changes;
	 * dragging ends.
	 *
	 *@see <code>com.dezza.ricepaper.ui.dragger.DraggerEvent</code>
	 *
	 * @author Derek McKenna
	 * @version 1.0
	 * @since Feb 15, 2009
	 */
	public class Dragger extends UIControl implements IDragger
	{
		/**
		 * @private
		 */
		protected var _dragging : Boolean;

		/**
		 * @private
		 */
		protected var _dragRect : Rectangle;

		/**
		 * @private
		 */
		protected var _buttonMode : Boolean;

		/**
		 * @private
		 */
		protected var _lastX : Number;

		/**
		 * @private
		 */
		protected var _lastY : Number;

		/**
		 * Construct new Dragger instance
		 * 
		 * @param asset MovieClip instance containing visuals
		 * 
		 * @param dragRect bounds for dragging ops
		 * 
		 * @param buttonMode Boolean true to use button cursor (default true)
		 */
		public function Dragger(asset : MovieClip, dragRect : Rectangle = null, buttonMode : Boolean = true)
		{
			super(asset);

			_dragRect = dragRect ? dragRect : new Rectangle() ;

			_buttonMode = buttonMode;

			enabled = true;

			init();
		}


		/**
		 * update the dragRect bounds
		 * 
		 * @param rect <code>flash.geomRectangle</code> instance
		 */
		public function setDragRect(rect : Rectangle) : void
		{
			_dragRect = rect;
		}


		/**
		 * @return Boolean true if a drag operation is currently in progress
		 */
		public function get isDragging() : Boolean
		{
			return _dragging;
		}


		/**
		 * add a listener to all Dragger events
		 * 
		 * @param listener <code>com.dezza.ricepaper.ui.dragger.DraggerListener</code> implementation
		 */
		public function addDraggerListener(listener : IDraggerListener) : void
		{
			removeDraggerListener(listener);

			addEventListener(DraggerEvent.DRAG_START, listener.onDragStart);
			addEventListener(DraggerEvent.DRAG_STOP, listener.onDragStop);
			addEventListener(DraggerEvent.DRAG_CHANGE, listener.onDragChange);
		}


		/**
		 * remove a listener from all Dragger events
		 * 
		 * @param listener <code>com.dezza.ricepaper.ui.dragger.DraggerListener</code> implementation
		 */
		public function removeDraggerListener(listener : IDraggerListener) : void
		{
			removeEventListener(DraggerEvent.DRAG_START, listener.onDragStart);
			removeEventListener(DraggerEvent.DRAG_STOP, listener.onDragStop);
			removeEventListener(DraggerEvent.DRAG_CHANGE, listener.onDragChange);
		}


		/**
		 * @inheritDoc
		 */
		override public function set enabled(b : Boolean) : void
		{
			if ( !b && _dragging ) stopDragging();

			if ( _buttonMode ) buttonMode = b;

			super.enabled = b;
		}


		/**
		 * @private
		 */
		public function startDragging() : void
		{
			if ( !enabled || _dragging ) return;

			if ( !stage ) throw new Error("Dragger is not on stage");

			_dragging = true;

			startDrag(true, _dragRect);

			stage.addEventListener(MouseEvent.MOUSE_UP, _onMouseUp, false, 0, true);

			stage.addEventListener(Event.ENTER_FRAME, onEnterFrme, false, 0, true);

			dispatchEvent(new DraggerEvent(DraggerEvent.DRAG_START, true, false));
		}


		/**
		 * @private
		 */
		public function stopDragging() : void
		{
			if ( !enabled ) return;

			_dragging = false;

			if ( stage )
			{
				stage.removeEventListener(MouseEvent.MOUSE_UP, _onMouseUp);

				stage.removeEventListener(Event.ENTER_FRAME, onEnterFrme);

				stopDrag();
			}

			dispatchEvent(new DraggerEvent(DraggerEvent.DRAG_STOP, true, false));
		}


		/**
		 * @inheritDoc
		 */
		override public function destroy() : void
		{
			removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);

			// TODO handle removal of component from stage while dragging
			if ( stage )
			{
				stage.removeEventListener(MouseEvent.MOUSE_UP, _onMouseUp);
				stage.removeEventListener(Event.ENTER_FRAME, onEnterFrme);
			}

			super.destroy();
		}


		/**
		 * @private
		 */
		protected function init() : void
		{
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}


		/**
		 * @private
		 */
		protected function onMouseDown(e : MouseEvent = null) : void
		{
			startDragging();
		}


		/**
		 * @private
		 */
		protected function _onMouseUp(e : MouseEvent) : void
		{
			stopDragging();
		}


		/**
		 * @private
		 */
		protected function onEnterFrme(e : Event = null) : void
		{
			if( x != _lastX || y != _lastY )
			{
				dispatchChangeEvent();
			}
		}


		/**
		 * @private
		 */
		protected function dispatchChangeEvent() : void
		{
			if( x === _lastX && y === _lastY ) return;
			
			dispatchEvent(new DraggerEvent(DraggerEvent.DRAG_CHANGE, true, false));
			
			_lastX = x;
			_lastY = y;
		}
	}
}

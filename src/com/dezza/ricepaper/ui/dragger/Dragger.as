package com.dezza.ricepaper.ui.dragger
{

	import flash.display.DisplayObject;
	import com.dezza.ricepaper.ui.core.UIControl;

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	/**
	 * BasicDragger
	 * Class Description.
	 *
	 * @author Derek McKenna
	 * @version 1.0
	 * @since Feb 15, 2009
	 */
	public class Dragger extends UIControl implements IDragger
	{
		protected var _dragging : Boolean;

		protected var _dragRect : Rectangle;

		protected var _buttonMode : Boolean;

		public function Dragger(content : MovieClip, dragRect : Rectangle = null, buttonMode : Boolean = true)
		{
			super(content);
			
			_dragRect = dragRect ? dragRect : new Rectangle() ;
			
			_buttonMode = buttonMode;
			
			enabled = true;
			
			init();
		}


		public function setDragRect(rect : Rectangle) : void
		{
			_dragRect = rect;
		}


		override public function destroy() : void
		{
			removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);

			if ( stage )
			{
				stage.removeEventListener(MouseEvent.MOUSE_UP, _onMouseUp);
				stage.removeEventListener(Event.ENTER_FRAME, onEnterFrme);
			}
		}


		public function get isDragging() : Boolean
		{
			return _dragging;
		}


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


		public function addDraggerListener(listener : DraggerListener) : void
		{
			removeDraggerListener(listener);

			addEventListener(DraggerEvent.DRAG_START, listener.onDragStart);
			addEventListener(DraggerEvent.DRAG_STOP, listener.onDragStop);
			addEventListener(DraggerEvent.DRAG_CHANGE, listener.onDragChange);
		}


		public function removeDraggerListener(listener : DraggerListener) : void
		{
			removeEventListener(DraggerEvent.DRAG_START, listener.onDragStart);
			removeEventListener(DraggerEvent.DRAG_STOP, listener.onDragStop);
			removeEventListener(DraggerEvent.DRAG_CHANGE, listener.onDragChange);
		}


		override public function set enabled(b : Boolean) : void
		{
			if ( !b && _dragging ) stopDragging();

			if ( _buttonMode ) buttonMode = b;

			super.enabled = b;
		}


		protected function init() : void
		{
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}


		/**
		 * handler for dragger mouse down event - i.e. start dragging operation
		 * 
		 * @param e MouseEvent
		 */
		protected function onMouseDown(e : MouseEvent = null) : void
		{
			startDragging();
		}


		/**
		 * handle mouse up event ( i.e. anywhere on stage ) to stop dragging operation
		 * 
		 * @param e MouseEvent
		 */
		protected function _onMouseUp(e : MouseEvent) : void
		{
			stopDragging();
		}


		public function onEnterFrme(e : Event = null) : void
		{
			dispatchEvent(new DraggerEvent(DraggerEvent.DRAG_CHANGE, true, false));
		}
	}
}

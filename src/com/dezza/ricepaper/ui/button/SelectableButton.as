package com.dezza.ui.button {

	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	/**
	 * @author derek
	 */
	public class SelectableButton extends UIButton {

		protected var _selected : Boolean;

		/**
		 * current mouse state i.e. "up","over"
		 */
		protected var _mouseState : String;

		/**
		 * whether or not the mouse state is currently locked
		 */
		protected var _mouseStateLocked : Boolean;

		/**
		 * mouse state to apply to mouse when unlocked
		 */
		protected var _unlockedMouseState : String;

		public function SelectableButton(content : MovieClip, id : String = null, wrapContent : Boolean = true) {
			super(content, id, wrapContent);

			setMouseState("up");
		}

		override protected function onRollOver(event : MouseEvent) : void {
			
			super.onRollOver(event);

			setMouseState("over");

			renderState();
			
		}


		override protected function onRollOut(event : MouseEvent) : void {
			
			super.onRollOver(event);

			setMouseState("up");

			renderState();
			
		}


		public function setMouseStateLocked(b : Boolean) : void {
			_mouseStateLocked = b;
			if ( !b ) {
				setMouseState(_unlockedMouseState);
			} else {
				_unlockedMouseState = _mouseState;
			}
		}


		/**
		 * set button to 'selected' state
		 * 
		 * @param b <code>Boolean</code> indicating whether button is selected
		 */
		public function set selected(b : Boolean) : void {
			_selected = b;
			renderState();
		}


		/**
		 * get whether button is selected
		 * 
		 * @param <code>Boolean</code> true if button is selected
		 */
		public function get selected() : Boolean {
			return _selected;
		}

		/**
		 * mouse up handler
		 */
		protected function onMouseUp(e : MouseEvent) : void {
			setMouseState("up");
		}


		/**
		 * set the current mouse state i.e. "up","over"
		 * 
		 * @param mouseState String representing mouse state
		 * 
		 */
		protected function setMouseState(mouseState : String) : void {
			if ( _mouseStateLocked ) {
				_unlockedMouseState = mouseState;
				return;
			}
			if ( mouseState == _mouseState) return;
			_mouseState = mouseState;
			renderState();
		}


		protected function renderState() : void {
			
			// get one of the possible states
			// _up, _over, _upSelected, _overSelected
			var frame : String = "_" + _mouseState;
			if (_selected) frame += "Selected";

			content.gotoAndStop(frame);
			
		}
	}
}

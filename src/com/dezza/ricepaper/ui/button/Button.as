package com.dezza.ricepaper.ui.button
{

	import com.dezza.ricepaper.ui.core.UIControl;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	/**
	 * @author derek
	 */
	public class Button extends UIControl implements IButton
	{
		/**
		 * current mouse state i.e. "off","on"
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

		public function Button(content : MovieClip)
		{
			super(content);

			setMouseState(ButtonState.OFF);

			initMouse();
		}


		/**
		 * @inheritDoc
		 */
		override public function set enabled(enabled : Boolean) : void
		{
			super.enabled = mouseEnabled = enabled;

			renderState();
		}


		/**
		 * @inheritDoc
		 */
		public function get mouseStateLocked() : Boolean
		{
			return _mouseStateLocked;
		}


		/**
		 * @inheritDoc
		 */
		public function set mouseStateLocked(locked : Boolean) : void
		{
			_mouseStateLocked = locked;
			if ( !locked )
			{
				setMouseState(_unlockedMouseState);
			}
			else
			{
				_unlockedMouseState = _mouseState;
			}
		}


		/**
		 * get the button's on/off state
		 */
		public function get highlighted() : Boolean
		{
			return _mouseState == ButtonState.ON;
		}


		/**
		 * set the button's on/off state
		 */
		public function set highlighted(highlighted : Boolean) : void
		{
			setMouseState(highlighted ? ButtonState.ON : ButtonState.OFF);
		}


		public function addAutoHitArea( debug:Boolean = false ) : void
		{
			var hit : Sprite = new Sprite();
			addChild(hit);
			var contentRect : Rectangle = content.getBounds(this);
			with( hit.graphics )
			{
				beginFill(0x32FFFF, 0.3);
				drawRect(contentRect.x - 1, contentRect.y - 1, contentRect.width + 2, contentRect.height + 2);
				endFill;
			}
			hit.visible = debug;
			hitArea = hit;
		}


		/**
		 * @inheritDoc
		 */
		override public function destroy() : void
		{
			removeEventListener(MouseEvent.ROLL_OVER, onRollOver);
			removeEventListener(MouseEvent.ROLL_OUT, onRollOut);

			super.destroy();
		}


		protected function initMouse() : void
		{
			addEventListener(MouseEvent.ROLL_OVER, onRollOver);
			addEventListener(MouseEvent.ROLL_OUT, onRollOut);

			buttonMode = true;
			mouseChildren = false;

			enabled = true;
		}


		/**
		 * set the current mouse state
		 * 
		 * mouseState can be either
		 * 
		 * ButtonState.OFF representing mouse off button
		 * 
		 * or 
		 * 
		 * ButtonState.ON representing mouse on (or over) button
		 * 
		 * @param mouseState String representing mouse state
		 * 
		 */
		protected function setMouseState(mouseState : String) : void
		{
			if ( _mouseStateLocked )
			{
				_unlockedMouseState = mouseState;
				return;
			}

			if ( mouseState == _mouseState) return;

			_mouseState = mouseState;

			renderState();
		}


		protected function renderState() : void
		{
			content.gotoAndStop(enabled ? _mouseState : ButtonState.DISABLED);
		}


		protected function onRollOver(event : MouseEvent) : void
		{
			setMouseState(ButtonState.ON);
		}


		protected function onRollOut(event : MouseEvent) : void
		{
			setMouseState(ButtonState.OFF);
		}
	}
}

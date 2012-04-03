package com.dezza.ricepaper.ui.button
{

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	/**
	 * @author derek
	 */
	public class UIButton extends Sprite implements Button
	{
		/**
		 * content asset MovieClip
		 * 
		 * if content is already attached to a parent the UIButton will attach itself in place and add the asset as it's child
		 */
		private var _content : MovieClip;

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

		public function UIButton(content : MovieClip)
		{
			if (content)
			{
				x = content.x;
				y = content.y;
				content.x = 0;
				content.y = 0;

				if (content.parent)
				{
					content.parent.addChildAt(this, content.parent.getChildIndex(content));
				}

				addChild(content);

				_content = content;
			}
			else
			{
				throw new ArgumentError("UIButton content is undefined");
			}

			setMouseState(ButtonState.OFF);

			initMouse();
		}


		public function get content() : MovieClip
		{
			return _content;
		}


		/**
		 * @inheritDoc
		 */
		public function get enabled() : Boolean
		{
			return mouseEnabled;
		}


		/**
		 * @inheritDoc
		 */
		public function set enabled(enabled : Boolean) : void
		{
			mouseEnabled = enabled;

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


		public function addAutoHitArea() : void
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
			hit.visible = false;
			hitArea = hit;
		}


		public function destroy() : void
		{
			_content = null;
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

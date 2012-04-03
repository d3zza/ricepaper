package com.dezza.ricepaper.ui.button
{

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

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


		public function destroy() : void
		{
			_content = null;
		}


		// public function get textField() : TextField
		// {
		//			//  labelContainer.label by convention
		//
		// if (content.labelContainer )
		// {
		// return content.labelContainer.label;
		// }
		//
		// return null;
		// }
		//
		//
		// public function get text() : String
		// {
		// if ( textField )
		// {
		// return textField.text;
		// }
		//
		// return null;
		// }
		//
		//
		// public function set text(text : String) : void
		// {
		// if ( textField )
		// {
		// textField.text = text;
		// }
		// else
		// {
		// throw new IllegalOperationError("UIButton does not contain a labelContainer.label textField instance");
		// }
		// }
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
			// should be one of the possible ButtonState values
			var frame : String = _mouseState;

			if ( !enabled )
			{
				frame += "Disabled";
			}

			content.gotoAndStop(frame);
		}


		protected function onRollOver(event : MouseEvent) : void
		{
			setMouseState(ButtonState.ON);
		}


		protected function onRollOut(event : MouseEvent) : void
		{
			setMouseState(ButtonState.OFF);
		}
		// public function addHitArea() : void
		// {
		// var hit : Sprite = new Sprite();
		// addChild(hit);
		// var contentRect : Rectangle = content.getBounds(this);
		// with( hit.graphics )
		// {
		// beginFill(0x32FFFF, 0.3);
		// drawRect(contentRect.x - 1, contentRect.y - 1, contentRect.width + 2, contentRect.height + 2);
		// endFill;
		// }
		// hit.visible = false;
		// hitArea = hit;
		// }
	}
}

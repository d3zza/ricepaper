package com.dezza.ricepaper.ui.button
{

	import com.dezza.ricepaper.ui.core.ISelectable;


	import flash.display.MovieClip;

	/**
	 * @author derek
	 */
	public class SelectableButton extends Button implements ISelectable
	{

		/**
		 * @private
		 */
		protected var _selected : Boolean;


		public function SelectableButton(content : MovieClip, mouseChildren : Boolean = false)
		{
			super(content, mouseChildren);
		}


		/**
		 * set button to 'selected' state
		 * 
		 * @param b <code>Boolean</code> indicating whether button is selected
		 */
		public function set selected(b : Boolean) : void
		{
			_selected = b;
			renderState();
		}


		/**
		 * get whether button is selected
		 * 
		 * @param <code>Boolean</code> true if button is selected
		 */
		public function get selected() : Boolean
		{
			return _selected;
		}


		/**
		 * @private
		 */
		override protected function renderState() : void
		{
			if ( !enabled )
			{
				_stateRenderer.render(ButtonState.DISABLED);
			}
			else if ( _selected )
			{
				_stateRenderer.render(_mouseState == ButtonState.ON ? ButtonState.ON_SELECTED : ButtonState.OFF_SELECTED);
			}
			else
			{
				_stateRenderer.render(_mouseState);
			}
		}
	}
}

package com.dezza.ricepaper.ui.movieclip
{

	import com.dezza.ricepaper.ui.core.IRenderer;


	import flash.display.DisplayObject;

	/**
	 * @author derek
	 * 
	 * renders visual states by turning on/off DisplayObjects
	 */
	public class SkinStateRenderer implements IRenderer
	{

		/**
		 * hash of available states
		 */
		private var _availableStates : Object;

		private var _lastState : String;


		public function SkinStateRenderer()
		{
			_availableStates = {};
		}


		public function setSkinsForState(state : String, skins : Array) : void
		{
			if ( !state ) return;

			var skin : DisplayObject;

			// create an array for state if it doesn't already exist
			_availableStates[ state ] = [];

			if ( skins )
			{
				for (var i : int = 0; i < skins.length; i++)
				{
					skin = skins[i] as DisplayObject;

					if ( !skin ) continue;

					if ( _availableStates[state].indexOf(skin) !== -1 ) continue;

					_availableStates[state].push(skin);
				}
			}
		}


		public function render(state : String) : void
		{
			var skins : Array, skin : DisplayObject, i : int;

			// turn off old
			if ( _lastState )
			{
				skins = _availableStates[ _lastState ];

				if ( skins && skins.length )
				{
					for ( i = 0; i < skins.length; i++)
					{
						skin = skins[i] as DisplayObject;

						if ( !skin ) continue;

						skin.visible = false;
					}
				}
			}

			if ( state )
			{
				skins = _availableStates[ state ];

				if ( skins && skins.length )
				{
					for ( i = 0; i < skins.length; i++)
					{
						skin = skins[i] as DisplayObject;

						if ( !skin ) continue;

						skin.visible = true;
					}
				}
				else
				{
					// trace(this + "render() state '" + state + "' no skins found");
				}
			}

			_lastState = state;
		}


		public function dispose() : void
		{
			_availableStates = null;
		}
	}
}

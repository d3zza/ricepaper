package com.dezza.ricepaper.ui.movieclip
{

	import com.dezza.ricepaper.ui.core.IRenderer;


	import flash.display.FrameLabel;
	import flash.display.MovieClip;

	/**
	 * @author derek
	 * 
	 * renders visual states by sending a MovieClip to a correspondingly labelled frame
	 */
	public class LabelledStateRenderer implements IRenderer
	{

		/**
		 * movieclip asset containing states as labelled frames
		 */
		private var _asset : MovieClip;

		/**
		 * hash of available states
		 */
		private var _availableStates : Object;


		public function LabelledStateRenderer(asset : MovieClip, states : Array)
		{
			_asset = asset;

			_availableStates = {};

			initStates(states);
		}


		protected function initStates(states : Array) : void
		{
			for each (var state : String in states )
			{
				_availableStates[ state ] = false;
			}

			for each (var label : FrameLabel in _asset.currentLabels )
			{
				if ( _availableStates[ label.name ] !== undefined )
				{
					_availableStates[ label.name ] = true;
				}
			}
		}


		public function render(state : String) : void
		{
			if ( _availableStates[state] )
			{
				_asset.gotoAndStop(state);
			}
			else
			{
				// trace(this + "state '" + state + "' not found in " + _asset);
			}
		}


		public function dispose() : void
		{
			_availableStates = null;

			_asset = null;
		}
	}
}

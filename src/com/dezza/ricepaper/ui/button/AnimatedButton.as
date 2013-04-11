package com.dezza.ricepaper.ui.button
{

	import com.dezza.ricepaper.ui.movieclip.NullStateRenderer;
	import com.dezza.ricepaper.ui.movieclip.TimelineTween;


	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	/**
	 * @author derek
	 */
	public class AnimatedButton extends Button
	{

		protected var tween : TimelineTween;


		public function AnimatedButton(content : MovieClip, mouseChildren : Boolean = false, inDuration : Number = 0.2, outDuration : Number = 0.2, timeline:MovieClip = null)
		{
			super(content, mouseChildren);

			tween = new TimelineTween( timeline ? timeline : content, inDuration, outDuration);
		}


		/**
		 * @private
		 */
		override protected function onRollOver(event : MouseEvent) : void
		{
			tween.animateIn();
		}


		/**
		 * @private
		 */
		override protected function onRollOut(event : MouseEvent) : void
		{
			tween.animateOut();
		}


		/**
		 * @private
		 */
		override protected function initStates() : void
		{
			_stateRenderer = new NullStateRenderer();
		}
	}
}

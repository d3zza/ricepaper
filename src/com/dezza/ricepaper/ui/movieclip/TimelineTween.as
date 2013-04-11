package com.dezza.ricepaper.ui.movieclip
{

	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.greensock.easing.Linear;


	import flash.display.MovieClip;
	import flash.display.Sprite;

	/**
	 * @author Derek
	 */
	public class TimelineTween extends Sprite
	{

		protected var _tween : TweenLite;

		protected var _asset : MovieClip;

		public var inDuration : Number = 0.2;

		public var outDuration : Number = 0.2;

		private var outCallback : Function;

		private var inCallback : Function;

		private var dir : int;


		public function TimelineTween(asset : MovieClip, inDuration : Number = 0.2, outDuration : Number = 0.2)
		{
			if (!isNaN(inDuration) ) this.inDuration = inDuration;

			if (!isNaN(outDuration) ) this.outDuration = outDuration;

			this.outDuration = outDuration;

			if (asset)
			{
				x = asset.x;
				y = asset.y;
				rotation = asset.rotation;

				asset.x = 0;
				asset.y = 0;
				asset.rotation = 0;

				if (asset.parent)
				{
					asset.parent.addChildAt(this, asset.parent.getChildIndex(asset));
				}

				addChild(asset);

				_asset = asset;

				frame = 1;
			}
			else
			{
				throw new ArgumentError("TweenedTimelinedMC you must pass a MovieClip asset to constructor");
			}
		}


		public function get frame() : int
		{
			return _asset.currentFrame;
		}


		public function set frame(frame : int) : void
		{
			_asset.gotoAndStop(frame);
		}


		public function get totalFrames() : int
		{
			return _asset.totalFrames;
		}


		public function animateIn(callback : Function = null) : void
		{
			dir = 1;
			inCallback = callback;
			tweenFrame(_asset.totalFrames, inDuration);
		}


		public function animateOut(callback : Function = null) : void
		{
			dir = -1;
			outCallback = callback;
			tweenFrame(1, outDuration);
		}


		protected function tweenFrame(frame : int, time : Number) : void
		{
			if (_tween)
			{
				_tween.kill();
			}

			_tween = TweenMax.to(this, time, {frame:frame, ease:Linear.easeNone, onComplete:onTweenComplete});
		}


		private function onTweenComplete() : void
		{
			if ( dir === 1 && inCallback is Function )
			{
				inCallback();
			}
			else if ( dir === -1 && outCallback is Function )
			{
				outCallback();
			}
			_tween.kill();
			_tween = null;
		}
	}
}

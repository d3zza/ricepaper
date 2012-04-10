package com.dezza.ricepaper.ui.button
{

	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * @author derek
	 * 
	 * RepeaterButton extends Button to provide capability of sending multiple
	 * events ( RepeaterButtonEvent.BUTTON_DOWN ) while mouse is held down
	 */
	public class RepeaterButton extends Button
	{
		/**
		 * whether or not autoRepeat is enabled
		 */
		protected var _repeatEnabled : Boolean;

		/**
		 * @private
		 */
		protected var _repeatDelay : uint = 300;

		/**
		 * @private
		 */
		protected var _repeatInterval : uint = 35;

		/**
		 * @private
		 */
		protected var _repeatTimer : Timer;

		/**
		 * @private
		 */
		protected var _repeatCount : uint = 0;

		/**
		 * Construct new RepeaterButton instance
		 * 
		 * @param asset MovieClip asset
		 */
		public function RepeaterButton(asset : MovieClip)
		{
			super(asset);
		}


		/**
		 * repeat delay in millisecs
		 * 
		 * <p>i.e. delay until repeating starts</p>
		 */
		public function get repeatDelay() : uint
		{
			return _repeatDelay;
		}


		/**
		 * @private
		 */
		public function set repeatDelay(repeatDelay : uint) : void
		{
			_repeatDelay = repeatDelay;

			if ( _repeatTimer )
			{
				if ( !Boolean(_repeatTimer.currentCount) ) _repeatTimer.delay = _repeatDelay;
			}
		}


		/**
		 * repeat interval in millisecs
		 * 
		 * <p>i.e. how often the RepeaterButtonEvent.BUTTON_DOWN is dispatched</p>
		 */
		public function get repeatInterval() : uint
		{
			return _repeatInterval;
		}


		/**
		 * @private
		 */
		public function set repeatInterval(repeatInterval : uint) : void
		{
			_repeatInterval = repeatInterval;

			if ( _repeatTimer )
			{
				if ( Boolean(_repeatTimer.currentCount) ) _repeatTimer.delay = _repeatInterval;
			}
		}


		/**
		 * whether or not repeat is enabled
		 */
		public function get repeatEnabled() : Boolean
		{
			return _repeatEnabled;
		}


		/**
		 * @private
		 */
		public function set repeatEnabled(repeatEnabled : Boolean) : void
		{
			_repeatEnabled = repeatEnabled;

			if (_repeatEnabled)
			{
				if (!_repeatTimer)
				{
					createAutoRepeatTimer();
				}
				_repeatTimer.delay = _repeatTimer.currentCount ? _repeatDelay : _repeatInterval;
			}
			else
			{
				releaseAutoRepeatTimer();
			}
		}


		/**
		 * get the number of repeat events fired
		 * 
		 * @return uint number of repeat events fired since mouse was pressed
		 */
		public function get repeatCount() : uint
		{
			return _repeatCount;
		}


		/**
		 * @inheritDoc
		 */
		override public function destroy() : void
		{
			repeatEnabled = false;
			
			releaseAutoRepeatTimer();
			
			super.destroy();
		}

		/**
		 * @private
		 */
		override protected function initMouse() : void
		{
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown, false, 0, true);
			
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp, false, 0, true);

			repeatEnabled = true;

			super.initMouse();
		}


		/**
		 * @private
		 */
		override protected function onRollOut(event : MouseEvent) : void
		{
			super.onRollOut(event);
			endPress();
		}


		/**
		 * @private
		 */
		protected function onMouseDown(e : MouseEvent) : void
		{
			startPress();
		}


		/**
		 * @private
		 */
		protected function onMouseUp(e : MouseEvent) : void
		{
			endPress();
		}


		/**
		 * @private
		 */
		protected function startPress() : void
		{
			if (_repeatEnabled)
			{
				_repeatTimer.delay = _repeatDelay;
				_repeatTimer.start();
			}

			_repeatCount = 0;

			dispatchEvent(new RepeaterButtonEvent(RepeaterButtonEvent.BUTTON_DOWN, true));
		}


		/**
		 * @private
		 */
		protected function onRepeatTimer(event : TimerEvent) : void
		{
			if (!_repeatEnabled)
			{
				endPress();
				return;
			}

			if (_repeatTimer.currentCount == 1) _repeatTimer.delay = _repeatInterval;

			_repeatCount++;

			dispatchEvent(new RepeaterButtonEvent(RepeaterButtonEvent.BUTTON_DOWN, true));
		}


		/**
		 * @private
		 */
		protected function endPress() : void
		{
			if (_repeatTimer)
			{
				_repeatTimer.stop();
				_repeatTimer.reset();
			}
		}


		/**
		 * @private
		 */
		private function createAutoRepeatTimer() : void
		{
			_repeatTimer = new Timer(1, 0);
			_repeatTimer.addEventListener(TimerEvent.TIMER, onRepeatTimer, false, 0, true);
		}


		/**
		 * @private
		 */
		private function releaseAutoRepeatTimer() : void
		{
			if (!_repeatTimer) return;
			_repeatTimer.removeEventListener(TimerEvent.TIMER, onRepeatTimer);
			_repeatTimer.stop();
			_repeatTimer = null;
			_repeatEnabled = false;
		}
	}
}

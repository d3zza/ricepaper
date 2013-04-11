package com.dezza.ricepaper.ui.mousewheel
{

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	/**
	 * @author derek
	 * 
	 * This is a helper class for the MouseWheel class to notifiy MouseWheel whether mouse is currently over a target display object
	 * 
	 * Behaves in the way a rolled over sprite behaves i.e. can be 
	 * obstructed by other display objects in front
	 */
	public class MouseOverHelper extends Sprite
	{

		/**
		 * @private
		 */
		private var _target : DisplayObject;

		/**
		 * @private
		 */
		private var _mouseIsOverTarget : Boolean = false;

		/**
		 * @private
		 */
		private var _lockBrowserScroll : Boolean = false;


		/**
		 * Create a MouseOverHelper instance
		 * 
		 * @param target DisplayObject
		 */
		public function MouseOverHelper(target : DisplayObject = null)
		{
			if ( target ) mouseTarget = target;
		}


		/**
		 * set the mouse over target object (to mouse wheel over)
		 * 
		 * @param t DisplayObject
		 */
		public function set mouseTarget(t : DisplayObject) : void
		{
			if (!t)
			{
				throw new Error(this + "set mouseTarget target is null");
				return;
			}
			_target = t;
			addMouseListeners();
		}


		/**
		 * get the target mouse over object
		 * 
		 * @return DisplayObject
		 */
		public function get mouseTarget() : DisplayObject
		{
			return _target;
		}


		/** 
		 * returns true if the mouse is rolled over the target
		 * @param e MouseEvent (with stage coords)
		 * @return true is mouse is over target
		 */
		public function get mouseIsOver() : Boolean
		{
			if (!_target)
			{
				return false;
			}

			if (!_target.stage)
			{
				return false;
			}

			if ( !_target.visible  )
			{
				return false;
			}

			return _mouseIsOverTarget;
		}


		/**
		 * set whether the containing html page should lock browser scroll
		 * while the user is mousewheeling over this flash object
		 * 
		 * @param b Boolean true to lock browser scroll
		 */
		public function set autolockBrowserScroll(b : Boolean) : void
		{
			_lockBrowserScroll = b;
		}


		/**
		 * get the autoLockBrowserScroll setting
		 * 
		 * @return Boolean true if scroll is locked
		 */
		public function get autolockBrowserScroll() : Boolean
		{
			return _lockBrowserScroll;
		}


		/**
		 * prepare instance for GC
		 */
		public function destroy() : void
		{
			removeMouseListeners();
			_target = null;
		}


		/**
		 * get string representation of this instance
		 * 
		 * @return String
		 */
		override public function toString() : String
		{
			return "[ MouseOverTargetHelper target:" + _target + " ]";
		}


		/**
		 * @private
		 */
		private function addMouseListeners() : void
		{
			_target.addEventListener(MouseEvent.ROLL_OVER, onRollOverTarget, false, 0, true);
			_target.addEventListener(MouseEvent.ROLL_OUT, onRollOutTarget, false, 0, true);
		}


		/**
		 * @private
		 */
		private function removeMouseListeners() : void
		{
			if (!_target) return;
			_target.removeEventListener(MouseEvent.ROLL_OVER, onRollOverTarget);
			_target.removeEventListener(MouseEvent.ROLL_OUT, onRollOutTarget);
		}


		/**
		 * @private
		 */
		private function onRollOverTarget(e : MouseEvent) : void
		{
			_mouseIsOverTarget = true;
			if ( _lockBrowserScroll )
			{
				MouseWheel.getInstance().lockBrowserScroll(true);
			}
		}


		/**
		 * @private
		 */
		private function onRollOutTarget(e : MouseEvent) : void
		{
			_mouseIsOverTarget = false;
			if ( _lockBrowserScroll )
			{
				MouseWheel.getInstance().lockBrowserScroll(false);
			}
		}
	}
}

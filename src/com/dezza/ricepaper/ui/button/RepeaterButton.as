package com.dezza.ui.button {

	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * @author derek
	 */
	public class RepeaterButton extends UIButton {

		/**
		 * whether or not the button is currently enabled
		 */
		protected var _enabled : Boolean;
		
		/**
		 * whether or not the button is currently selected
		 */
		protected var _selected : Boolean;

		/**
		 * whether or not autoRepeat is enabled
		 */
		protected var _autoRepeat:Boolean;
		
		/**
		 * delay in milliseconds before repeat kicks in
		 */
		protected var _repeatDelay : int;
		
		/**
		 * interval in milliseconds of subsequent repeats
		 */
		protected var _repeatInterval : int;
		
		/**
		 * timer to trigger autoRepeat event dispatch
		 */
		protected var _repeatTimer : Timer;
		
		/**
		 * number of repeat events fired since mouse was pressed
		 */
		protected var _repeatCount : uint = 0;
		
		public function RepeaterButton(content : MovieClip, id : String = null, wrapContent : Boolean = true) {
			super(content, id, wrapContent );
		}
		
		override protected function init():void {
			super.init();
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown, false, 0, true);
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp, false, 0, true);
			setAutoRepeat( true, 300, 35 );
		}

		/**
		 * rollOut handler
		 */
		override protected function onRollOut(event : MouseEvent) : void {
			super.onRollOut(event);
			endPress();
		}

		/**
		 * mouse down handler
		 */
		protected function onMouseDown( e : MouseEvent ) : void {
			startPress();
		}

		/**
		 * mouse up handler
		 */
		protected function onMouseUp( e : MouseEvent ) : void {
			endPress();
		}

		/**
		 * called when btn first pressed
		 */
		protected function startPress():void {
			if (_autoRepeat) {
				_repeatTimer.delay = _repeatDelay;
				_repeatTimer.start();
			}
			_repeatCount = 0;		
			dispatchEvent( new RepeaterButtonEvent( RepeaterButtonEvent.BUTTON_DOWN, true ) );
		}
		
		/**
		 * handler for autoRepeat timer fire btn down event
		 */
		protected function buttonDown(event:TimerEvent):void {
			if (!_autoRepeat) { endPress(); return; }
			if (_repeatTimer.currentCount == 1) _repeatTimer.delay = _repeatInterval;
			_repeatCount++;
			dispatchEvent( new RepeaterButtonEvent( RepeaterButtonEvent.BUTTON_DOWN, true ) );	
		}
		
		/**
		 * called when btn released
		 */
		protected function endPress():void {
			if (_repeatTimer) {
				_repeatTimer.stop();
				_repeatTimer.reset();
			}
		}
				
		public function setAutoRepeat( b:Boolean, repeatDelay:int=-1, repeatInterval:int=-1 ):void {
			
			_autoRepeat = b;
			
			if( repeatDelay > -1) _repeatDelay = repeatDelay;
			if( repeatInterval > -1) _repeatInterval = repeatInterval;
			if(_autoRepeat){
				if(!_repeatTimer) createAutoRepeatTimer();
				_repeatTimer.delay = _repeatTimer.currentCount ? _repeatDelay : _repeatInterval;
			} else {
				releaseAutoRepeatTimer();
			}
		}

		/**
		 * set auto repeat on/off
		 * 
		 * @param b <code>Boolean</code> true to turn autoRepeat on
		 */
		public function set autoRepeat( b:Boolean ):void {
			setAutoRepeat( b );
		}
		
		/**
		 * get the autoRepeat setting
		 * 
		 * @return <code>Boolean</code> indicating whether autoRepeat is on
		 */
		public function get autoRepeat():Boolean {
			return _autoRepeat;
		}

		public function get repeatCount():uint {
			return _repeatCount;
		}
		
		/**
		 * @private
		 */
		private function createAutoRepeatTimer():void{
			_repeatTimer = new Timer( 1,0 );
			_repeatTimer.addEventListener(TimerEvent.TIMER,buttonDown,false,0,true);	
		}
		
		/**
		 * @private
		 */	
		private function releaseAutoRepeatTimer():void{
			if(!_repeatTimer) return;
			_repeatTimer.removeEventListener(TimerEvent.TIMER,buttonDown);
			_repeatTimer.stop();
			_repeatTimer = null;
			_autoRepeat = false;
		}	
	}
}

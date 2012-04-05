package com.dezza.ricepaper.ui.mousewheel
{

	import flash.display.DisplayObject;
	import flash.events.EventDispatcher;
	import flash.external.ExternalInterface;

	/**
	 * @author derek
	 * 
	 * Utility to provide cross platform (Mac OS X) mousewheel support (requires javascript / ExternalInterface)
	 * 
	 */
	public class MouseWheel extends EventDispatcher
	{
		/**
		 * @private
		 */
		private static var _instance : MouseWheel;

		/**
		 * @private
		 */
		private var _stage : DisplayObject;

		/**
		 * Get the MouseWheel instance
		 * 
		 * note you must call init() and pass a valid stage instance before MouseWheel will start working
		 * 
		 * @return MouseWheel instance (Singleton)  
		 */
		public static function getInstance() : MouseWheel
		{
			if ( !(MouseWheel._instance is MouseWheel) ) MouseWheel._instance = new MouseWheel(new ConstructorAccess());
			return MouseWheel._instance;
		}


		/**
		 * destroy the MouseWheel instance
		 */
		public static function destroy() : void
		{
			if ( MouseWheel._instance is MouseWheel ) MouseWheel._instance = null;
			// TODO ExternalInterface clean up untested
			try
			{
				ExternalInterface.addCallback("dispatchScrollWheel", null);
			}
			catch( err : Error )
			{
			}
		}


		/**
		 * @private
		 */
		public function MouseWheel(access : ConstructorAccess)
		{
			super();
			if ( !(access is ConstructorAccess) ) throw new Error("MouseWheel constructor is private - use MouseWheel.getInstance()");
		}


		/**
		 * initialise MouseWheel instance
		 * 
		 * @param stage DisplayObject (mouse positions will be calculated relative to this)
		 */
		public function init(stage : DisplayObject = null) : void
		{
			if (!stage) throw new Error("must pass a stage object");
			_stage = stage;

			if ( ExternalInterface.available )
			{
				new MouseWheelJSBridge();
				try
				{
					ExternalInterface.call("MWAS.initScroll");
					ExternalInterface.addCallback("dispatchScrollWheel", dispatchScrollWheel);
				}
				catch( err : Error )
				{
				}
			}
		}


		/**
		 * @private
		 */
		public function dispatchScrollWheel(delta : Number) : void
		{
			dispatchEvent(new MouseWheelEvent(MouseWheelEvent.MOUSE_WHEEL, _stage.mouseX, _stage.mouseY, delta));
		}


		/**
		 * add a listener for MouseWheel events
		 * 
		 * @param listener <code>com.dezza.ricepaper.ui.mousewheel.MouseWheelListener</code> implementation
		 */
		public function addMouseWheelListener(listener : MouseWheelListener) : void
		{
			addEventListener(MouseWheelEvent.MOUSE_WHEEL, listener.onMouseWheel, false, 0, true);
		}


		/**
		 * remove a listener for MouseWheel events
		 * 
		 * @param listener <code>com.dezza.ricepaper.ui.mousewheel.MouseWheelListener</code> implementation
		 */
		public function removeMouseWheelListener(listener : MouseWheelListener) : void
		{
			removeEventListener(MouseWheelEvent.MOUSE_WHEEL, listener.onMouseWheel);
		}


		/**
		 * prevent MouseWheel scrolling from scrolling the containing web page as well
		 * 
		 * @param lock Boolean true to lock, false to unlock
		 */
		public function lockBrowserScroll(lock : Boolean) : void
		{
			if ( ExternalInterface.available )
			{
				try
				{
					ExternalInterface.call("MWAS.lockBrowserScrolling", lock);
				}
				catch( err : Error )
				{
				}
			}
		}
	}
}
internal class ConstructorAccess
{
}
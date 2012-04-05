package com.dezza.ricepaper.ui.mousewheel
{

	/**
	 * @author derek
	 * 
	 * Classes wishing to listen to be added as listeners of MouseWheel mouse wheel events should implement this 
	 */
	public interface MouseWheelListener {
		
		function onMouseWheel( e:MouseWheelEvent ):void;
		
	}
}

package com.dezza.ricepaper.ui.dragger 
{

	import com.dezza.ricepaper.ui.core.IUIControl;

	import flash.geom.Rectangle;
	/**
	 * Dragger
	 * Class Description.
	 *
	 * @author Derek McKenna
	 * @version 1.0
	 * @since Feb 15, 2009
	 */
	public interface IDragger extends IUIControl
	{
		function setDragRect( rect : Rectangle ) : void;

		function addDraggerListener( listener : DraggerListener ) : void;

		function removeDraggerListener( listener : DraggerListener ) : void;

		function startDragging( ) : void;

		function stopDragging( ) : void;
		
		function get isDragging() : Boolean;
		
	}
}

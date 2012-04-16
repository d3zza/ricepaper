package com.dezza.ricepaper.ui.scrollbar
{

	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;

	/**
	 * @author dezza
	 */
	public interface IScrollBarAsset
	{

		/**
		 * get the parent container of the scrollbar assets
		 */
		function get container() : DisplayObjectContainer;


		/**
		 * get the dragger child asset
		 * 
		 * dragger is dragged along the track in the scroll bar
		 * 
		 * @return MovieClip containing the visual states of the dragger
		 */
		function get draggerAsset() : MovieClip;


		/**
		 * get the track child asset
		 * 
		 * track contains the dragger and can be clicked to move dragger position
		 * 
		 * @return MovieClip containing the visual states of the track
		 */
		function get trackAsset() : MovieClip;


		/**
		 * get the up btn child asset
		 * 
		 * up btn can be clicked to move dragger upwards
		 * 
		 * in horizontal scrollbars the up is the left btn
		 * 
		 * @return MovieClip containing the visual states of the upBtn
		 */
		function get upBtnAsset() : MovieClip;


		/**
		 * get the down btn child asset
		 * 
		 * down btn can be clicked to move dragger upwards
		 * 
		 * in horizontal scrollbars the down is the right btn
		 * 
		 * @return MovieClip containing the visual states of the downBtn
		 */
		function get downBtnAsset() : MovieClip;


		/**
		 * get the background asset
		 * 
		 * background asset is displayed underneath the other assets
		 * and is visible when other assets have been disabled / hidden
		 * 
		 * @return Sprite containing the visual state of the bg
		 */
		function get backgroundAsset() : Sprite;
	}
}

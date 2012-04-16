package com.dezza.ricepaper.ui.scrollbar
{

	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;

	/**
	 * @author dezza
	 */
	public class ScrollBarAsset extends Sprite implements IScrollBarAsset
	{

		protected var _container : DisplayObjectContainer;


		/**
		 * @inheritDoc
		 */
		public function ScrollBarAsset(container : DisplayObjectContainer)
		{
			if ( !container ) throw new Error("invalid container");

			_container = container;
		}


		/**
		 * @inheritDoc
		 */
		public function get container() : DisplayObjectContainer
		{
			return _container;
		}


		/**
		 * @inheritDoc
		 */
		public function get draggerAsset() : MovieClip
		{
			return _container.getChildByName("dragger") as MovieClip;
		}


		/**
		 * @inheritDoc
		 */
		public function get trackAsset() : MovieClip
		{
			return _container.getChildByName("track") as MovieClip;
		}


		/**
		 * @inheritDoc
		 */
		public function get upBtnAsset() : MovieClip
		{
			return _container.getChildByName("up") as MovieClip;
		}


		/**
		 * @inheritDoc
		 */
		public function get downBtnAsset() : MovieClip
		{
			return _container.getChildByName("down") as MovieClip;
		}


		/**
		 * @inheritDoc
		 */
		public function get backgroundAsset() : Sprite
		{
			return _container.getChildByName("background") as MovieClip;
		}
	}
}

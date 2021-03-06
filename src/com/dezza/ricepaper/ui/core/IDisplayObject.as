package com.dezza.ricepaper.ui.core
{

	import flash.display.IBitmapDrawable;
	import flash.accessibility.AccessibilityProperties;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.LoaderInfo;
	import flash.display.Stage;
	import flash.events.IEventDispatcher;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.geom.Transform;

	/**
	 * @author derek
	 */
	public interface IDisplayObject extends IEventDispatcher, IBitmapDrawable
	{
		/**
		 * Workaround to provide a DisplayObject interface
		 * 
		 * <p>Vote for Adobe to improve AS3 by adding a DisplayObject interface here:<br/>
		 * <a href='http://bugs.adobe.com/jira/browse/ASL-45' >http://bugs.adobe.com/jira/browse/ASL-45</a></p>
		 * 
		 * <p>This allows us to work with implentations as assuming they are DisplayObjects.
		 * Please note that there is no guarantee that they actually are. It's up to implementations
		 * to ensure they inherit from DisplayObject</p>
		 * 
		 * <p>Furthermore, you will still have to cast implementations to DisplayObject to add them to
		 * other DisplayObjectContainers</p>
		 */
		function get accessibilityProperties() : AccessibilityProperties;


		function set accessibilityProperties(value : AccessibilityProperties) : void;


		function get alpha() : Number;


		function set alpha(value : Number) : void;


		function get blendMode() : String;


		function set blendMode(value : String) : void;


		function get cacheAsBitmap() : Boolean;


		function set cacheAsBitmap(value : Boolean) : void;


		function get filters() : Array;


		function set filters(value : Array) : void;


		function getBounds(targetCoordinateSpace : DisplayObject) : Rectangle;


		function getRect(targetCoordinateSpace : DisplayObject) : Rectangle;


		function globalToLocal(point : Point) : Point;


		function get height() : Number;


		function set height(value : Number) : void;


		function hitTestObject(obj : DisplayObject) : Boolean;


		function hitTestPoint(x : Number, y : Number, shapeFlag : Boolean = false) : Boolean;


		function get loaderInfo() : LoaderInfo;


		function localToGlobal(point : Point) : Point;


		function get mask() : DisplayObject;


		function set mask(value : DisplayObject) : void;


		function get mouseX() : Number;


		function get mouseY() : Number;


		function get name() : String;


		function set name(value : String) : void;


		function get opaqueBackground() : Object;


		function set opaqueBackground(value : Object) : void;


		function get parent() : DisplayObjectContainer;


		function get root() : DisplayObject;


		function get rotation() : Number;


		function set rotation(value : Number) : void;


		function get scale9Grid() : Rectangle;


		function set scale9Grid(innerRectangle : Rectangle) : void;


		function get scaleX() : Number;


		function set scaleX(value : Number) : void;


		function get scaleY() : Number;


		function set scaleY(value : Number) : void;


		function get scrollRect() : Rectangle;


		function set scrollRect(value : Rectangle) : void;


		function get stage() : Stage;


		function get transform() : Transform;


		function set transform(value : Transform) : void;


		function get visible() : Boolean;


		function set visible(value : Boolean) : void;


		function get width() : Number;


		function set width(value : Number) : void;


		function get x() : Number;


		function set x(value : Number) : void;


		function get y() : Number;


		function set y(value : Number) : void;
	}
}

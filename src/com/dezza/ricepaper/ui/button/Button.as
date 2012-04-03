package com.dezza.ui.button {

	import flash.events.IEventDispatcher;
	import flash.display.MovieClip;
	import flash.text.TextField;
	/**
	 * @author derek
	 */
	public interface Button extends IEventDispatcher{
		
		function get id():String;
		
		function get enabled():Boolean;
		
		function set enabled( b:Boolean ):void;
		
		function set text( s:String ):void;
		
		function get text():String;
		
		function get content():MovieClip;
		
		function get textField():TextField;
		
		function addHitArea():void;
		
	}
}

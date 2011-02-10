package com.dezza.ricepaper.ui.button {
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Rectangle;

	/**
	 * @author derek
	 */
	public class UIButton extends Sprite {

		public static var 
			GREYED_OUT_COLOR:ColorTransform,
			NORMAL_COLOR:ColorTransform;
					
		private var _id:String;
		
		private var _content : DisplayObject;
		
		private var _useTimeLineStates : Boolean;
		
		public function UIButton( content : DisplayObject, wrapContent:Boolean = false, useTimeLineStates:Boolean = false, id:String = "" ) {
			if( content && wrapContent) {
				// move this to where content is and position content at 0,0
				x = content.x;
				y = content.y;
				content.x = 0;
				content.y = 0;
				if( content.parent ) content.parent.addChild( this );
			}
			
			if( content ){
				addChild(content);
				_content = content;
			} else {
				_content = this;
			}
			
			_id = id;
			_useTimeLineStates = useTimeLineStates;
			
			init();
		}
		
		protected function init():void {
			addEventListener(MouseEvent.ROLL_OVER, onRollOver);
			addEventListener(MouseEvent.ROLL_OUT, onRollOut);
			buttonMode = true;
			mouseChildren = false;
			
			if( !GREYED_OUT_COLOR ){
				GREYED_OUT_COLOR = new ColorTransform();
				GREYED_OUT_COLOR.color = 0x666666;
				GREYED_OUT_COLOR.redMultiplier = 0.3;
				GREYED_OUT_COLOR.blueMultiplier = 0.3;
				GREYED_OUT_COLOR.greenMultiplier = 0.3;
			}
			
			if( !NORMAL_COLOR ) NORMAL_COLOR = new ColorTransform();
		}
		
		public function get id():String {
			return _id;
		}
		
		public function get content():DisplayObject {
			return _content;
		}

		public function set enabled( b:Boolean ):void {
			mouseEnabled = b;
			setGreyedOut( !b );
		}

		public function get enabled() : Boolean {
			return mouseEnabled;
		}
		
		public function setGreyedOut( b : Boolean ) : void {
			transform.colorTransform = b ? GREYED_OUT_COLOR : NORMAL_COLOR;							
		}
		
		protected function onRollOver(event : MouseEvent) : void {
			if (_useTimeLineStates) {
				if ( !(_content is MovieClip) ) return;
				( _content as MovieClip ).gotoAndStop("_over");
			}
		}
		
		protected function onRollOut(event : MouseEvent) : void {
			if (_useTimeLineStates) {
				if ( !(_content is MovieClip) ) return;
				( _content as MovieClip ).gotoAndStop("_up");
			}
		}
		
		public function addHitArea() : void {
			var hit : Sprite = new Sprite();
			addChild(hit);
			var contentRect : Rectangle = content.getBounds(this);
			with( hit.graphics ) {
				beginFill(0x32FFFF, 0.3);
				drawRect(contentRect.x - 1, contentRect.y - 1, contentRect.width + 2, contentRect.height + 2);
				endFill;
			}
			hit.visible = false;
			hitArea = hit;
		}
		
	}
}

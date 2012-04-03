package com.dezza.ui.button {

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.errors.IllegalOperationError;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;

	/**
	 * @author derek
	 */
	public class UIButton extends Sprite implements Button {

		private var _id:String;

		private var _content:MovieClip;
		
		public function UIButton(content:MovieClip, id:String = null, wrapContent:Boolean = true) {

			if (content) {
				
				if (wrapContent) {
					
					x = content.x;
					y = content.y;
					content.x = 0;
					content.y = 0;
					
					if (content.parent) {
						
						content.parent.addChildAt(this, content.parent.getChildIndex( content ) );
					}
				}
				
				addChild(content);

				_content = content;
			}
			else {
				
				throw new ArgumentError("UIButton content is undefined");
			}

			_id = id;

			init();
		}


		public function get id():String {
			
			return _id;
		}
		
		public function get content() : MovieClip {
			
			return _content;
		}
		
		public function get enabled():Boolean {
			
			return mouseEnabled;
		}


		public function set enabled(b:Boolean):void {
			
			mouseEnabled = b;
			
			var label:String = b ? "_up" : "_disabled";
			
			// TODO fix me need to work with FrameLabel objs
//			if( _content.currentLabels.indexOf( label ) != -1 ){
//				_content.gotoAndStop( label );	
//			}
		}
		
		
		public function get textField():TextField {
			
			// labelContainer.label by convention
			
			if (content.labelContainer ) {
				
				return content.labelContainer.label;
			}
			
			return null;
		}
		
		
		public function get text():String {

			
			if ( textField ) {
				
				return textField.text;
			}
			
			return null;
		}
		
		
		public function set text(text:String):void {
			
			if ( textField ) {
				
				textField.text = text;
			}
			else {
				
				throw new IllegalOperationError("UIButton does not contain a labelContainer.label textField instance");
			}
		}
		
		
		public function addHitArea():void {
			
			var hit:Sprite = new Sprite();
			addChild(hit);
			var contentRect:Rectangle = content.getBounds(this);
			with( hit.graphics ) {
				beginFill(0x32FFFF, 0.3);
				drawRect(contentRect.x - 1, contentRect.y - 1, contentRect.width + 2, contentRect.height + 2);
				endFill;
			}
			hit.visible = false;
			hitArea = hit;
		}
		
		
		protected function init():void {
			
			addEventListener(MouseEvent.ROLL_OVER, onRollOver);
			addEventListener(MouseEvent.ROLL_OUT, onRollOut);
			
			buttonMode = true;
			mouseChildren = false;

			enabled = true;
		}


		protected function onRollOver(event:MouseEvent):void {
			content.gotoAndStop("_over");
		}


		protected function onRollOut(event:MouseEvent):void {
			content.gotoAndStop("_up");
		}
	}
}

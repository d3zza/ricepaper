package ui.scrollbar
{

	import com.dezza.ricepaper.ui.button.LabelButton;
	import com.dezza.ricepaper.ui.scrollbar.IScrollBar;
	import com.dezza.ricepaper.ui.scrollbar.IScrollableContent;
	import com.dezza.ricepaper.ui.scrollbar.ScrollBar;
	import com.dezza.ricepaper.ui.scrollbar.ScrollableSprite;

	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;

	/**
	 * @author derek
	 */
	public class ScrollbarPlayground extends MovieClip /*implements IDraggerListener*/
	{
		private var scrollbarLeft : IScrollBar;

		private var textArea : PG_TextArea;

		private var toggleEnabledBtn : LabelButton;

		private var scrollbarHLeft : IScrollBar;

		public function ScrollbarPlayground()
		{
			
			var leftContent:Sprite = new PG_GradientFill();
			leftContent.x = 100;
			leftContent.y = 100;
			leftContent.width = 800;
			leftContent.height = 2400;
			
			addChild( leftContent );
			
			var leftMsk:Sprite = new Sprite();
			leftMsk.graphics.beginFill(0xff0000);
			leftMsk.graphics.drawRect(0, 0, 200, 200);
			leftMsk.x = 100;
			leftMsk.y = 100;
			
			addChild( leftMsk );
			
			var leftScrollable : IScrollableContent = new ScrollableSprite( leftContent, leftMsk );
			
			var leftSBAsset:PG_ScrollbarAsset = new PG_ScrollbarAsset();
			leftSBAsset.x = 300;
			leftSBAsset.y = 100;
			addChild(leftSBAsset);
			
			scrollbarLeft = new ScrollBar( leftSBAsset.dragger, leftSBAsset.track, leftSBAsset.up, leftSBAsset.down );
			scrollbarLeft.setContent(leftScrollable);
			scrollbarLeft.totalLength = 200;
			
			
			var leftHSBAsset:PG_HorizScrollbarAsset = new PG_HorizScrollbarAsset();
			leftHSBAsset.x = 100;
			leftHSBAsset.y = 300;
			addChild(leftHSBAsset);
			
			scrollbarHLeft = new ScrollBar( leftHSBAsset.dragger, leftHSBAsset.track, leftHSBAsset.left, leftHSBAsset.right, "x" );
			scrollbarHLeft.setContent(leftScrollable);
			scrollbarHLeft.totalLength = 200;
			
//			track = new Button( new PG_SliderTrackAsset() );
//			track.y = 100;
//			track.x = 100;
//			addChild( track );
//			
//			var draggerBtn : Button = new Button(new PG_DraggerAsset());
//
//			slider = new Slider(draggerBtn, new Rectangle(100, 100, track.width, 0 ), true, 0.5, track );
//
//			slider.x = 100;
//			slider.y = 100;
//
//			addChild(slider);
//
//			slider.addDraggerListener(this);
//			
//			textArea = new PG_TextArea();
//			addChild(textArea);
//			textArea.x = 600;
//			textArea.y = 200;
//			textArea.tf.text = "";
//			
//			var btnAsset:PG_LabelButtonAsset = new PG_LabelButtonAsset();
//			toggleEnabledBtn = new LabelButton( btnAsset, btnAsset.labelContainer.label );
//			toggleEnabledBtn.x = 600;
//			toggleEnabledBtn.y = 100;
//			
//			toggleEnabledBtn.text = "Disable";
//
//			toggleEnabledBtn.addEventListener(MouseEvent.CLICK, onClick);
//			addChild(toggleEnabledBtn);
		}


//		private function onClick(event : MouseEvent) : void
//		{
//			slider.enabled = !slider.enabled;
//			toggleEnabledBtn.text = slider.enabled ? "Disable" : "Enable";
//		}
//
//
//		public function onDragStart(e : Event) : void
//		{
//			debugDragger("onDragStart");
//		}
//
//
//		public function onDragChange(e : Event) : void
//		{
//			debugDragger("onDragChange");
//		}
//
//
//		public function onDragStop(e : Event) : void
//		{
//			debugDragger("onDragStop");
//		}
//
//
//		private function debugDragger(msg : String) : void
//		{
//			textArea.tf.text += msg + " " + slider.x + "," + slider.y + "\n";
//			textArea.tf.scrollV = textArea.tf.maxScrollV;
//		}
	}
}

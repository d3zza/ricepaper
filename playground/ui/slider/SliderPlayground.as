package ui.slider
{

	import com.dezza.ricepaper.ui.button.Button;
	import com.dezza.ricepaper.ui.button.LabelButton;
	import com.dezza.ricepaper.ui.dragger.Dragger;
	import com.dezza.ricepaper.ui.dragger.IDraggerListener;
	import com.dezza.ricepaper.ui.slider.Slider;

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	/**
	 * @author derek
	 */
	public class SliderPlayground extends MovieClip implements IDraggerListener
	{
		private var slider : Dragger;
		
		private var track : Button;

		private var textArea : PG_TextArea;

		private var toggleEnabledBtn : LabelButton;

		public function SliderPlayground()
		{
			
			track = new Button( new PG_SliderTrackAsset() );
			track.y = 100;
			track.x = 100;
			addChild( track );
			
			var draggerBtn : Button = new Button(new PG_DraggerAsset());

			slider = new Slider(draggerBtn, new Rectangle(100, 100, track.width, 0 ), true, 0.5, track );

			slider.x = 100;
			slider.y = 100;

			addChild(slider);

			slider.addDraggerListener(this);
			
			textArea = new PG_TextArea();
			addChild(textArea);
			textArea.x = 600;
			textArea.y = 200;
			textArea.tf.text = "";
			
			var btnAsset:PG_LabelButtonAsset = new PG_LabelButtonAsset();
			toggleEnabledBtn = new LabelButton( btnAsset, btnAsset.labelContainer.label );
			toggleEnabledBtn.x = 600;
			toggleEnabledBtn.y = 100;
			
			toggleEnabledBtn.text = "Disable";

			toggleEnabledBtn.addEventListener(MouseEvent.CLICK, onClick);
			addChild(toggleEnabledBtn);
		}


		private function onClick(event : MouseEvent) : void
		{
			slider.enabled = !slider.enabled;
			toggleEnabledBtn.text = slider.enabled ? "Disable" : "Enable";
		}


		public function onDragStart(e : Event) : void
		{
			debugDragger("onDragStart");
		}


		public function onDragChange(e : Event) : void
		{
			debugDragger("onDragChange");
		}


		public function onDragStop(e : Event) : void
		{
			debugDragger("onDragStop");
		}


		private function debugDragger(msg : String) : void
		{
			textArea.tf.text += msg + " " + slider.x + "," + slider.y + "\n";
			textArea.tf.scrollV = textArea.tf.maxScrollV;
		}
	}
}

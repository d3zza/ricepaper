package ui.button
{

	import com.dezza.ricepaper.ui.button.LabelButton;
	import com.dezza.ricepaper.ui.button.RepeaterButton;
	import com.dezza.ricepaper.ui.button.RepeaterButtonEvent;

	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	/**
	 * @author derek
	 */
	public class RepeaterButtonPlayground extends MovieClip
	{
		private var button : RepeaterButton;

		private var textArea : PG_TextArea;

		private var toggleEnabledBtn : LabelButton;

		private var eventCount : int = 0;
		
		public function RepeaterButtonPlayground()
		{
			button = new RepeaterButton(new PG_UIButtonAsset());
			button.repeatDelay = 200;
			button.repeatInterval = 17;
			button.y = 100;
			button.x = 100;
			addChild(button);
			
			stage.addEventListener(MouseEvent.MOUSE_UP, onStageMouseUp );
			button.addEventListener(RepeaterButtonEvent.BUTTON_DOWN, onButtonDown );

			textArea = new PG_TextArea();
			addChild(textArea);
			textArea.x = 600;
			textArea.y = 200;
			textArea.tf.text = "";

			var btnAsset : PG_LabelButtonAsset = new PG_LabelButtonAsset();
			toggleEnabledBtn = new LabelButton(btnAsset, btnAsset.labelContainer.label);
			toggleEnabledBtn.x = 600;
			toggleEnabledBtn.y = 100;

			toggleEnabledBtn.text = "Disable";

			toggleEnabledBtn.addEventListener(MouseEvent.CLICK, onEnableClick);
			addChild(toggleEnabledBtn);
		}


		private function onStageMouseUp(event : MouseEvent) : void
		{
			eventCount = 0;
		}


		private function onButtonDown(event : RepeaterButtonEvent) : void
		{
			eventCount ++;
			
			textArea.tf.text += "onButtonDown :" + eventCount + "\n";
			textArea.tf.scrollV = textArea.tf.maxScrollV;
		}


		private function onEnableClick(event : MouseEvent) : void
		{
			button.enabled = !button.enabled;
			toggleEnabledBtn.text = button.enabled ? "Disable" : "Enable";
		}
	}
}

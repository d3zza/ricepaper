package ui.dragger
{

	import flash.events.Event;

	import com.dezza.ricepaper.ui.dragger.IDraggerListener;
	import com.dezza.ricepaper.ui.dragger.DraggerEvent;
	import com.dezza.ricepaper.ui.button.Button;
	import com.dezza.ricepaper.ui.dragger.Dragger;

	import flash.display.MovieClip;
	import flash.geom.Rectangle;

	/**
	 * @author derek
	 */
	public class DraggerPlayground extends MovieClip implements IDraggerListener
	{
		private var dragger : Dragger;

		private var textArea : PG_TextArea;

		public function DraggerPlayground()
		{
			var draggerBtn : Button = new Button(new PG_DraggerAsset());

			dragger = new Dragger(draggerBtn, new Rectangle(100, 100, stage.stageWidth - 200, stage.stageHeight - 200));

			dragger.x = 100;
			dragger.y = 100;

			addChild(dragger);

			dragger.addDraggerListener(this);
			
			textArea = new PG_TextArea();
			addChild(textArea);
			textArea.x = 700;
			textArea.y = 100;
			textArea.tf.text = "";
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
			textArea.tf.text += msg + " " + dragger.x + "," + dragger.y + "\n";
			textArea.tf.scrollV = textArea.tf.maxScrollV;
		}
	}
}

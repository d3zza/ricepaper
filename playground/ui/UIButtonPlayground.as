package ui
{

	import flash.utils.setTimeout;
	import com.dezza.ricepaper.ui.button.Button;

	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	/**
	 * @author derek
	 */
	public class UIButtonPlayground extends MovieClip
	{
		private var leftBtn : Button;

		private var rightBtn : Button;

		private var textArea : PG_TextArea;
		
		private var rightClicked : int = 0;
		
		private var leftClicked : int = 0;

		private var irregBtn : Button;
		
		public function UIButtonPlayground()
		{
			leftBtn = new Button(new PG_UIButtonAsset());
			leftBtn.x = 100;
			leftBtn.y = 100;

			leftBtn.addEventListener(MouseEvent.CLICK, onClick);
			addChild(leftBtn);

			rightBtn = new Button(new PG_UIButtonAsset());
			rightBtn.x = 400;
			rightBtn.y = 100;

			rightBtn.addEventListener(MouseEvent.CLICK, onClick);
			addChild(rightBtn);
			rightBtn.enabled = false;
			setTimeout(reenableBtn, 2000, rightBtn );
			
			textArea = new PG_TextArea();
			addChild(textArea);
			textArea.x = 700;
			textArea.y = 100;
			
			textArea.tf.text = "L = 0, R = 0";
			
			var btnAsset:MovieClip = new PG_UIButtonAssetNoBG();
			btnAsset.x = 150;
			btnAsset.y = 200;
			btnAsset.scaleX = 2;
			btnAsset.scaleY = 2;
			btnAsset.rotation = 45;
			
			irregBtn = new Button( btnAsset );
			irregBtn.addAutoHitArea( true );
		
			addChild( irregBtn );
		}


		private function onClick(event : MouseEvent) : void
		{
			if ( event.target == leftBtn )
			{
				leftClicked++;
			}
			else
			{
				rightClicked++;
			}
			
			event.target.enabled = false;
			
			setTimeout(reenableBtn, 2000, event.target );
			
			textArea.tf.text = "L = "+ leftClicked +", R = "+rightClicked;
		}
		
		
		private function reenableBtn( target:Button ):void 
		{
			target.enabled = true;
		}
	}
}

package ui
{

	import flash.utils.setTimeout;
	import com.dezza.ricepaper.ui.button.UIButton;

	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	/**
	 * @author derek
	 */
	public class UIButtonPlayground extends MovieClip
	{
		private var leftBtn : UIButton;

		private var rightBtn : UIButton;

		private var textArea : PG_TextArea;
		
		private var rightClicked : int = 0;
		
		private var leftClicked : int = 0;

		private var irregBtn : UIButton;
		
		public function UIButtonPlayground()
		{
			leftBtn = new UIButton(new PG_UIButtonAsset());
			leftBtn.x = 100;
			leftBtn.y = 100;

			leftBtn.addEventListener(MouseEvent.CLICK, onClick);
			addChild(leftBtn);

			rightBtn = new UIButton(new PG_UIButtonAsset());
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
			
			irregBtn = new UIButton(new PG_UIButtonAssetNoBG());
			irregBtn.x = 100;
			irregBtn.y = 300;
			irregBtn.addAutoHitArea();
		
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
		
		
		private function reenableBtn( target:UIButton ):void 
		{
			target.enabled = true;
		}
	}
}

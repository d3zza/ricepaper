package com.dezza.ricepaper.ui.util {
	import org.flexunit.asserts.assertEquals;
	import flash.display.DisplayObject;
	import flexunit.framework.Assert;

	import flash.display.Sprite;
	/**
	 * @author dezza
	 */
	public class DisplayListUtilTests {
		
		public var content : Sprite;
		
		public var contentParent : Sprite;
		
		public var target : Sprite;
		
		public var returnValue : DisplayObject;
		
		[ Before ]
		public function runBeforeEachTest():void {
			content = new Sprite();
			content.x = 23;
			content.y = 65;
			content.rotation = 84;
			contentParent = new Sprite();
			target = new Sprite();
			contentParent.addChild(content);
			returnValue = DisplayListUtil.replaceAddChild( content, target );
		}
		
		[Test]
		public function childAdded():void {			
			Assert.assertEquals( "content not added to target", content.parent, target );
		}
		
		[Test]
		public function isAddedToChildsParent():void {
			Assert.assertEquals( "target was not added to contents parent", target.parent, contentParent );
		}
		
		[Test]
		public function targetReturned():void {
			assertEquals( "target was not returned", target, returnValue );
		}
		
		[Test]
		public function targetPosition():void {
			assertEquals( "target x value is wrong", 23, target.x );
			assertEquals( "target y value is wrong", 65, target.y );
			assertEquals( "target rotation value is wrong", 84, target.rotation );
		}
		
		[Test]
		public function contentPosition():void {
			assertEquals( "content x value is wrong", 0, content.x );
			assertEquals( "content y value is wrong", 0, content.y );
			assertEquals( "content rotation value is wrong", 0, content.rotation );
		}
		
	}
}

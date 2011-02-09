package com.dezza.ricepaper.ui {
	import flexunit.framework.Assert;

	/**
	 * @author derek
	 */
	public class UITests {
		
		private var testClass:TestClass;
		
		[Before]
		public function runBeforeEachTest():void {
			testClass = new TestClass(5);
		}
		
		[Test]
		public function constructr():void {
			Assert.assertEquals( testClass.num, 5 );
		}
	}
}

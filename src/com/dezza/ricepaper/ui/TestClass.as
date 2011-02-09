package com.dezza.ricepaper.ui {
	/**
	 * @author dezza
	 */
	public class TestClass {
		
		private var _num:int;

		public function TestClass( num:int ){
			_num = num;
		}
		
		/**
		 * get a num
		 * @return num <code>int</code>
		 */
		public function get num():int {
			return _num;
		}
	}
}

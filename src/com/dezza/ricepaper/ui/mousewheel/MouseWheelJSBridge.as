package com.dezza.ricepaper.ui.mousewheel
{

	import flash.external.ExternalInterface;
	
	
	/**
	 * Class that wraps javascript code for providing cross platform MouseWheel support
	 */
	public class MouseWheelJSBridge {
		
		/**
		 * @private
		 */
		public static const NS:String = "MWAS";
		
		/**
		 * @private
		 */
		public function MouseWheelJSBridge() {
			try {
				if( ExternalInterface.available ) {
					ExternalInterface.call( script_js );					
					ExternalInterface.call( "MWAS.setSWFObjectID", ExternalInterface.objectID );
				}
			} catch( error:Error ) {}
		}
		
		/**
		 * @private
		 */
		private const script_js:XML =
			<script>
				<![CDATA[
					function() {
						
						MWAS = {
							browserScrollingLocked : false,
							
							setSWFObjectID: function( swfObjectID ) {																
								MWAS.swfObjectID = swfObjectID;
							},
								
							scroll: function( delta ) {
								swf = MWAS.getSwf();
								swf.dispatchScrollWheel(delta);								
							},
								
							scrollListener: function( event ) {
								var delta = 0;
								if (!event) event = window.event;

								if (event.wheelDelta) {
									delta = event.wheelDelta / 120;
								} else if (event.detail) {
									delta = -event.detail / 3;
								}

								if (delta != 0) {
									MWAS.scroll(delta);
								}
	
								if( MWAS.browserScrollingLocked ) event.preventDefault();
								event.returnValue = false;
							},
								
							initScroll: function() {
								var handlerFunc = MWAS.scrollListener;
								
									if (window.addEventListener)
										window.addEventListener('DOMMouseScroll', handlerFunc, false);
										
									window.onmousewheel = handlerFunc;
									document.onmousewheel = handlerFunc;
							},
							
							lockBrowserScrolling: function ( lock ) {
								MWAS.browserScrollingLocked = lock;
							},
							
							getSwf: function getSwf() {								
								return document.getElementById( MWAS.swfObjectID );								
							}
							
						};
					}
				]]>
			</script>;
		
	}
}
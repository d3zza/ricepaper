package com.dezza.ricepaper.load
{

	import flash.events.Event;

	/**
	 * @author derek
	 */
	public class LoadSequencerEvent extends Event
	{

		public static const START : String = "SbsLoadSequencerEvent.START";

		public static const COMPLETE : String = "SbsLoadSequencerEvent.COMPLETE";

		private var _data : Object;


		public function LoadSequencerEvent(type : String, data : Object = null)
		{
			super(type);

			_data = data;
		}


		public function get data() : Object
		{
			return _data;
		}


		override public function clone() : Event
		{
			return new LoadSequencerEvent(type, data);
		}
	}
}

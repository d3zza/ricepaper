package com.dezza.ricepaper.load
{

	import com.dezza.ricepaper.log.ILogger;
	import com.dezza.ricepaper.log.LogLevel;
	import com.dezza.ricepaper.log.NullLogger;


	import flash.events.EventDispatcher;
	import flash.system.LoaderContext;

	/**
	 * @author dezza
	 */
	public class LoadSequencer extends EventDispatcher
	{

		private var _running : Boolean;

		private var _concurrentConnections : int = 4;

		private var _queuedLoaders : Array;

		private var _activeLoaders : Array;

		private var _loadsStarted : int = 0;

		private var _loadsFailed : int = 0;

		private var _loadsCompleted : int = 0;

		private var _loadsFinished : int = 0;

		private var _defaultContext : LoaderContext;

		private var _logger : ILogger;


		public function LoadSequencer()
		{
			super();

			_logger = new NullLogger();

			_queuedLoaders = [];

			_activeLoaders = [];
		}


		public function get concurrentConnections() : int
		{
			return _concurrentConnections;
		}


		public function set concurrentConnections(concurrentConnections : int) : void
		{
			_concurrentConnections = concurrentConnections;
		}


		public function get isRunning() : Boolean
		{
			return _running;
		}


		public function get defaultContext() : LoaderContext
		{
			return _defaultContext;
		}


		public function set defaultContext(defaultContext : LoaderContext) : void
		{
			_defaultContext = defaultContext;
		}


		public function get numLoadsStarted() : int
		{
			return _loadsStarted;
		}


		public function get numLoadsCompleted() : int
		{
			return _loadsCompleted;
		}


		public function get numLoadsFailed() : int
		{
			return _loadsFailed;
		}


		public function get numLoadsFinished() : int
		{
			return _loadsFinished;
		}


		public function get queuedCount() : int
		{
			return _queuedLoaders.length;
		}


		public function get activeCount() : int
		{
			return _activeLoaders.length;
		}


		public function get logger() : ILogger
		{
			return _logger;
		}


		public function set logger(logger : ILogger) : void
		{
			_logger = logger;
		}


		public function resetLoadCounts() : void
		{
			if ( _running ) throw new Error("Cannot reset load counts while running");

			_logger.log(this, ".resetLoadCounts()", LogLevel.INFO);

			_loadsStarted = 0;

			_loadsCompleted = 0;

			_loadsFailed = 0;

			_loadsFinished = 0;
		}


		public function queue(loader : ILoader) : void
		{
			if ( !loader )
			{
				throw new Error("No loader passed");
			}

			if ( isQueued(loader) || isActive(loader) )
			{
				throw new Error("Loader '" + loader + "' has already been added");
			}

			_logger.log(this, ".queue()", LogLevel.INFO);

			_queuedLoaders.push(loader);

			if ( _running ) checkLoadNext();
		}


		public function queueMany(array : Array) : void
		{
			if ( !array )
			{
				throw new Error("No array passed");
			}

			_logger.log(this, ".queueMany() " + array.length, LogLevel.INFO);

			var loader : ILoader;

			for (var i : int = 0; i < array.length; i++)
			{
				loader = array[i];
				if ( loader && !isQueued(loader) && !isActive(loader) )
				{
					_queuedLoaders.push(loader);
				}
			}

			if ( _running ) checkLoadNext();
		}


		public function isActive(loader : ILoader) : Boolean
		{
			if ( _activeLoaders.indexOf(loader) > -1 ) return true;

			return false;
		}


		public function isQueued(loader : ILoader) : Boolean
		{
			if ( _queuedLoaders.indexOf(loader) > -1 ) return true;

			return false;
		}


		public function dequeue(loader : ILoader) : Boolean
		{
			var i : int = _queuedLoaders.indexOf(loader);

			if ( i === -1 ) return false;

			_logger.log(this, ".dequeue() loader: " + loader, LogLevel.INFO);

			_queuedLoaders.splice(i, 1);

			return true;
		}


		public function start() : void
		{
			if ( _running ) return;

			_logger.log(this, ".start()", LogLevel.INFO);

			_running = true;

			dispatchEvent(new LoadSequencerEvent(LoadSequencerEvent.START));

			checkLoadNext();
		}


		public function remove(loader : ILoader) : Boolean
		{
			if ( isQueued(loader) )
			{
				dequeue(loader);
				_logger.log(this, ".remove() loader: " + loader + " dequeued", LogLevel.INFO);
				return true;
			}

			if ( isActive(loader) )
			{
				_logger.log(this, ".remove() active loader: " + loader + " removed", LogLevel.WARN);

				removeActiveLoader(loader);

				_loadsFinished++;

				checkLoadNext();

				return true;
			}

			return false;
		}


		private function checkLoadNext() : void
		{
			if ( _queuedLoaders.length == 0 && _activeLoaders.length == 0 )
			{
				allLoadsComplete();
				return;
			}

			while ( _activeLoaders.length < _concurrentConnections && _queuedLoaders.length > 0 )
			{
				startNextLoad();
			}
		}


		private function startNextLoad() : void
		{
			var loader : ILoader = _queuedLoaders.shift();

			_logger.log(this, ".startNextLoad()", LogLevel.DEBUG);

			if ( !loader.context && defaultContext )
			{
				loader.context = defaultContext;
			}

			_activeLoaders.push(loader);

			loader.start();

			_loadsStarted++;

			addLoaderListeners(loader);
		}


		private function addLoaderListeners(loader : ILoader) : void
		{
			loader.addEventListener(LoaderEvent.COMPLETE, onLoaderComplete, false, -1000, true);
			loader.addEventListener(LoaderEvent.ERROR, onLoaderFailed, false, -1000, true);
			loader.addEventListener(LoaderEvent.TIME_OUT, onLoaderFailed, false, -1000, true);
		}


		private function removeLoaderListeners(loader : ILoader) : void
		{
			loader.removeEventListener(LoaderEvent.COMPLETE, onLoaderComplete);
			loader.removeEventListener(LoaderEvent.ERROR, onLoaderFailed);
			loader.removeEventListener(LoaderEvent.TIME_OUT, onLoaderFailed);
		}


		private function onLoaderFailed(event : LoaderEvent) : void
		{
			_logger.log(this, ".onLoaderFailed()", LogLevel.ERROR);

			var loader : ILoader = event.loader;

			removeActiveLoader(loader);

			_loadsFailed++;

			_loadsFinished++;

			loader.destroy();

			checkLoadNext();
		}


		private function onLoaderComplete(event : LoaderEvent) : void
		{
			var loader : ILoader = event.loader;

			_logger.log(this, "loader complete: " + loader, LogLevel.INFO);

			removeActiveLoader(loader);

			_loadsCompleted++;

			_loadsFinished++;

			checkLoadNext();
		}


		private function removeActiveLoader(loader : ILoader) : Boolean
		{
			for ( var i : int = 0;i < _activeLoaders.length;i++ )
			{
				if ( _activeLoaders[i] == loader )
				{
					removeLoaderListeners(loader);

					_activeLoaders.splice(i, 1);

					return true;
				}
			}

			return false;
		}


		private function allLoadsComplete() : void
		{
			_running = false;

			_logger.log(this, "all loads complete", LogLevel.INFO);

			dispatchEvent(new LoadSequencerEvent(LoadSequencerEvent.COMPLETE));
		}
	}
}

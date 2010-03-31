package rx
{
	import rx.joins.Pattern;
	import rx.scheduling.IScheduler;
	
	public interface IObservable
	{
		function get type() : Class;
		
		/**
		 * Subscribes to this observable using the supplied functions 
		 * @param onNext Function to be called for every payload. Signature is function(payload : T) : void
		 * @param onComplete Optional. Function to be called when the sequence completes. Signature is function():void
		 * @param onError Optional. Function to be called when an error occurs in the sequence. Signature is function(err:Error):void
		 * @return An instance of ISubscription that can be used to unsubscribe at anytime by calling unsubscribe() 
		 */
		function subscribeFunc(onNext : Function, onComplete : Function = null, 
			onError : Function = null) : ISubscription;
		
		/**
		 * Subscribes to this observable using the supplied observer 
		 * @param scheduler Optional. The schduler to use
		 * @return An instance of ISubscription that can be used to unsubscribe at anytime by calling unsubscribe() 
		 */
		function subscribe(observer : IObserver) : ISubscription;
		
		function aggregate(accumulator : Function) : IObservable;
		
		function amb(sources : Array/*.<IObservable>*/) : IObservable;
		
		function and(right : IObservable) : Pattern;
		
		function asynchronous() : IObservable;
		
		function bufferWithCount(count : int, skip : int = 0) : IObservable;
		
		function bufferWithTime(timeMs : int, timeShiftMs : int = 0, scheduler : IScheduler = null) : IObservable;
		
		function cast(type : Class) : IObservable;
		
		// TODO: ??
		// function catchError();
		
		function combineLatest(right : IObservable, selector : Function) : IObservable;
		
		function concat(sources : Array/*.<IObservable>*/, scheduler : IScheduler = null) : IObservable;
		
		function contains(value : Object, comparer : Function = null) : IObservable
		
		function count() : int;
		
		// static create(subscribe : Function) : IObservable;

		function delay(delayMs : int, scheduler : IScheduler = null) : IObservable;
		function delayUntil(dt : Date, scheduler : IScheduler = null) : IObservable;
		
		function dematerialize(type : Class):IObservable;
		
		function doAction(action : Function) : IObservable;
		
		function finallyAction(finallyAction : Function) : IObservable;
		
		function first() : IObservable;
		
		function firstOrDefault() : IObservable;
		
		function forkJoin(sources : Array/*.<IObservable>*/) : IObservable;
		
		// TODO: What's the equivalent?
		//function fromAsyncPattern
		
		// TODO: Lot's of overloads to look at
		// function generate() : IObservable;
		
		function asObservable() : IObservable;
		
		function distinctUntilChanged(comparer : Function) : IObservable;
		
		function join(plans : Array/*.<Plan>*/) : IObservable;
		
		function last() : IObservable;
		function lastOrDefault() : IObservable;
		
		function latest() : Array;
		//function latestValue() : IPropertyGetter;
		
		function let(func : Function) : IObservable;
		
		function materialize() : IObservable;
		
		function merge(sources : Array/*.<IObservable>*/, scheduler : IScheduler = null) : IObservable;
		
		function mostRecent(initialValue : Object) : IObservable;
		//function mostRecentValue(initialValue : Object) : IPropertyGetter;
		
		function ofType(type : Class) : IObservable;

		function observeOn(scheduler : IScheduler) : IObservable;
		
		function onErrorResumeNext(sources : Array/*.<IObservable>*/, scheduler : IScheduler = null) : IObservable; 
		 
		// TODO: ??
		//function prune (scheduler : IScheduler = null)
		
		function publish(scheduler : IScheduler = null) : Subject;
		
		// static function range(start : int, count : int, scheduler : IScheduler = null) : IObservable;
		
		// static function repeatValue(value : Object, repeatCount : int = 0) : IObservable;
		
		function removeTimestamp(type : Class) : IObservable;
		
		function repeat(repeatCount : int = 0, scheduler : IScheduler = null) : IObservable;
		
		// TODO: ??
		// function replay() : IObservable
		
		function retry(retryCount : int, scheduler : IScheduler = null) : IObservable;
		
		function returnValue(value : Object) : IObservable;
		
		function select(result : Class, selector:Function):IObservable;
		
		function selectMany(type : Class, selector : Function) : IObservable;
		
		function single() : IObservable;
		function singleOrDefault() : IObservable;
		
		function skip(count : int) : IObservable;
		
		function skipUntil(other : IObservable) : IObservable;
		
		function skipWhile(predicate : Function) : IObservable;
		
		//static function start(func : Function, scheduler : IScheduler = null) : IObservable;
		
		// TODO: ??
		function sum() : Number;
		
		function take(count : int, scheduler : IScheduler = null) : IObservable;
		
		function takeUntil(other : IObservable) : IObservable;
		
		function takeWhile(predicate : Function) : IObservable;
		
		function throttle(dueTimeMs : int, scheduler : IScheduler = null) : IObservable;
		
		function timeInterval(scheduler : IScheduler = null) : IObservable;
		
		function timeout(timeoutMs : int, other : IObservable = null, scheduler : IScheduler = null) : IObservable;
		
		// static function timer(dueTimeMs : int) : IObservable;
		
		function timestamp(scheduler : IScheduler = null) : IObservable;
		
		function toAsync(func : Function) : IObservable;
		
		// TODO: ??
		// function using
		
		function where(predicate : Function) : IObservable;
		
		function zip(resultType : Class, rightSource : IObservable, selector : Function) : IObservable;
	}
}
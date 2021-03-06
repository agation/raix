package raix.reactive
{
	import raix.reactive.IObserver;
	import raix.reactive.Notification;
	import raix.reactive.NotificationKind;
	
	/**
	 * A Notification for an onCompleted call
	 */
	public class OnCompleted/*.<T>*/ extends Notification/*.<T>*/
	{
		public function OnCompleted()
		{
		}
		
		/**
		 * Calls onCompleted if it's not null
		 */
		public override function accept(onNext : Function, onCompleted : Function = null, 
			onError : Function = null) : void
		{
			if (onCompleted != null)
			{
				onCompleted();
			}
		}
		
		/**
		 * Always returns false since no values are associated with completion 
		 */
		public override function get hasValue() : Boolean
		{
			return false;
		}
		
		/**
		 * Always returns false since no errors are associated with completion 
		 */
		public override function get error() : Error
		{
			return null;
		}
		
		/**
		 * Always returns null since no values are associated with completion 
		 */
		public override function get value() : Object // T
		{
			return null;
		}
		
		/**
		 * Always returns NotificationKind.ON_COMPLETED 
		 */
		public override function get kind() : int
		{
			return NotificationKind.ON_COMPLETED;
		}

	}
}
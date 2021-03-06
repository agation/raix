package raix.reactive.tests.operators.composition
{
	import org.flexunit.Assert;
	
	import raix.reactive.*;
	import raix.reactive.tests.mocks.StatsObserver;
	import raix.reactive.tests.operators.AbsDecoratorOperatorFixture;
	
	public class FinallyActionFixture extends AbsDecoratorOperatorFixture
	{
		protected override function createEmptyObservable(source:IObservable):IObservable
		{
			return source.finallyAction(function():void{});
		}
		
		[Test]
        public function finally_action_is_executed_on_complete() : void
        {
            var finallyCalled : Boolean = false;

            var stats : StatsObserver = new StatsObserver();

            Observable.empty()
                .finallyAction(function():void
                {
                    finallyCalled = true;
                })
                .subscribeWith(stats);

            Assert.assertTrue(finallyCalled);
        }

        [Test]
        public function finally_action_is_executed_after_complete() : void
        {
            var stats : StatsObserver = new StatsObserver();

            Observable.empty()
                .finallyAction(function():void
                {
                    Assert.assertTrue(stats.completedCalled);
                })
                .subscribeWith(stats);
        }

        [Test]
        public function finally_action_is_executed_on_error() : void
        {
            var finallyCalled : Boolean = false;

            var stats : StatsObserver = new StatsObserver();

            Observable.error(new Error())
            	.finallyAction(function():void
            	{
            		finallyCalled = true;
            	})
            	.subscribeWith(stats);

            Assert.assertTrue(finallyCalled);
        }

        [Test]
        public function finally_action_is_executed_after_error() : void
        {
            var stats : StatsObserver = new StatsObserver();
            
            Observable.error(new Error())
            	.finallyAction(function():void
            	{
            		Assert.assertTrue(stats.errorCalled);
            	})
            	.subscribeWith(stats);
        }

        [Test]
        public function finally_action_is_executed_after_source_subscription_is_disposed() : void
        {
            var stats : StatsObserver = new StatsObserver();

            var sourceSubscriptionDisposed : Boolean = true;
            
            Observable.createWithCancelable(function(obs : IObserver):ICancelable
            	{
            		return Cancelable.create(function():void
            		{
            			sourceSubscriptionDisposed = true;
            		});
            	})
            	.finallyAction(function():void
            	{
            		Assert.assertTrue(sourceSubscriptionDisposed);
            	})
            	.subscribeWith(stats)
            	.cancel();
        }

        [Test(expects="Error")]
        public function finally_action_is_executed_if_disposition_source_subscription_throws_exception() : void
        {
            var stats : StatsObserver = new StatsObserver();

            var finallyCalled : Boolean = true;

            try
            {
            	Observable.createWithCancelable(function(obs : IObserver):ICancelable
            	{
            		return Cancelable.create(function():void
            		{
            			throw new Error();
            		});
            	})
            	.finallyAction(function():void
            	{
            		finallyCalled = true;
            	})
            	.subscribeWith(stats)
            	.cancel();
            }
            finally
            {
                Assert.assertTrue(finallyCalled);
            }
        }
		
		[Test(expects="ArgumentError")]
		public function error_is_thrown_if_action_is_null() : void
		{
			Observable.empty().finallyAction(null);
		}
		
		[Test(expects="Error")]
		public function errors_thrown_by_finallyAction_are_bubbled() : void
		{	
			var obs : IObservable = Observable.empty().finallyAction(function():void
			{
				throw new Error();
			});
			
			obs.subscribe(
				function(pl:int):void { },
				function():void { },
				function(e:Error):void { Assert.fail("Unexpected call to onError"); }
			);
		}
		
		[Test(expects="Error")]
		public function errors_thrown_by_subscriber_are_bubbled() : void
		{
			var obs : IObservable = Observable.range(0, 1)
				.finallyAction(function():void{});
			
			obs.subscribe(
				function(pl:int):void { throw new Error(); },
				function():void { },
				function(e:Error):void { Assert.fail("Unexpected call to onError"); }
			);
		}

	}
}
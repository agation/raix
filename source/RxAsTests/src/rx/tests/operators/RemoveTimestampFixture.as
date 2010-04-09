package rx.tests.operators
{
	import org.flexunit.Assert;
	
	import rx.IObservable;
	import rx.Subject;
	
	[TestCase]
	public class RemoveTimestampFixture extends AbsDecoratorOperatorFixture
	{
		protected override function createEmptyObservable(source:IObservable):IObservable
		{
			return source.timestamp().removeTimestamp(source.type);
		}
		
		[Test]
		public function original_values_are_used() : void
		{
			var manObs : Subject = new Subject(int);
			
			var obs : IObservable = manObs.timestamp().removeTimestamp(int);
			
			var expectedValues : Array = [1, 2, 3, 4];
			
			obs.subscribeFunc(function(pl:int):void
			{
				Assert.assertEquals(expectedValues.shift(), pl);
			});
			
			manObs.onNext(1);
			manObs.onNext(2);
			manObs.onNext(3);
			manObs.onNext(4);
			
			Assert.assertEquals(0, expectedValues.length);
		}

		[Test(expects="Error")]
		public function errors_thrown_by_subscriber_are_bubbled() : void
		{
			var manObs : Subject = new Subject(int);
			
			var obs : IObservable = manObs.timestamp().removeTimestamp(int);
			
			obs.subscribeFunc(
				function(pl:int):void { throw new Error(); },
				function():void { },
				function(e:Error):void { Assert.fail("Unexpected call to onError"); }
			);

			manObs.onNext(0);
		}
	}
}
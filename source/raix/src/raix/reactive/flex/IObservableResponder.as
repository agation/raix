package raix.reactive.flex
{
	import mx.rpc.IResponder;
	
	import raix.reactive.IObservable;
	
	/**
	 * An observable sequence that is also an mx.rpc.IResponse
	 */	
	public interface IObservableResponder extends IResponder, IObservable
	{
	}
}
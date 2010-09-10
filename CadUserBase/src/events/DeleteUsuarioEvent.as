package events
{
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	public class DeleteUsuarioEvent extends Event
	{
		public const DELETE_USUARIO_EVENT:String = "deleteUsuarioEvent";
		
		public function DeleteUsuarioEvent()
		{
			super(DELETE_USUARIO_EVENT);
		}
	}
}
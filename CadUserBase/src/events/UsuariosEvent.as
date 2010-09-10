package events
{
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	public class UsuariosEvent extends Event
	{
		public var usuarios:ArrayCollection;

		public const USUARIOS_EVENT:String = "usuariosEvent";

		
		public function UsuariosEvent(usuarios:ArrayCollection)
		{
			super(USUARIOS_EVENT);
			this.usuarios = usuarios;
		}
	}
}
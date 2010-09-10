package events
{
	import flash.events.Event;
	
	import model.Usuario;
	
	public class AddUsuarioEvent extends Event
	{
		public var usuario:Usuario;
		
		public const ADD_USUARIO_EVENT:String = "addUsuarioEvent";
		
		public function AddUsuarioEvent(usuario:Usuario)
		{
			super(ADD_USUARIO_EVENT);
			this.usuario = usuario;
		}
	}
}
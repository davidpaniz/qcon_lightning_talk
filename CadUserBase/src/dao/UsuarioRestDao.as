package dao
{
	import events.AddUsuarioEvent;
	import events.DeleteUsuarioEvent;
	import events.UsuariosEvent;
	
	import flash.events.EventDispatcher;
	
	import model.Usuario;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import org.osmf.metadata.Metadata;

	
	
	[Event(name="usuariosEvent", type="events.UsuariosEvent")]
	[Event(name="addUsuarioEvent", type="events.AddUsuarioEvent")]
	[Event(name="deleteUsuarioEvent", type="events.DeleteUsuarioEvent")]
	public class UsuarioRestDao extends EventDispatcher
	{
		
		private const HOST:String = "http://cadusuario.heroku.com/";
		
		public function getUsuarios():void
		{
			var service:HTTPService = new HTTPService()
			service.addEventListener(FaultEvent.FAULT, erroGenreico);
			service.url = HOST + "usuarios.xml";
			service.method = "GET";
			service.resultFormat = "e4x";
			service.addEventListener(ResultEvent.RESULT, getUsuariosResult);
			
			service.send();
		}
		
		private function getUsuariosResult(event:ResultEvent = null):void
		{
			var usuarios:ArrayCollection = new ArrayCollection();
			for each( var xml:XML in event.result.usuario)
			{
				var u:Usuario = new Usuario();
				u.id = xml.id;
				u.nome = xml.nome;
				u.sobrenome = xml.sobrenome;
				usuarios.addItem(u);
			}
			dispatchEvent(new UsuariosEvent( usuarios ));
		}	
		
		public function addUsuario(usuario:Usuario):void
		{
			var service:HTTPService = new HTTPService()
			service.addEventListener(FaultEvent.FAULT, erroGenreico);
			service.url = HOST + "usuarios.xml";
			service.method = "POST";
			service.resultFormat = "e4x";
			service.addEventListener(ResultEvent.RESULT, addUsuarioResult);
			
			service.send({'usuario[nome]': usuario.nome, 'usuario[sobrenome]': usuario.sobrenome});
		}
		
		public function addUsuarioResult(event:ResultEvent):void
		{
			var uXml:XML = event.result as XML;
			var u:Usuario = new Usuario();
			u.nome = uXml.nome;
			u.sobrenome = uXml.sobrenome;
			u.id = uXml.id;
			
			dispatchEvent(new AddUsuarioEvent(u));
		}
				
		public function deleteUsuario(usuario:Usuario):void
		{
			var service:HTTPService = new HTTPService()
			service.addEventListener(FaultEvent.FAULT, erroGenreico);
			service.url = HOST + "usuarios/"+usuario.id+".xml";
			service.method = "POST";
			service.resultFormat = "e4x";
			service.addEventListener(ResultEvent.RESULT, deleteUsuarioResult);
			
			service.send({'_method': "DELETE"});
		}
		
		public function deleteUsuarioResult(event:ResultEvent = null):void
		{
			dispatchEvent(new DeleteUsuarioEvent());
		}
		
		private function erroGenreico(event:FaultEvent = null):void
		{
			Alert.show(event.fault.message);
		}
		
		public function UsuarioRestDao()
		{
		}
	}
}
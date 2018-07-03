package dominio

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.exceptions.UserException

@Accessors
class BootStrap  {
	List<Contacto> contactos 
	
	new() {
		cargarContactos
	}
	
	def cargarContactos(){
	//contactos
		contactos = newArrayList(
		 new Contacto => [nombre = "Macri"
		 					apellido ="Gato"
		 					email = "FMI@ajustes.com" 
		 					telefono= 1598764536
		 ],
		  new Contacto => [nombre = "Mauro"
		 					apellido ="Marino"
		 					email = "yo@gmail.com" 
		 					telefono= 1534565432
		 ],
		 new Contacto => [nombre = "Nahue"
		 					apellido ="Aprobame"
		 					email = "jaja@dale.com" 
		 					telefono= 1598764536
		 ],
		  new Contacto => [nombre = "Tincho"
		 					apellido ="Convencelo"
		 					email = ":)@unq.com" 
		 					telefono= 1534565432
		 ]);
		}
		
	def agregarContacto(Contacto contacto){
		validarContactosDuplicados(contacto)
		contactos.add(contacto)
		println("Se Agrego el Contacto Correctamente")
	}
		
	def void validarContactosDuplicados(Contacto contacto) {
		val nombre = contacto.nombre
		val apellido = contacto.apellido
		if (! this.search(nombre, apellido).isEmpty ) {
			throw new UserException("El contacto ya se encuentra en la agenda")
		}contacto.validar
	}
	
	def search(String nombre, String apellido) {
		contactos.filter[contacto | (nombre == contacto.nombre)&& (apellido == contacto.apellido)].toList
	}
}
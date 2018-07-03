package dominio

import org.uqbar.commons.model.CollectionBasedRepo

import org.uqbar.commons.model.exceptions.UserException
import org.apache.commons.collections15.Predicate
import org.uqbar.commons.model.annotations.Observable
import java.util.List
import org.uqbar.arena.bootstrap.CollectionBasedBootstrap
import org.uqbar.commons.applicationContext.ApplicationContext

@Observable
class Repo extends CollectionBasedRepo<Contacto>{
	
	def Contacto create(String cNombre, String cApellido, String cEmail, Integer cTelefono) {
		val contacto = new Contacto() => [
			nombre = cNombre
			apellido = cApellido
			email = cEmail
			telefono = cTelefono
		]
		this.create(contacto)
		contacto
	}
	
	override void validateCreate(Contacto contacto) {
	    contacto.validar()
		validarContactosDuplicados(contacto)
	}

	/**
	 * Valida que no haya dos contactos con el mismo mail
	 */
	def void validarContactosDuplicados(Contacto cliente) {
		val email = cliente.email
		if (!this.search(email).isEmpty) {
			throw new UserException("El contacto ya se encuentra en la agenda")
		}
	}
	
	def search(String email) {
		allInstances.filter[contacto | (email == contacto.email)].toList
	}
	
	def List<Contacto> getContactos() {
		allInstances	
	}
	
	override createExample() {
		new Contacto
	}
	
	override getEntityType() {
		typeof(Contacto)
	}
	
	override Predicate<Contacto> getCriterio(Contacto contacto) {
		null
	}

}



class BootSt extends CollectionBasedBootstrap {
	new() {
		ApplicationContext.instance.configureSingleton(typeof(Contacto), new Repo)
	}
	
	override run() {
		
		val repoContactos = ApplicationContext.instance.getSingleton(typeof(Contacto)) as Repo
	//contactos
		repoContactos.create("Jose","ElColo", "elColo@gmail.com" , 48557894)
		repoContactos.create("Fede", "ElTurro", "fede@gmail.com" , 48557894)
		repoContactos.create("Lisa", "LaCrack", "lisa@gmail.com" , 48557894)
		repoContactos.create("Mauro", "Yo", "mauro@gmail.com" , 48557894)
		}
		
}
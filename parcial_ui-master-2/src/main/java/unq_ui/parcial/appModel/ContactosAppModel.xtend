package unq_ui.parcial.appModel

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.TransactionalAndObservable
import dominio.Contacto
import java.util.List
import dominio.BootStrap

@Accessors
@TransactionalAndObservable
class ContactosAppModel {
	List<Contacto> contactos = newArrayList
	Contacto contactoSeleccionado = null
	Contacto contactoBase
    BootStrap contactosAgendados
	//List<Contacto>contactosAgendados
	//Repo contactoss
	
	new(){
		cargarAgenda
		contactoBase = new Contacto
		
		refresh
	}
	
	new (Contacto contacto){
		contactoSeleccionado = contacto
	}
	
	def refresh(){
		contactos = #[]
		contactos = contactosAgendados.contactos
	}
	
	def cargarAgenda(){
		contactosAgendados = new BootStrap
		//contactosAgendados = contactoss.contactos
	}
	
	def destacarContacto(){
		contactoSeleccionado.destacarme()
	}
	
	def cargarContacto(){
		//contactoss.create(contactoBase.nombre,contactoBase.apellido,contactoBase.email,contactoBase.telefono)
		contactosAgendados.agregarContacto(contactoBase);
		contactoBase = new Contacto
		refresh;
	}
	
	def actualizarDatos(){
		contactoSeleccionado.validar
	}
}





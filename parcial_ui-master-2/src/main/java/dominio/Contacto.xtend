package dominio

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.TransactionalAndObservable
import org.uqbar.commons.model.exceptions.UserException
import java.util.regex.Pattern
import org.uqbar.commons.model.Entity

@Accessors
@TransactionalAndObservable
class Contacto extends Entity implements Cloneable{
	String nombre
	String apellido
	String email
	Integer telefono
	Boolean soyFavorito 
	static final int MIN_NUMERO_TELEFONO = 10000000

	new() {
		soyFavorito = false
	}
	
	def validar() {
		
		validarCampoVacio("nombre",nombre);
		validarCampoVacio("apellido",apellido);
		validarCampoVacio("email",email);
		
		if (esMailInvalido(email)) {
			throw new UserException("Ingrese un e-mail válido")
		}
		
		if(telefono === null ){
			throw new UserException("Ingrese un telefono celular")
		}
		if (esTelefonoInvalido(telefono)) {
			throw new UserException("Ingrese un telefono válido")
		}
		
	}
	
	def validarCampoVacio(String campo, String aComprobar){
		if (aComprobar === null || aComprobar.trim().equals("")) {
			throw new UserException("Debe ingresar un " + campo)
		}
	}
	
	def esMailInvalido(String email) {
		val emailRegex = ("^.+@.+\\..+$");
        val pat = Pattern.compile(emailRegex);
        return ! pat.matcher(email).matches();
	}
	
	def esTelefonoInvalido(Integer tel) {
        return tel < MIN_NUMERO_TELEFONO    
	}
	
	def destacarme(){
		soyFavorito = !soyFavorito
	}
	
}
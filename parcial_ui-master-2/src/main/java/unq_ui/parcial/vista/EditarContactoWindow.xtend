package unq_ui.parcial.vista

import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.WindowOwner
import dominio.Contacto
import org.uqbar.arena.aop.windows.TransactionalDialog

class EditarContactoWindow extends TransactionalDialog<Contacto> {
	
	new(WindowOwner owner, Contacto model) {
		super(owner, model)
		title = "Editar Contacto"
	}
	
	override protected createFormPanel(Panel mainPanel) {
		new AgregadoDeNuevoContactoPanel(mainPanel, "", "Aceptar", [this.accept])
	}
	
}
package unq_ui.parcial.vista

import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Container
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.Label

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.widgets.NumericField
import org.uqbar.lacar.ui.model.Action
import org.uqbar.arena.widgets.Button
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class AgregadoDeNuevoContactoPanel extends Panel {
	String alcance;
	Action buttonAction
	String buttonCaption
	
	new(Container container, String alcance, String buttonCaption, Action buttonAction) {
		super(container)
		this.alcance = alcance
		this.buttonCaption = buttonCaption
		this.buttonAction = buttonAction
		crearPanelPrincipal 
	}
	
	def crearPanelPrincipal(Panel panel)  {
		crearLabelConTextbox(panel, "Nombre", "nombre", false)
		crearLabelConTextbox(panel, "Apellido", "apellido", false)
		crearLabelConTextbox(panel, "Email", "email", false)
		crearLabelConTextbox(panel, "Telefono", "telefono", true)
		
		new Button(panel) => [
			caption = buttonCaption
			onClick(buttonAction)
			width = 100
			setAsDefault
			disableOnError	
		]
		
	}
	
	def crearLabelConTextbox(Panel panel, String label, String property, boolean numeric) {
		new Label(panel) => [
			text = label 
		]
		
		val field = if (numeric) new NumericField(panel, false) else new TextBox(panel)
		
		field => [
			value <=> alcance + property
			width = 140
		]
	}
	
}
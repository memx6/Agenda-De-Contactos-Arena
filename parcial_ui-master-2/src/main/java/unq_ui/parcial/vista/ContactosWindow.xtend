package unq_ui.parcial.vista



import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.bindings.NotNullObservable
import org.uqbar.arena.layout.ColumnLayout
import unq_ui.parcial.appModel.ContactosAppModel
import dominio.Contacto

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.widgets.GroupPanel

class ContactosWindow extends SimpleWindow<ContactosAppModel>{

	new(WindowOwner parent, ContactosAppModel model) {
		
		super(parent, model)
		title = "Contactos"
	}
	
	override protected createFormPanel(Panel mainPanel) {
		
		crearPanelPrincipal(mainPanel)
	}
	def protected crearPanelPrincipal(Panel mainPanel) {
		val panel = new Panel(mainPanel) => [layout = new ColumnLayout(2) ]
		this.createTableContactos(panel)
		
		this.crearPanelDeAgregado(panel)
	}
	
	override protected addActions(Panel actionsPanel) {
	}
	
	def createTableContactos(Panel mainPanel) {
	 	val panel = new Panel(mainPanel); 
		
		val tabla = new Table(panel, Contacto) => [
			items <=> "contactos"
			value <=> "contactoSeleccionado"
			numberVisibleRows = 5
		]
		new Column(tabla) => [
			title = "Nombre "
			alignRight
			bindContentsToProperty("nombre")
		]
		new Column(tabla) => [
			title = "Apellido"
			alignRight
			bindContentsToProperty("apellido")
		]
		new Column(tabla) => [
			title = "Favorito"
			alignRight
			bindContentsToProperty("soyFavorito").transformer = [Boolean estado | if (estado) "Sí" else "No"]
		];
	
		this.addActionsContactos(panel)
		}

	 
	 def addActionsContactos(Panel panel) {
	 	val notNullSeleccionada = new NotNullObservable(modelObject, "contactoSeleccionado")
		
		new Button(panel) => [
			caption = "Favorito"
			onClick [|this.modelObject.destacarContacto]
			bindEnabled(notNullSeleccionada)
		    ]
		    new Button(panel) => [
			caption = "Editar"
			onClick([|editarContacto])
			bindEnabled(notNullSeleccionada)
		]
	}
	
	def crearPanelDeAgregado(Panel panel) {
		val groupPanel = new GroupPanel(panel) => [
			title = "Agendar Contacto Nuevo"
		]
		new AgregadoDeNuevoContactoPanel(groupPanel,"contactoBase.",
			"Agregar",[this.modelObject.cargarContacto])
	}
	
	def void editarContacto(){
		new EditarContactoWindow(this, modelObject.contactoSeleccionado) => [
			onAccept[this.modelObject.actualizarDatos]
			open
			]
	}
	
	
}
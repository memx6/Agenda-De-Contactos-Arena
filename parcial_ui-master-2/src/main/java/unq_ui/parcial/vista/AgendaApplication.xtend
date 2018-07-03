package unq_ui.parcial.vista

import org.uqbar.arena.Application
import unq_ui.parcial.appModel.ContactosAppModel

class AgendaApplication extends Application{
	
	override protected createMainWindow() {
		return new ContactosWindow(this, new ContactosAppModel)
	}
	
	def static void main(String[] args){
		new AgendaApplication().start()
	}
	
	
}
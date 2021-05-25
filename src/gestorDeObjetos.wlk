import wollok.game.*

object gestorDeObjetos {
	
	method remover(objeto) {
		game.removeVisual(objeto) 
	}
	
	method agregar(objeto) {
		game.addVisual(objeto)
	}
	
	method agregarEnPosicionDelPersonaje(personaje, objeto) {
		objeto.position(personaje.position())
		self.agregar(objeto)
	}
}

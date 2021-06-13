import wollok.game.*
import objetos.*
import enemigos.*
import niveles.*

object gestorDeObjetos {
			
	method remover(objeto) {
		game.removeVisual(objeto) 
	}
	
	method agregar(objeto) {
		game.addVisual(objeto)
	}
	
	method agregarObjetos(_objetos) {
		_objetos.forEach({objeto => self.agregar(objeto)});
	}
	
	method agregarEnPosicionDelPersonaje(personaje, objeto) {
		objeto.position(personaje.position())
		self.agregar(objeto)
	}
}

object gestorDeEnemigos {
	
	const property boss = new Boss(image = "boss1.png", position = game.origin())
	var property enemigos = []
	
	method remover(enemigo) {
		enemigos.remove(enemigo)
		gestorDeObjetos.remover(enemigo)
	}
	
	method agregar(enemigo) {
		enemigos.add(enemigo)
		gestorDeObjetos.agregar(enemigo)
	}
	
	method agregarEnemigos(_enemigos) {
		if (enemigos.isEmpty()) {
			enemigos.addAll(_enemigos)
			gestorDeObjetos.agregarObjetos(_enemigos)
		} else {
			gestorDeObjetos.agregarObjetos(enemigos)
		}
		
	}
}

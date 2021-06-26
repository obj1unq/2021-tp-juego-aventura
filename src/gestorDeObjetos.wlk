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

object inventarioPantalla {
	
	const property boss = new Boss(image = "boss1.png", position = game.origin(), maxVida = 500, actualVida = 500)
	var property objetos = []
	var property ultimaPosicionHeroe = game.origin();
	
	method remover(objeto) {
		objetos.remove(objeto)
		gestorDeObjetos.remover(objeto)
	}
	
	method agregar(objeto) {
		objetos.add(objeto)
		gestorDeObjetos.agregar(objeto)
	}
	
	method agregarObjetos(_objeto) {
		if (objetos.isEmpty()) {
			objetos.addAll(_objeto)
			gestorDeObjetos.agregarObjetos(_objeto)
		} else {
			gestorDeObjetos.agregarObjetos(objetos)
		}
	}
	
	method agregarEnPosicionDelPersonaje(personaje, objeto) {
		gestorDeObjetos.agregarEnPosicionDelPersonaje(personaje, objeto)
		objetos.add(objeto)
	}
}

import hechizos.*
import objetos.*
import wollok.game.*
import niveles.*
import gestorDeObjetos.*

class Heroe {
	var property mochila = #{}
	var property libroDeHechizos = #{}
	var property armaEquipada = null
	var property armaduraEquipada = null
	var property maxVida
	var property actualVida
	var property maxMana
	var property actualMana
	
	var property nivelActual = nivelInicial
	var property position = null;
	const secuenciaAtaque = new AnimacionAtaque()
	
	//############################################################## Mensajes con Objetos
	method tomarObjeto() {
		self.tomarObjetoQueTenesDebajo()
	}
	
	method tomarObjetoQueTenesDebajo() {
        self.tomar(self.objetoDebajo())
    }
	
	method tomar(objeto) {
        objeto.interactuar(self)
    }

    method objetoDebajo() {
        const objetos = game.colliders(self)
        if (objetos.isEmpty()) {
            self.error("No hay nada acá")
        }
        return objetos.head()
    }
    //############################################################## FIN Mensajes con Objetos
    
    //############################################################## Mensajes con Equipo
	method equiparArma(equipo) {
		inventarioPantalla.remover(equipo)
		if ( self.tieneArmaEquipada() ) {
			self.tirarEquipoAReemplazar(self.armaEquipada())	
		}
		self.armaEquipada(equipo)
	}
	
	method equiparArmadura(equipo) {
		inventarioPantalla.remover(equipo)
		if ( self.tieneArmaduraEquipada() ) {
			self.tirarEquipoAReemplazar(self.armaduraEquipada())
		}
		self.armaduraEquipada(equipo)
	}
	
	method guardarObjetoEnLaMochila(objeto){
		inventarioPantalla.remover(objeto)
		mochila.add(objeto)		
	}
	
	method tirarEquipoAReemplazar(equipo) {
		inventarioPantalla.agregarEnPosicionDelPersonaje(self, equipo)
		//self.armaEquipada(null)		
	}
	
	method tieneArmaEquipada() {
		return self.armaEquipada() != null
	}
	
	method tieneArmaduraEquipada() {
		return self.armaduraEquipada() != null
	}
	
	method aprenderHechizo(hechizo){
		libroDeHechizos.add(hechizo) //Agregar hechizo al conjunto
	}
	//############################################################## FIN Mensajes con Equipo
	
	
	//############################################################## Mensajes con Pociones
	method beberPocionVida() {
		if (self.hayPocionDeVida()) {
			self.removerPocionDeLaMochila(self.buscarPocionVidaEnMochila())
			self.incrementarVida()
		}
	}
	
	method beberPocionMana() {
		if (self.hayPocionDeMana()) {
			self.removerPocionDeLaMochila(self.buscarPocionManaEnMochila())
			self.incrementarMana()
		}
	}
	
	method buscarPocionVidaEnMochila() { return self.mochila().find({ pocion => not pocion.esPocionMana() }) }
	
	method buscarPocionManaEnMochila() { return self.mochila().find({ pocion => pocion.esPocionMana() }) }
	
	method hayPocionDeVida() { return self.mochila().any({ pocion => not pocion.esPocionMana() }) }
	
	method hayPocionDeMana() { return self.mochila().any({ pocion => pocion.esPocionMana() }) }
	
	method removerPocionDeLaMochila(pocion) {
		self.mochila().remove(pocion)
	}
	
	//############################################################## FIN Mensajes con Pociones
	
	//############################################################## Mensajes modificadores y de estado
	method incrementarVida() {
		if (self.actualVida() + 50 > self.maxVida()) {
			self.actualVida(self.maxVida())
		} else {
			self.actualVida(self.actualVida() + 50)
		}
	}
	
	method incrementarMana() {
		if (self.actualMana() + 30 > self.maxMana()) {
			self.actualMana(self.maxMana())
		} else {
			self.actualMana(self.actualMana() + 30)
		}
	}
	
	method heroeConVidaMaxima() {
		return self.actualVida() == self.maxVida()
	}
	
	method heroeConManaMaxima() {
		return self.actualMana() == self.maxMana()
	}
	
	method irA(x, y) {

		if (not nivelActual.esPosicionProhibida(game.at(x,y))) {
			position = game.at(x, y)
		}
	}
	
	method modificadorDeAtaque() {return 0}
	
	method modificadorDeDefensa() {return 0}
	
	method danioHeroe() {return armaEquipada.danioArma() * self.modificadorDeAtaque()}
	
	method defensaHeroe() {return armaduraEquipada.defensaArmadura() * self.modificadorDeDefensa()}
	//############################################################## FIN Mensajes modificadores de estado
	
	//############################################################## Mensajes de Combate
	method atacarEnemigo(enemigo) {
		enemigo.recibirDanio(self)
	}
	
	method recibirDanio(enemigo) {
		self.chequearSiyaGano(enemigo)
		self.ejecutarAnimacionAtaque()
		actualVida = (actualVida - self.danioFinalEnemigo(enemigo)).max(0)
	}
	
	method danioFinalEnemigo(enemigo) {
		return if (self.defensaHeroe() >= enemigo.nivelDeDanio()) {
			1
		}else {
			enemigo.nivelDeDanio() - self.defensaHeroe()
		}
	}
	
	method chequearSiyaGano(enemigo) {
		if (actualVida == 0) {
			enemigo.ganar(self)
		}
	}
	
	method ganar(enemigo) {
		inventarioPantalla.remover(enemigo)
	}
	
	method ejecutarAnimacionAtaque() {
		secuenciaAtaque.ejecutar(position)
	}
	
	//############################################################## FIN Mensajes de Combate
}

object warrior inherits Heroe {
	const property image = "warrior.png"
	var property pantalla
	
	method init() {
		self.maxVida(200)
		self.maxMana(50)
		self.actualVida(200)
		self.actualMana(50)
	}
	override method modificadorDeAtaque() {return 1.5}
	override method modificadorDeDefensa() {return 1.1}	
}

object tank inherits Heroe {
	const property image = "tank.png"
	var property pantalla
	
	method init() {
		self.maxVida(250)
		self.maxMana(65)
		self.actualVida(250)
		self.actualMana(65)
	}
	override method modificadorDeAtaque() {return 1.1}
	override method modificadorDeDefensa() {return 1.5}
}

object wizzard inherits Heroe {
	const property image = "wizzard.png"
	var property pantalla
	
	method init() {
		self.maxVida(125)
		self.maxMana(250)
		self.actualVida(125)
		self.actualMana(250)
	}
	override method modificadorDeAtaque() {return 0.8}
	override method modificadorDeDefensa() {return 0.8}
}
/////////////////////////////////////////////////////////////////////////////////
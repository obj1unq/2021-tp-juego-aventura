import hechizos.*
import objetos.*
import wollok.game.*
import niveles.*
import gestorDeObjetos.*

class Heroe {
	var property mochila = #{}
	var property libroDeHechizos = #{}
	var property manoIzquierda = null
	var property cuerpo = null
	var property modificadorAtaque
	var property modificadorDefensa
	var property maxVida
	var property actualVida = 100
	var property maxMana
	var property actualMana = 1000
	
	var property nivelActual 
	var property pantalla
	var property image = null;
	var property position = null;
	
	method tomarObjeto() {
		self.tomarObjetoQueTenesDebajo()
	}
	
	method tomar(objeto) {
        objeto.interactuar(self, objeto)
    }

    method tomarObjetoQueTenesDebajo() {
        self.tomar(self.objetoDebajo())
    }

    method objetoDebajo() {
        const objetos = game.colliders(self)
        if (objetos.isEmpty()) {
            self.error("No hay nada acá")
        }
        return objetos.head()
    }
    
	method equiparArma(equipo) {
		gestorDeObjetos.remover(equipo)
		self.tirarEquipoAReemplazar(self.manoIzquierda())
		self.manoIzquierda(equipo)
	}
	
	method equiparArmadura(equipo) {
		gestorDeObjetos.remover(equipo)
		self.tirarEquipoAReemplazar(self.cuerpo())
		self.cuerpo(equipo)
	}
	
	method guardarObjetoEnLaMochila(objeto){
		gestorDeObjetos.remover(objeto)
		mochila.add(objeto)
	}
	
	method tirarEquipoAReemplazar(equipo) {
		gestorDeObjetos.agregarEnPosicionDelPersonaje(self, equipo)
		self.manoIzquierda(null)		
	}
	
	method aprenderHechizo(hechizo){
		if (not self.libroDeHechizos().contains(hechizo)) { //Si hechizo no esta en el libro
			libroDeHechizos.add(hechizo) //Agregar hechizo al conjunto
		} else {
			self.error("El hechizo ya se encuentra en el libro")
		}
	}
	
//	method beberPocionVida() {
//		if (self.hayPocionEnLaMochila(pocionVida) && (not self.heroeConVidaMaxima())) {
//			self.beberPocion(self.sacarPocion(pocionVida))
//		}
//	}
//	
//	method beberPocionMana() {
//		if (self.hayPocionEnLaMochila(pocionMana) && (not self.heroeConManaMaxima())) {
//			self.beberPocion(pocionMana)
//		}
//	}
	
	method sacarPocion(pocion) {
		self.removerPocionDeLaMochila(pocion)
		return self.mochila(pocion)
	}
	
//	method beberPocion(pocion) {
//		if (pocion == pocionVida) {
//			self.incrementarVida(pocion)
//		} else {
//			self.incrementarMana(pocion)
//		}
//	}
	
	method incrementarVida(pocion) {
		if (self.actualVida() + pocion.potenciaPocion() > self.maxVida()) {
			self.actualVida(self.maxVida())
		} else {
			self.actualVida(self.actualVida() + pocion.potenciaPocion())
		}
	}
	
	method incrementarMana(pocion) {
		if (self.actualMana() + pocion.potenciaPocion() > self.maxMana()) {
			self.actualMana(self.maxMana())
		} else {
			self.actualMana(self.actualMana() + pocion.potenciaPocion())
		}
	}
	
	method hayPocionEnLaMochila(pocion) {
		return self.mochila().contains(pocion)
	}
	
	method removerPocionDeLaMochila(pocion) {
		self.mochila().remove(pocion)
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
	// hay que establecer qué pasa cuando se pierde y cuando se gana
	// atributo pantalla?
	// la pantalla cuando se setea? 
	// si gano siempre deberia mostrar un WIN e ir a la pantalla de seleccion otra vez (con boss)
	// si gano siempre deberia volver al nivel inicial (con enemigos)
	// si pierdo siempre se vuelve a pantalla de seleccion
	
	// deberia crear otra pantalla que seria pantalla de win? en la pantalla de win muestro la imagen y vuelvo a la seleccion
	
	
	method atacar(enemigo) {
		enemigo.recibirDanio(self)
	}
	
	method recibirDanio(enemigo) {
		self.yaGano(enemigo)
		// de donde saco el nivel de fuerza + danio?
		actualVida = (actualVida - enemigo.nivelDeDanio()).max(0)
	}
	
	method yaGano(enemigo) {
		if (actualVida == 0) {
			enemigo.ganar(self)
		}
	}
	
	method ganar(enemigo) {
		gestorDeEnemigos.remover(enemigo)
	}
}

//const Warrior = new Heroe(
//	image = "personajePrincipal.png", 
//	position= game.at(2, 2),
//	nivelActual = nivelInicial,
//	modificadorAtaque = 1.4,
//	modificadorDefensa = 1.1,
//	maxVida = 200,
//	actualVida = 200,
//	maxMana = 30,
//	actualMana = 30
//)
//
//const Tank = new Heroe(
//	image = "personajePrincipal.png", 
//	position= game.at(4, 4), 
//	nivelActual = nivelInicial,
//	modificadorAtaque = 1.1,
//	modificadorDefensa = 1.6,
//	maxVida = 250,
//	actualVida = 250,
//	maxMana = 20,
//	actualMana = 20
//)
//
//const Wizzard = new Heroe(
//	image = "personajePrincipal.png", 
//	position= game.at(2, 4), 
//	nivelActual = nivelInicial,
//	modificadorAtaque = 0.8,
//	modificadorDefensa = 0.9,
//	maxVida = 150,
//	actualVida = 150,
//	maxMana = 100,
//	actualMana = 100
//)
/////////////////////////////////////////////////////////////////////////////////
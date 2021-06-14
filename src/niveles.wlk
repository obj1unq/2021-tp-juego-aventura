import heroes.*
import wollok.game.*
import enemigos.*
import objetos.*
import configuraciones.*
import gestorDeObjetos.*

class Pantalla {

	const property position = game.origin()
	const property image
	;
	var property heroe
	;
	var property cancion

	;
	
	method iniciar() {
		self.terminar()
		gestorDeObjetos.agregar(self)
		self.cargarPantalla()
		self.configurarMecanicas()
		self.setearNivelHeroe()
		radio.cambiarMusica(self.cancion())
	}

	method terminar() {
		game.clear()
	}

	method cargarPantalla()

	method configurarMecanicas() {
		config.configurarColisiones(heroe)
		config.configurarTeclas(heroe)
	}

	method teEncontraron(h) {
	}

	method setearNivelHeroe() {
		heroe.nivelActual(self)
	}

	method posicionesProhibidas() {
		return #{}
	}

	method esPosicionProhibida(posicion) {
		return self.posicionesProhibidas().contains(posicion)
	}

}

object pantallaSeleccion inherits Pantalla {

	var property heroes = [ warrior, tank, wizzard ]

	override method image() = "flechaSeleccion.png"

	override method position() = self.seleccionado().position().down(1)

	override method cargarPantalla() {
		gestorDeObjetos.agregar(warrior)
		gestorDeObjetos.agregar(tank)
		gestorDeObjetos.agregar(wizzard)
		gestorDeObjetos.agregar(self)
	}

	override method iniciar() {
		self.terminar()
		self.reiniciarHeroes()
		self.cargarPantalla()
		self.selccionarHeroe()
		radio.cambiarMusica(self.cancion())
	}

	override method cancion() = musicaInicio

	method seleccionado() = heroes.head()

	method moverDerecha() {
		const seleccionadoActual = self.seleccionado()
		heroes.remove(seleccionadoActual)
		heroes.add(seleccionadoActual)
	}

	method moverIzquierda() {
		const ultimoElemento = heroes.last()
		heroes.remove(ultimoElemento)
		heroes = [ ultimoElemento ] + heroes
	}

	method seleccionar() {
		self.terminar()
		nivelInicial.heroe(self.seleccionado())
		nivelInicial.iniciar()
	}

	method selccionarHeroe() {
		// keyboard.left().onPressDo({ self.moverIzquierda()})
		keyboard.left().onPressDo({ self.moverDerecha()}) // ESTE SERIA EL CORRECTO
			// keyboard.right().onPressDo({ self.moverDerecha()})
		keyboard.right().onPressDo({ self.moverIzquierda()}) // ESTE SERIA EL CORRECTO
		keyboard.enter().onPressDo({ self.seleccionar()})
	}

	method reiniciarHeroes() {
		warrior.actualVida(100)
		warrior.actualMana(100)
		warrior.position(game.at(2, 4))
		wizzard.actualVida(100)
		wizzard.actualMana(100)
		wizzard.position(game.at(4, 4))
		tank.actualVida(100)
		tank.actualMana(100)
		tank.position(game.at(6, 4))
	}

}

/////////////////////////////////////////////////////////////////////////////////
object nivelInicial inherits Pantalla {

	const esqueleto = new Enemigo(image = "enemigo1.png", position = game.at(1, 1))
	;
	const murcielago = new Enemigo(image = "murcielago.png", position = game.at(7, 7))
	;
	const arbolFuego = new Enemigo(image = "arboldefuego.png", position = game.at(2, 6))
	;
	const esqueleto2 = new Enemigo(image = "enemigo1.png", position = game.at(5, 5))
	;
	const esqueleto3 = new Enemigo(image = "enemigo1.png", position = game.at(0, 8))
	;
	const murcielago2 = new Enemigo(image = "murcielago.png", position = game.at(3, 3))
	;
	const murcielago3 = new Enemigo(image = "murcielago.png", position = game.at(8, 0))
	;
	const arbolFuego2 = new Enemigo(image = "arboldefuego.png", position = game.at(5, 2))
	;
	const cofreAzul = new Cofre(imagenCerrado = "Blue CHest Closed.png", imagenAbierto = "Blue Chest Open.png", position = game.at(9, 2))
	const cofreRojo = new Cofre(imagenCerrado = "Red Chest Closed.png", imagenAbierto = "Red Chest Open.png", position = game.at(9, 6))
	const cofreVerde = new Cofre(imagenCerrado = "Green Chest Closed.png", imagenAbierto = "Green Chest Open.png", position = game.at(6.5, 9))
	const cofreAzul2 = new Cofre(imagenCerrado = "Blue CHest Closed.png", imagenAbierto = "Blue Chest Open.png", position = game.at(1, 9))
// walter
	var enemigosIniciales = [ esqueleto, esqueleto2, esqueleto3, murcielago, murcielago2, murcielago3, arbolFuego, arbolFuego2 ]

	;
	
	override method image() = "escenario.png"

	override method cargarPantalla() {
		heroe.position(game.at(0, 0))
		gestorDeObjetos.agregar(heroe)
		enemigosIniciales = if (gestorDeEnemigos.enemigos().isEmpty()) enemigosIniciales else gestorDeEnemigos.enemigos()
		gestorDeObjetos.agregarObjetos([ calavera, cofreAzul, cofreRojo, cofreVerde, cofreAzul2 ])
		gestorDeEnemigos.agregarEnemigos(enemigosIniciales)
		game.addVisual(espada1)
		game.addVisual(hacha1)
		game.addVisual(armadura1)
		game.addVisual(pocionVida)
		game.addVisual(pocionMana)
	}

	override method cancion() = musicaInicio

	override method posicionesProhibidas() {
		return #{ game.at(9,9), game.at(9,8), game.at(9,8), game.at(9,8), game.at(8,8), game.at(7,9), game.at(7,8), game.at(7,8) }
	}

}

/////////////////////////////////////////////////////////////////////////////////
object pantallaPelea inherits Pantalla {

	var property enemigo

	;
	
	override method image() = "black.png"

	override method cargarPantalla() {
		enemigo.position(game.at(6, 6))
		heroe.position(game.at(2, 2))
		gestorDeObjetos.agregar(new Objeto(position = game.at(6, 1), image = "menuOpciones.png"))
		gestorDeObjetos.agregar(enemigo)
		gestorDeObjetos.agregar(heroe)
		gestorDeObjetos.agregar(new Vida(personaje = enemigo))
		gestorDeObjetos.agregar(new Vida(personaje = heroe))
		gestorDeObjetos.agregar(new Mana(personaje = heroe))
	}

	override method configurarMecanicas() {
		configPelea.enemigo(enemigo)
		configPelea.configurarTeclas(heroe)
	}

}

object pantallaCaminoAlBoss inherits Pantalla {

	var property enemigo = gestorDeEnemigos.boss()

	;
	
	override method image() = "camino_al_boss.png"

	override method cargarPantalla() {
		enemigo.position(game.at(8, 4))
		heroe.position(game.origin())
		gestorDeObjetos.agregar(enemigo)
		gestorDeObjetos.agregar(heroe)
	}

	override method cancion() = musicaEnemigo

	override method posicionesProhibidas() {
		return #{ game.at(0,5), game.at(2,0), game.at(2,1), game.at(2,2), game.at(6,6), game.at(1,5), game.at(1,6), game.at(2,7), game.at(3,7), game.at(4,6), game.at(5,6), game.at(7,6), game.at(8,6), game.at(8,5), game.at(7,6), game.at(7,7), game.at(8,8), game.at(9,8), game.at(3,0), game.at(3,1), game.at(3,2), game.at(4,2), game.at(4,3), game.at(5,3), game.at(6,3), game.at(7,2), game.at(8,1), game.at(9,1), game.at(9,5), game.at(9,6) }
	}

}


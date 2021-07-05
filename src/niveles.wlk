import heroes.*
import wollok.game.*
import enemigos.*
import objetos.*
import configuraciones.*
import gestorDeObjetos.*

class Pantalla {

	const property position = game.origin()
	const property image
	var property heroe
	var property cancion
	
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
		self.seleccionado().init()
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
		warrior.init()
		warrior.position(game.at(2, 4))
		wizzard.init()
		wizzard.position(game.at(4, 4))
		tank.init()
		tank.position(game.at(6, 4))
	}

}

/////////////////////////////////////////////////////////////////////////////////
object nivelInicial inherits Pantalla {

	const esqueleto = new Enemigo(image = "enemigo1.png", position = game.at(1, 1))
	const murcielago = new Enemigo(image = "murcielago.png", position = game.at(7, 7))
	const arbolFuego = new Enemigo(image = "arboldefuego.png", position = game.at(2, 6))
	const esqueleto2 = new Enemigo(image = "enemigo1.png", position = game.at(5, 5))
	const esqueleto3 = new Enemigo(image = "enemigo1.png", position = game.at(0, 8))
	const murcielago2 = new Enemigo(image = "murcielago.png", position = game.at(3, 3))
	const murcielago3 = new Enemigo(image = "murcielago.png", position = game.at(8, 0))
	const arbolFuego2 = new Enemigo(image = "arboldefuego.png", position = game.at(5, 2))
	const cofreAzul = new Cofre(imagenCerrado = "Blue CHest Closed.png", imagenAbierto = "Blue Chest Open.png", position = game.at(9, 2), image = null)
	const cofreRojo = new Cofre(imagenCerrado = "Red Chest Closed.png", imagenAbierto = "Red Chest Open.png", position = game.at(9, 6), image = null)
	const pocionVida = new Pocion(esPocionMana = false, position = game.at(3, 5), image = "potionGreen.png")
	const pocionVida2 = new Pocion(esPocionMana = false, position = game.at(4, 7), image = "potionGreen.png")
	const pocionVida3 = new Pocion(esPocionMana = false, position = game.at(4, 0), image = "potionGreen.png")
	const pocionMana = new Pocion(esPocionMana = false, position = game.at(5, 4), image = "potionBlue.png")
	const armaduraOro = new Armadura(defensaArmadura = 10, position = game.at(1, 4), image = "armaduraoro.png")
	const armaduraPlata = new Armadura(defensaArmadura = 7, position = game.at(9, 4), image = "armaduraplata.png")
	const armaduraBronce = new Armadura(defensaArmadura = 4, position = game.at(6, 1), image =  "armadurabronce.png")
	const armaEspada = new Arma(danioArma = 15, position = game.at(1, 5), image = "espada.png")
	const armaHacha = new Arma(danioArma = 12, position = game.at(9, 3), image = "hacha.png")
	
	var objetosIniciales = [ armaduraOro, armaduraPlata, armaduraBronce, pocionVida, pocionVida2, pocionVida3, pocionMana, calavera, cofreAzul, cofreRojo, esqueleto, esqueleto2, esqueleto3, murcielago, murcielago2, murcielago3, arbolFuego, arbolFuego2, armaEspada, armaHacha ]

	override method image() = "escenario.png"

	override method cargarPantalla() {
		heroe.position(inventarioPantalla.ultimaPosicionHeroe())
		gestorDeObjetos.agregar(heroe)
		objetosIniciales = if (inventarioPantalla.objetos().isEmpty()) objetosIniciales else inventarioPantalla.objetos()
		inventarioPantalla.agregarObjetos(objetosIniciales)
		gestorDeObjetos.agregar(new Vida(personaje = heroe, position=game.at(3,9), image = null))
		gestorDeObjetos.agregar(new Mana(personaje = heroe, position=game.at(8, 9), image = null))
	}

	override method cancion() = musicaInicio

	override method posicionesProhibidas() {
		return #{ game.at(9,9), game.at(9,8), game.at(9,8), game.at(9,8), game.at(8,8), game.at(7,9), game.at(7,8), game.at(7,8) }
	}

}

/////////////////////////////////////////////////////////////////////////////////
object pantallaPelea inherits Pantalla {

	var property enemigo

	override method  image() = "escenarioPelea.png"
	
	override method cargarPantalla() {
		enemigo.position(game.at(6, 6))
		heroe.position(game.at(2, 3))
		gestorDeObjetos.agregar(new Objeto(position = game.at(6, 1), image = "menuOpciones.png"))
		gestorDeObjetos.agregar(enemigo)
		gestorDeObjetos.agregar(heroe)
		gestorDeObjetos.agregar(new Vida(personaje = enemigo, position=game.at(6, 5), image = null))
		gestorDeObjetos.agregar(new Vida(personaje = heroe, position=game.at(2, 2), image = null))
		gestorDeObjetos.agregar(new Mana(personaje = heroe, position=game.at(2, 1), image = null))
	}

	override method configurarMecanicas() {
		configPelea.enemigo(enemigo)
		configPelea.configurarTeclas(heroe)
	}

}

object pantallaCaminoAlBoss inherits Pantalla {

	var property enemigo = inventarioPantalla.boss()
	
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
import heroes.*
import wollok.game.*
import enemigos.*
import objetos.*
import configuraciones.*
import gestorDeObjetos.*

object pantallaSeleccion {

	var property heroes = [ Warrior, Tank, Wizzard ]
	const property image = "flechaSeleccion.png"

	method seleccionado() = heroes.head()

	method position() = self.seleccionado().position().down(1)

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
		game.clear()
		nivelInicial.iniciar(self.seleccionado())
	}

	method selccionarHeroe() {
		keyboard.left().onPressDo({ self.moverIzquierda()})
		keyboard.right().onPressDo({ self.moverDerecha()})
		keyboard.enter().onPressDo({ self.seleccionar()})
	}
	
	method cargarPantalla() {
		gestorDeObjetos.agregar(Warrior)
		gestorDeObjetos.agregar(Tank)
		gestorDeObjetos.agregar(Wizzard)
		gestorDeObjetos.agregar(self)
	}
	
	method iniciar() {
		self.cargarPantalla()
		self.selccionarHeroe()
	}

}
/////////////////////////////////////////////////////////////////////////////////
object nivelInicial {
	
	method iniciar(heroe) {
		self.cargarPantalla(heroe)
		self.agregarObjetosIniciales(heroe)
		self.configurarMecanicas(heroe)
	}
	
	method cargarPantalla(heroe) {
		//game.boardGround("escenario.png")
		gestorDeObjetos.agregar(escenarioPrincipal)
		gestorDeObjetos.agregar(heroe)
	}

	method agregarObjetosIniciales(heroe) {
		const esqueleto = new Enemigo(
			image = "enemigo1.png", 
			position= game.at(heroe.position().x().max(3), 0));
			
		const murcielago = new Enemigo(
			image = "murcielago.png", 
			position= game.at(heroe.position().x().max(6), 3));
			
		const arbolFuego = new Enemigo(
			image = "arboldefuego.png", 
			position= game.at(heroe.position().x().max(6), 6));
			
		const cofreAzul = new Cofre(
			imagenCerrado = "Blue CHest Closed.png",
			imagenAbierto ="Blue Chest Open.png", 
			position= game.at(9,2))
			
		const cofreRojo = new Cofre(
			imagenCerrado = "Red Chest Closed.png",
			imagenAbierto = "Red Chest Open.png",
			position= game.at(9,6))
			
		const cofreVerde = new Cofre(
			imagenCerrado = "Green Chest Closed.png",
			imagenAbierto = "Green Chest Open.png",
			position= game.at(6.5,9))
			
		const cofreAzul2 = new Cofre(
			imagenCerrado = "Blue CHest Closed.png",
			imagenAbierto = "Blue Chest Open.png",
			position= game.at(1,9))
			
		gestorDeObjetos.agregar(esqueleto)
		gestorDeObjetos.agregar(murcielago)
		gestorDeObjetos.agregar(arbolFuego)
		gestorDeObjetos.agregar(cofreAzul)
		gestorDeObjetos.agregar(cofreRojo)
		gestorDeObjetos.agregar(cofreVerde)
		gestorDeObjetos.agregar(cofreAzul2)
	}

	method configurarMecanicas(heroe) {
		config.configurarTeclas(heroe)
		config.configurarColisiones(heroe)
	}

	method terminar() {
		game.clear()
	}
}
/////////////////////////////////////////////////////////////////////////////////
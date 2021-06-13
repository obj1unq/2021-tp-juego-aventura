import wollok.game.*
import niveles.*
import objetos.*
import gestorDeObjetos.*

class Enemigo {
	
	var property image;
	var property position;
	var property nivelDeDanio = 10;
	var property actualVida = 100;

	method teEncontraron(heroe) {
		pantallaPelea.cancion(musicaEnemigo)
		pantallaPelea.enemigo(self)
		pantallaPelea.heroe(heroe)
		pantallaPelea.iniciar()
	}	
	
	method atacar(heroe) {
		heroe.recibirDanio(self)
	}
	
	method secuenciaDeAtaques(heroe) {
		game.onTick(1000, "ATAQUE_ENEMIGO", {self.atacar(heroe)})
	}
	
	method recibirDanio(heroe) {
		if (actualVida == 0) {
			heroe.ganar(self)
			self.cambioPantalla(heroe)
		} else {
			// heroe.nivelDanio()
			actualVida = (actualVida - 20).max(0)
			game.schedule(300,{heroe.recibirDanio(self)})
		}
		
	}
	
	// cuando el enemigo gana, claramente el heroe pierde
	// el enemigo debe saber en que pantalla se esta para poder terminarlo (pantalla de pelea con boss vs con enemigo comun)
	// el enemigo debe saber cual es la pantalla siguiente si es que pierde (enemigo comun = pantalla inicial vs enemigo boss = pantalla seleccion)

	method ganar(heroe) {
		self.terminar("perdiste.png")
	}
	
	method cambioPantalla(heroe) {
		nivelInicial.heroe(heroe)
		nivelInicial.iniciar()
	}
	
	method terminar(escenario) {
		game.clear()
		gestorDeObjetos.agregar(new Objeto(position = game.origin(), image = escenario))
		game.schedule(3000, { => game.stop()})
	}
}

class Boss inherits Enemigo {
	
	override method cambioPantalla(heroe) {
		self.terminar("ganaste.png")
	}
	
	override method teEncontraron(heroe) {
		pantallaPelea.cancion(musicaBoss)
		pantallaPelea.enemigo(self)
		pantallaPelea.heroe(heroe)
		pantallaPelea.iniciar()
	}
}
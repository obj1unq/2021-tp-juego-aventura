import wollok.game.*
import niveles.*
import objetos.*
import gestorDeObjetos.*

class Enemigo {
	
	var property image;
	var property position;
	var property nivelDeDanio = 20;
	var property actualVida = 100;
	var property maxVida = 100
	const secuenciaAtaque = new AnimacionAtaque()

	method teEncontraron(heroe) {
		pantallaPelea.cancion(musicaEnemigo)
		pantallaPelea.enemigo(self)
		pantallaPelea.heroe(heroe)
		inventarioPantalla.ultimaPosicionHeroe(heroe.position())
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
			self.ejecutarAnimacionAtaque()
			actualVida = (actualVida - heroe.danioHeroe()).max(0)
			game.schedule(300,{heroe.recibirDanio(self)})
		}
	}

	method ganar(heroe) {
		self.terminar("perdiste.png")
	}
	
	method cambioPantalla(heroe) {
		nivelInicial.heroe(heroe)
		nivelInicial.iniciar()
	}
	
	method terminar(escenario) {
		game.schedule(200, { => 
			game.clear() 
			gestorDeObjetos.agregar(new Objeto(position = game.origin(), image = escenario))
			game.schedule(3000, { => game.stop()})
		})
		
	}
	
	method ejecutarAnimacionAtaque() {
		secuenciaAtaque.ejecutar(position)
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
	
	override method ejecutarAnimacionAtaque() {
		secuenciaAtaque.ejecutar(game.at(position.x(), position.y() + 1))
	}
}
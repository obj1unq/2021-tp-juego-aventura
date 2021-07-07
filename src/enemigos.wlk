import wollok.game.*
import niveles.*
import objetos.*
import gestorDeObjetos.*

class Enemigo {
	
	var property image;
	var property position;
	var property nivelDeDanio = 10;
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
	
	method recibirDanioSiCorresponde(heroe) {
		if (self.llegoVidaACero()) {
			self.heroeGanaYSecambiaPantalla(heroe)
		} else {
			self.recibirDanioYContraatacar(heroe)
		}
	}
	
	method llegoVidaACero() {
		return actualVida == 0
	}
	
	method recibirDanioYContraatacar(heroe) {
		self.recibirDanio(heroe)
		game.schedule(300,{self.atacar(heroe)})
	}
	
	method recibirDanio(heroe) {
		self.ejecutarAnimacionAtaque()
		actualVida = (actualVida - heroe.danioHeroe()).max(0)
	}
	
	method ganar(heroe) {
		self.terminar("perdiste.png")
	}
	
	method heroeGanaYSecambiaPantalla(heroe) {
		heroe.ganar(self)
		self.cambioPantalla(heroe)
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
	
	method recibirDanioHechizo(heroe, danio) {
		if (self.llegoVidaACero()) {
			self.heroeGanaYSecambiaPantalla(heroe)
		} else {
			self.ejecutarAnimacionAtaque()
			actualVida = (actualVida - danio).max(0)
		}
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
	
	override method nivelDeDanio() {
		return 20;
	}
}
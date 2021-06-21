import wollok.game.*
import niveles.*
import gestorDeObjetos.*

class Arma {

	var property danioArma
	var property position
	method image() 

	method teEncontraron(heroe) {
	}

	method interactuar(heroe) {
		heroe.equiparArma(self)
	}
}

class Espada inherits Arma {

	override method image() {
		return "espada.png"
	}

}

class Hacha inherits Arma {

	override method image() {
		return "hacha.png"
	}

}

/////////////////////////////////////////////////////////////////////////////////
class Armadura {

	var property position
	const  defensaArmadura = 0
	

	method image() 
		

	method defensaDeArmadura() {
		return defensaArmadura
	}

	method teEncontraron(heroe) {
	}

	method interactuar(heroe) {
		heroe.equiparArmadura(self)
	}

}
class ArmaduraDeBronce inherits Armadura{
	
	 override method image() {
		return "armadurabronce.png"
	}
	override method defensaDeArmadura() {
		return 100
	}
}
class ArmaduraDePlata inherits Armadura{
	
	 override method image() {
		return "armaduraplata.png"
	}
	override method defensaDeArmadura() {
		return 200
	}
}
class ArmaduraDeOro inherits Armadura{
	
	 override method image() {
		return "armaduraoro.png"
	}
	override method defensaDeArmadura() {
		return 500
	}
}




/////////////////////////////////////////////////////////////////////////////////|
class Pocion {

	var property position
	method image()

	method teEncontraron(heroe) {
	}

	method interactuar(heroe) {
		heroe.guardarObjetoEnLaMochila(self)
	}

}

class PocionVida inherits Pocion {

	override method image() {
		return "potionGreen.png"
	}

}

class PocionMana inherits Pocion {

	override method image() {
		return "potionBlue.png"
	}

}

/////////////////////////////////////////////////////////////////////////////////
class Cofre {

	var property position
	var property imagenAbierto
	var property imagenCerrado
	var property estaAbierto = false

	method image() {
		return if (estaAbierto) imagenAbierto else imagenCerrado
	}

	method teEncontraron(heroe) {
		estaAbierto = true
	}

}

/////////////////////////////////////////////////////////////////////////////////
class Objeto {

	var property position
	var property image
	
	method teEncontraron(heroe) {
	}

}

object calavera {

	var property position = game.at(8, 7)

	method image() {
		return "Skull.png"
	}

	method teEncontraron(heroe) {
		pantallaCaminoAlBoss.heroe(heroe)
		pantallaCaminoAlBoss.iniciar()
	}

}

class Barra {
	
 	const personaje
	
	method position()
	
	method image()
	
	method imagenAMostrar(tipo, numero) {
		return tipo + numero + ".png"
	} 
	
	method porcentaje(numActual, maxNum) {
		return numActual * 100 / maxNum
	}
	
	method numeroDeImagen(porcentaje) {
		return if (porcentaje >= 88) "01" 
		else if (porcentaje.between(77, 87)) "02" 
		else if (porcentaje.between(65, 76)) "03" 
		else if (porcentaje.between(53, 64)) "04" 
		else if (porcentaje.between(41, 52)) "05" 
		else if (porcentaje.between(29, 40)) "06" 
		else if (porcentaje.between(1, 28)) "07" 
		else if (porcentaje == 0) "08"
	}
}

class Vida inherits Barra { 

	override method position() {
		return personaje.position().down(1)
	}

	override method image() {
		return self.imagenAMostrar("vida_", self.numeroSegunPorcentajeVida())
	}

	method numeroSegunPorcentajeVida() {
		return self.numeroDeImagen(self.porcentaje(personaje.actualVida(), personaje.maxVida()))
	}
}

class Mana inherits Barra {

	override method position() {
		return personaje.position().down(2)
	}

	override method image() {
		return self.imagenAMostrar("mana_", self.numeroSegunPorcentajeMana())
	}

	method numeroSegunPorcentajeMana() {
		return self.numeroDeImagen(self.porcentaje(personaje.actualMana(), personaje.maxMana()))
	}
}

object radio {

	var cancion = musicaInicio.sonido()

	method iniciar() {
		self.configuracion()
		game.schedule(20, { cancion.play()}) // cambie el tiempo de arranque
	}

	method reproducir() {
		if (self.estaPausada()) {
			cancion.resume()
		} else {
			cancion.play()
		}
	}

	method configuracion() {
		cancion.shouldLoop(true)
		cancion.volume(0.2)
	}

	method cambiarMusica(sonido) {
		if (self.estaSonando()) {
			if (self.hayCambioDeMusica(sonido)) {
				cancion.pause()
				cancion = sonido.sonido()
				self.configuracion()
				self.reproducir()
			}
		} else {
			self.iniciar()
		}
	}

	method hayCambioDeMusica(musica) {
		return cancion != musica.sonido()
	}

	method estaSonando() {
		return cancion.played()
	}

	method estaPausada() {
		return self.estaSonando() && cancion.paused()
	}

}

object musicaInicio {

	const property sonido = game.sound("musicaInicio.mp3")

}

object musicaEnemigo {

	const property sonido = game.sound("musicaEnemigo.mp3")

}

object musicaBoss {

	const property sonido = game.sound("musicaBoss.wav")

}

class AnimacionAtaque {
	
	var property image = "hit_1.png"
	var property position = game.origin();
	
	method ejecutar(posicion) {
		position = posicion
		self.agregarVisualSiCorresponde()
		 game.onTick(300,"recibir_danio", {
		 	self.hit()
		 	self.removerAnimacion()
  		})
	}
	
	method agregarVisualSiCorresponde() {
		if (not self.estaVisualEnJuego()) gestorDeObjetos.agregar(self)
	}
	
	method removerVisualSiCorresponde() {
		if (self.estaVisualEnJuego()) gestorDeObjetos.remover(self)
	}
	
	method estaVisualEnJuego() {
		return game.hasVisual(self)
	}
	
	method removerAnimacion() {
		game.schedule(200, {
	    		game.removeTickEvent("recibir_danio")
	    		self.removerVisualSiCorresponde()
	    		})
	}
	
	method hit() {
		if (image == "hit_2.png") {
			image = "hit_1.png"
		} else {
			image = "hit_2.png"
		}
	}
}
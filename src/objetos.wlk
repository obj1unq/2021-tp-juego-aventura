import wollok.game.*
import niveles.*

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
	;
	var property imagenAbierto
	;
	var property imagenCerrado
	;
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

	const property position
	;
	const property image

	;
	
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

class Vida {

	const personaje

	method position() {
		return personaje.position().down(1)
	}

	method image() {
		return "vida_" + self.imagenAMostrar() + ".png"
	;
	}

	method imagenAMostrar() {
		const vidaActual = personaje.actualVida()
		return if (vidaActual >= 88) "01" else if (vidaActual.between(77, 87)) "02" else if (vidaActual.between(65, 76)) "03" else if (vidaActual.between(53, 64)) "04" else if (vidaActual.between(41, 52)) "05" else if (vidaActual.between(29, 40)) "06" else if (vidaActual.between(1, 28)) "07" else if (vidaActual == 0) "08"
	}

}

class Mana {

	const personaje

	method position() {
		return personaje.position().down(2)
	}

	method image() {
		return "mana_" + self.imagenAMostrar() + ".png"
	}

	method imagenAMostrar() {
		const manaActual = personaje.actualMana()
		return if (manaActual >= 88) "01" else if (manaActual.between(77, 87)) "02" else if (manaActual.between(65, 76)) "03" else if (manaActual.between(53, 64)) "04" else if (manaActual.between(41, 52)) "05" else if (manaActual.between(29, 40)) "06" else if (manaActual.between(1, 28)) "07" else if (manaActual == 0) "08"
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


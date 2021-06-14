import wollok.game.*
import niveles.*

object espada1 {

	const property position = game.at(0, 3)
	const property danioArma = 120

	method image() {
		return "espada.png"
	}

	method teEncontraron(heroe) {
		self.interactuar(heroe)
	}

	method danioDeArma() {
		return danioArma
	}

	method interactuar(heroe) {
		heroe.guardarObjetoEnLaMochila(self)
	}

}

//////////////////////////////////////////////////////////////////////
object hacha1 {

	const property position = game.at(3, 0)
	const property danioArma = 130

	method teEncontraron(heroe) {
		self.interactuar(heroe)
	}

	method interactuar(heroe) {
		heroe.guardarObjetoEnLaMochila(self)
	}

	method image() {
		return "hacha.png"
	}

	method danioDeArma() {
		return danioArma
	}

}

/////////////////////////////////////////////////////////////////////////////////
object armadura1 {

	const property position = game.at(2, 3)
	const property defensaArmadura = 200

	method image() {
		return "armadura.png"
	}

	method defensaDeArmadura() {
		return defensaArmadura
	}

	method teEncontraron(heroe) {
		self.interactuar(heroe)
	}

	method interactuar(heroe) {
		heroe.guardarObjetoEnLaMochila(self)
	}

}


object pocionVida {

	const property position = game.at(7, 5)

	method image() {
		return "potionGreen.png"
	}

	method teEncontraron(heroe) {
		self.interactuar(heroe)
	}

	method interactuar(heroe) {
		heroe.guardarObjetoEnLaMochila(self)
	}

}
object pocionMana {

	const property position = game.at(6, 3)

	method image() {
		return "potionBlue.png"
	}

	method teEncontraron(heroe) {
		self.interactuar(heroe)
	}

	method interactuar(heroe) {
		heroe.guardarObjetoEnLaMochila(self)
	}

}

/////////////////////////////////////////////////////////////////////////////////
//class Pocion {
//
//	const property nombrePocion
//	const property tipoPocion
//	const property potenciaPocion
//	var property image
//	;
//	var property position
//
//	;
//	
//	method nombrePocion() {
//		return nombrePocion
//	}
//
//	method tipoPocion() {
//		return tipoPocion
//	}
//
//	method potenciaPocion() {
//		return potenciaPocion
//	}
//
//	method interactuar(heroe, objeto) {
//		heroe.guardarObjetoEnLaMochila(objeto)
//	}
//
//}
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


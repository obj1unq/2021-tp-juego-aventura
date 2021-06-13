import wollok.game.*
import niveles.*

class Arma {
	const property nombreArma
	const property danioArma
	const property tipoArma
	var property image;
	var property position;
	
	method nombreDeArma() {return nombreArma}
	method danioDeArma() {return danioArma}
	method tipoDeArma() {return tipoArma}
	method interactuar(heroe, arma) {heroe.equiparArma(arma)}
}

// Defino algunas armas , incluida el arma equipada al inicio del juego
//const punio = new Arma(
//	nombreArma = "Puños",
//	danioArma  = 1,
//	tipoArma   = "mano",
//	image     = "",
//	position = game.at(1,1)
//)
//
//const dagaInicial = new Arma(
//	nombreArma = "Daga Noob",
//	danioArma  = 4,
//	tipoArma   = "daga",
//	image      = "",
//	position   = game.at(2,2)
//)
//
//const dagaCopada = new Arma(
//	nombreArma = "Daga Copada",
//	danioArma  = 7,
//	tipoArma   = "daga",
//	image      = "", 
//	position   = game.at(3,3)
//)
//
//const espadaUnaMano = new Arma(
//	nombreArma = "Espada De Una Mano",
//	danioArma  = 10,
//	tipoArma   = "espada",
//	image      = "",
//	position   = game.at(4,4)
//)
/////////////////////////////////////////////////////////////////////////////////
class Armadura {
	const property nombreArmadura
	const property defensaArmadura
	const property tipoArmadura
	var property image;
	var property position;
	
	method nombreDeArmadura() {return nombreArmadura}
	method defensaDeArmadura() {return defensaArmadura}
	method tipoDeArmadura() {return tipoArmadura}
	method interactuar(heroe, armadura) {heroe.equiparArmadura(armadura)}
}

// Defino algunas armaduras, incluido el trapo de armadura al inicio del juego xD
//const armaduraInicial = new Armadura(
//	nombreArmadura  = "Trapo Andrajoso",
//	defensaArmadura = 0,
//	tipoArmadura    = "completa",
//	image          = "",
//	position = game.at(1,1)
//)
//
//const pecheraDePlacas = new Armadura(
//	nombreArmadura  = "Pechera De Placas",
//	defensaArmadura = 25,
//	tipoArmadura    = "pecho",
//	image           = "",
//	position 		= game.at(2,2)
//)
//
//const piernasDePlacas = new Armadura(
//	nombreArmadura  = "Pantalon De Placas",
//	defensaArmadura = 15,
//	tipoArmadura    = "pierna",
//	image           = "",
//	position 		= game.at(3,3)
//)
//
//const cascoDePlacas = new Armadura(
//	nombreArmadura  = "Casco De Placas",
//	defensaArmadura = 20,
//	tipoArmadura    = "cabeza",
//	image           = "",
//	position 		= game.at(4,4)
//)
/////////////////////////////////////////////////////////////////////////////////
class Pocion {
	const property nombrePocion
	const property tipoPocion
	const property potenciaPocion
	var property image;
	var property position;
	
	method nombrePocion() {return nombrePocion}
	method tipoPocion() {return tipoPocion}
	method potenciaPocion() {return potenciaPocion}
	method interactuar(heroe, objeto) {heroe.guardarObjetoEnLaMochila(objeto)}
}
 // Defino algunas pociones
//const pocionVida = new Pocion(
//	nombrePocion = "Pocion de Vida",
//	tipoPocion   = "vida",
//	potenciaPocion = 25,
//	image  		   = "",
//	position 	   = game.at(1,1)
//)
//
//const pocionMana = new Pocion(
//	nombrePocion = "Pocion de Mana",
//	tipoPocion = "mana",
//	potenciaPocion = 15,
//	image = "",
//	position = game.at(2,2)
//)
/////////////////////////////////////////////////////////////////////////////////
class Cofre {
	var property position;
	var property imagenAbierto;
	var property imagenCerrado;
	var property estaAbierto = false
	
	method image() {
		return if (estaAbierto) imagenAbierto else imagenCerrado
	}
	
	method teEncontraron(heroe) {
		estaAbierto = true;
	}
}
/////////////////////////////////////////////////////////////////////////////////
class Objeto {
	const property position;
	const property image;
	
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

class Vida{
	const personaje

	method position(){
		return personaje.position().down(1)
	}
	
	method image(){
		return "vida_" + self.imagenAMostrar() + ".png" ;
	}
	
	method imagenAMostrar() {
		const vidaActual = personaje.actualVida()
		return if (vidaActual >= 88) "01"
				else if (vidaActual.between(77, 87)) "02"
				else if (vidaActual.between(65, 76)) "03"
				else if (vidaActual.between(53, 64)) "04"
				else if (vidaActual.between(41, 52)) "05"
				else if (vidaActual.between(29, 40)) "06"
				else if (vidaActual.between(1, 28)) "07"
				else if (vidaActual == 0) "08"
	}
	
}

class Mana {
	const personaje

	method position(){
		return personaje.position().down(2)
	}
	
	method image(){
		return "mana_" + self.imagenAMostrar() + ".png" 
	}
	
	method imagenAMostrar() {
		const manaActual = personaje.actualMana()
		return if (manaActual >= 88) "01"
				else if (manaActual.between(77, 87)) "02"
				else if (manaActual.between(65, 76)) "03"
				else if (manaActual.between(53, 64)) "04"
				else if (manaActual.between(41, 52)) "05"
				else if (manaActual.between(29, 40)) "06"
				else if (manaActual.between(1, 28)) "07"
				else if (manaActual == 0) "08"
	}
} 

object radio {
	
	var cancion = musicaInicio.sonido()
	
	method iniciar(){
		self.configuracion()
		game.schedule(100, {cancion.play()})
	}
	
	method reproducir() {	
		if(self.estaPausada()){	
			cancion.resume()	
		}else{	
			cancion.play()	
		}	
	}
	
	method configuracion() {
		cancion.shouldLoop(true)
		cancion.volume(0.2)
	}
	
	method cambiarMusica(sonido){
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
	
	method estaSonando(){
		return cancion.played()
	}
	
	method estaPausada(){	
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
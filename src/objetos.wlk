import wollok.game.*

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
const punio = new Arma(
	nombreArma = "Puños",
	danioArma  = 1,
	tipoArma   = "mano",
	image     = "",
	position = game.at(1,1)
)

const dagaInicial = new Arma(
	nombreArma = "Daga Noob",
	danioArma  = 4,
	tipoArma   = "daga",
	image      = "",
	position   = game.at(2,2)
)

const dagaCopada = new Arma(
	nombreArma = "Daga Copada",
	danioArma  = 7,
	tipoArma   = "daga",
	image      = "", 
	position   = game.at(3,3)
)

const espadaUnaMano = new Arma(
	nombreArma = "Espada De Una Mano",
	danioArma  = 10,
	tipoArma   = "espada",
	image      = "",
	position   = game.at(4,4)
)
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
const armaduraInicial = new Armadura(
	nombreArmadura  = "Trapo Andrajoso",
	defensaArmadura = 0,
	tipoArmadura    = "completa",
	image          = "",
	position = game.at(1,1)
)

const pecheraDePlacas = new Armadura(
	nombreArmadura  = "Pechera De Placas",
	defensaArmadura = 25,
	tipoArmadura    = "pecho",
	image           = "",
	position 		= game.at(2,2)
)

const piernasDePlacas = new Armadura(
	nombreArmadura  = "Pantalon De Placas",
	defensaArmadura = 15,
	tipoArmadura    = "pierna",
	image           = "",
	position 		= game.at(3,3)
)

const cascoDePlacas = new Armadura(
	nombreArmadura  = "Casco De Placas",
	defensaArmadura = 20,
	tipoArmadura    = "cabeza",
	image           = "",
	position 		= game.at(4,4)
)
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
const pocionVida = new Pocion(
	nombrePocion = "Pocion de Vida",
	tipoPocion   = "vida",
	potenciaPocion = 25,
	image  		   = "",
	position 	   = game.at(1,1)
)

const pocionMana = new Pocion(
	nombrePocion = "Pocion de Mana",
	tipoPocion = "mana",
	potenciaPocion = 15,
	image = "",
	position = game.at(2,2)
)
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
object escenarioPrincipal {
	var property position = game.origin()
	
	method image() {
		return "escenario.png"
	}
	
	method teEncontraron(heroe) {
	}
}

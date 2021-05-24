import wollok.game.*

class Arma {
	const property nombreArma
	const property danioArma
	const property tipoArma
	const property tipoGeneral
	const property imagen
	
	method nombreDeArma() {return nombreArma}
	method danioDeArma() {return danioArma}
	method tipoDeArma() {return tipoArma}
	method tipoGeneral() {return tipoGeneral}
}

// Defino algunas armas , incluida el arma equipada al inicio del juego
const punio = new Arma(
	nombreArma = "Puños",
	danioArma  = 1,
	tipoArma   = "mano",
	tipoGeneral = "equipo",
	imagen     = ""
)

const dagaInicial = new Arma(
	nombreArma = "Daga Noob",
	danioArma  = 4,
	tipoArma   = "daga",
	tipoGeneral = "equipo",
	imagen     = ""
)

const dagaCopada = new Arma(
	nombreArma = "Daga Copada",
	danioArma  = 7,
	tipoArma   = "daga",
	tipoGeneral = "equipo",
	imagen     = ""
)

const espadaUnaMano = new Arma(
	nombreArma = "Espada De Una Mano",
	danioArma  = 10,
	tipoArma   = "espada",
	tipoGeneral = "equipo",
	imagen     = ""
)
/////////////////////////////////////////////////////////////////////////////////
class Armadura {
	const property nombreArmadura
	const property defensaArmadura
	const property tipoArmadura
	const property tipoGeneral
	const property imagen
	
	method nombreDeArmadura() {return nombreArmadura}
	method defensaDeArmadura() {return defensaArmadura}
	method tipoDeArmadura() {return tipoArmadura}
	method tipoGeneral() {return tipoGeneral}
}

// Defino algunas armaduras, incluido el trapo de armadura al inicio del juego xD
const armaduraInicial = new Armadura(
	nombreArmadura  = "Trapo Andrajoso",
	defensaArmadura = 0,
	tipoArmadura    = "completa",
	tipoGeneral = "equipo",
	imagen          = ""
)

const pecheraDePlacas = new Armadura(
	nombreArmadura  = "Pechera De Placas",
	defensaArmadura = 25,
	tipoArmadura    = "pecho",
	tipoGeneral = "equipo",
	imagen          = ""
)

const piernasDePlacas = new Armadura(
	nombreArmadura  = "Pantalon De Placas",
	defensaArmadura = 15,
	tipoArmadura    = "pierna",
	tipoGeneral = "equipo",
	imagen          = ""
)

const cascoDePlacas = new Armadura(
	nombreArmadura  = "Casco De Placas",
	defensaArmadura = 20,
	tipoArmadura    = "cabeza",
	tipoGeneral = "equipo",
	imagen          = ""
)
/////////////////////////////////////////////////////////////////////////////////
class Pocion {
	const property nombrePocion
	const property tipoPocion
	const property potenciaPocion
	const property tipoGeneral
}
 // Defino algunas pociones
const pocionVida = new Pocion(
	nombrePocion = "Pocion de Vida",
	tipoPocion = "vida",
	tipoGeneral = "pocion",
	potenciaPocion = 25
)

const pocionMana = new Pocion(
	nombrePocion = "Pocion de Mana",
	tipoPocion = "mana",
	tipoGeneral = "pocion",
	potenciaPocion = 15
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

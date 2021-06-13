import wollok.game.*

class Hechizo {
	const property nombreHechizo
	const property poderHechizo
	const property costoHechizo
	const property tipoHechizo
	var property image
	var property position
	
	method nombreDelHechizo() {return nombreHechizo}
	method poderDelHechizo() {return poderHechizo}
	method costoDelHechizo() {return costoHechizo}
	method tipoDelHechizo() {return tipoHechizo}
	method interactuar(heroe, hechizo) {heroe.aprenderHechizo(hechizo)}
}

//const bolaDeFuego = new Hechizo(
//	nombreHechizo ="Bola De Fuego",
//	poderHechizo  = 25,
//	tipoHechizo   = "fuego",
//	costoHechizo  = 10,
//	image         = "",
//	position      = game.at(1,1)
//)
//
//const rayoDeHielo = new Hechizo(
//	nombreHechizo ="Rayo De Hielo",
//	poderHechizo  = 15,
//	tipoHechizo   = "agua",
//	costoHechizo  = 10,
//	image         = "",
//	position      = game.at(2,2)
//)
//
//const descargaRelampago = new Hechizo(
//	nombreHechizo ="Bola De Fuego",
//	poderHechizo  = 20,
//	tipoHechizo   = "rayo",
//	costoHechizo  = 10,
//	image         = "",
//	position      = game.at(3,3)
//)
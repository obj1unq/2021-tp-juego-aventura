class Hechizo {
	const property nombreHechizo
	const property poderHechizo
	const property costoHechizo
	const property tipoHechizo
	const property imagen
	
	method nombreDelHechizo() {return nombreHechizo}
	method poderDelHechizo() {return poderHechizo}
	method costoDelHechizo() {return costoHechizo}
	method tipoDelHechizo() {return tipoHechizo}
	method usar(heroe, hechizo) {heroe.aprenderHechizo(hechizo)}
}

const bolaDeFuego = new Hechizo(
	nombreHechizo ="Bola De Fuego",
	poderHechizo  = 25,
	tipoHechizo   = "fuego",
	costoHechizo  = 10,
	imagen        = ""
)

const rayoDeHielo = new Hechizo(
	nombreHechizo ="Rayo De Hielo",
	poderHechizo  = 15,
	tipoHechizo   = "agua",
	costoHechizo  = 10,
	imagen        = ""
)

const descargaRelampago = new Hechizo(
	nombreHechizo ="Bola De Fuego",
	poderHechizo  = 20,
	tipoHechizo   = "rayo",
	costoHechizo  = 10,
	imagen        = ""
)
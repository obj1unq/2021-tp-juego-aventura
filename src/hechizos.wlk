class Hechizo {
	const property nombreHechizo
	const property poderHechizo
	const property tipoHechizo
	const property imagen
	
	method nombreDelHechizo() {return nombreHechizo}
	method poderDelHechizo() {return poderHechizo}
	method tipoDelHechizo() {return tipoHechizo}
}

const bolaDeFuego = new Hechizo(
	nombreHechizo ="Bola De Fuego",
	poderHechizo  = 25,
	tipoHechizo   = "fuego",
	imagen        = ""
)

const rayoDeHielo = new Hechizo(
	nombreHechizo ="Rayo De Hielo",
	poderHechizo  = 15,
	tipoHechizo   = "agua",
	imagen        = ""
)

const descargaRelampago = new Hechizo(
	nombreHechizo ="Bola De Fuego",
	poderHechizo  = 20,
	tipoHechizo   = "rayo",
	imagen        = ""
)
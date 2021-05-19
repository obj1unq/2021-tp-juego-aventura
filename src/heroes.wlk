import hechizos.*
import objetos.*

class Heroe {
	var property mochila = #{}
	var property libroDeHechizos = #{}
	var property manoIzquierda = punio
	var property cabeza = armaduraInicial
	
	method aprenderHechizo(hechizo){
		libroDeHechizos.add(hechizo)
	}
	
	method tomarObjeto(objeto) {
		mochila.add(objeto)
	}
}
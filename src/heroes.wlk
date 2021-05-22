import hechizos.*
import objetos.*
import wollok.game.*
class Heroe {
	var property nivelActual 
	var property image = null;
	var property position = null;
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
	
	method irA(x, y) {
		if (x>7 && y>7) {
			position = game.at(self.position().x(), self.position().y())
		} else {
			position = game.at(x, y)
		}
	}
}
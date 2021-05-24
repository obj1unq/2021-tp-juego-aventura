import hechizos.*
import objetos.*
import wollok.game.*
import niveles.*

class Heroe {
	var property mochila = #{}
	var property libroDeHechizos = #{}
	var property manoIzquierda = punio
	var property cuerpo = armaduraInicial
	var property modificadorAtaque
	var property modificadorDefensa
	var property maxVida
	var property actualVida
	var property maxMana
	var property actualMana
	
	var property nivelActual 
	var property image = null;
	var property position = null;
	
	method tomarObjeto(objeto) {
		objeto.usar(self, objeto)
	}
	
	method equiparArma(equipo) {
		self.tirarEquipoAReemplazar(self.manoIzquierda())
		self.manoIzquierda(equipo)
	}
	
	method equiparArmadura(equipo) {
		self.tirarEquipoAReemplazar(self.cuerpo())
		self.cuerpo(equipo)
	}
	
	method guardarObjetoEnLaMochila(objeto){
		mochila.add(objeto)
	}
	
	method tirarEquipoAReemplazar(equipo) {
		//codigo para droppear apropiadamente el equipo a ser reemplazado
		
	}
	
	method aprenderHechizo(hechizo){
		//falta chequeear que el hechizo no existe ya
		libroDeHechizos.add(hechizo)
	}
	
	method irA(x, y) {
		if (x>7 && y>7) {
			position = game.at(self.position().x(), self.position().y())
		} else {
			position = game.at(x, y)
		}
	}
}

const Warrior = new Heroe(
	image = "personajePrincipal.png", 
	position= game.at(2, 2),
	nivelActual = nivelInicial,
	modificadorAtaque = 1.4,
	modificadorDefensa = 1.1,
	maxVida = 200,
	actualVida = 200,
	maxMana = 30,
	actualMana = 30
)

const Tank = new Heroe(
	image = "personajePrincipal.png", 
	position= game.at(4, 4), 
	nivelActual = nivelInicial,
	modificadorAtaque = 1.1,
	modificadorDefensa = 1.6,
	maxVida = 250,
	actualVida = 250,
	maxMana = 20,
	actualMana = 20
)

const Wizzard = new Heroe(
	image = "personajePrincipal.png", 
	position= game.at(2, 4), 
	nivelActual = nivelInicial,
	modificadorAtaque = 0.8,
	modificadorDefensa = 0.9,
	maxVida = 150,
	actualVida = 150,
	maxMana = 100,
	actualMana = 100
)
/////////////////////////////////////////////////////////////////////////////////
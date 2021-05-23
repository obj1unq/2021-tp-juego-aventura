import heroes.*
import wollok.game.*


object config {

	method configurarTeclas(heroe) {
		keyboard.left().onPressDo({ heroe.irA((heroe.position().x() - 1).max(0), heroe.position().y())})
		keyboard.right().onPressDo({heroe.irA(( heroe.position().x() + 1).min(9), heroe.position().y())})
		keyboard.up().onPressDo({ heroe.irA(heroe.position().x(), ( heroe.position().y() + 1).min(9))})
		keyboard.down().onPressDo({ heroe.irA(heroe.position().x(),( heroe.position().y() - 1).max(0))})
	}

	method configurarColisiones(heroe) {
		game.onCollideDo(heroe, { algo => algo.teEncontraron(heroe)})
	}

}
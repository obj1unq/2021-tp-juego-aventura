import heroes.*
import wollok.game.*


object config {

	method configurarTeclas(heroe) {
		keyboard.left().onPressDo({ heroe.irA((heroe.position().x() - 1).max(0), heroe.position().y())})
		keyboard.right().onPressDo({heroe.irA(( heroe.position().x() + 1).min(9), heroe.position().y())})
		keyboard.up().onPressDo({ heroe.irA(heroe.position().x(), ( heroe.position().y() + 1).min(9))})
		keyboard.down().onPressDo({ heroe.irA(heroe.position().x(),( heroe.position().y() - 1).max(0))})
		keyboard.c().onPressDo({ heroe.tomarObjeto()})
		keyboard.z().onPressDo({ heroe.beberPocionVida()})
		keyboard.x().onPressDo({ heroe.beberPocionMana()})
	}

	method configurarColisiones(heroe) {
		game.onCollideDo(heroe, { algo => algo.teEncontraron(heroe)})
	}

}

object configPelea {
	
	var property enemigo;
	
	method configurarTeclas(heroe) {
		keyboard.a().onPressDo({ heroe.atacar(enemigo)})
	}
	
	method configurarColisiones(heroe) {
		game.onCollideDo(heroe, { algo => algo.teEncontraron(heroe)})
	}
}
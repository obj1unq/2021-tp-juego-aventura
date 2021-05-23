import heroes.*
import wollok.game.*
import enemigos.*
import objetos.*
import configuraciones.*


object nivelInicial {
	
	method iniciar() {
		self.agregarObjetosIniciales()
		self.configurarMecanicas()
	}

	method agregarObjetosIniciales() {
		const esqueleto = new Enemigo(
			image = "enemigo1.png", 
			position= game.at(heroe.position().x().max(3), 0));
			
		const murcielago = new Enemigo(
			image = "murcielago.png", 
			position= game.at(heroe.position().x().max(6), 3));
			
		const arbolFuego = new Enemigo(
			image = "arboldefuego.png", 
			position= game.at(heroe.position().x().max(6), 6));
			
		const cofreAzul = new Cofre(
			imagenCerrado = "Blue CHest Closed.png",
			imagenAbierto ="Blue Chest Open.png", 
			position= game.at(9,2))
			
		const cofreRojo = new Cofre(
			imagenCerrado = "Red Chest Closed.png",
			imagenAbierto = "Red Chest Open.png",
			position= game.at(9,6))
			
		const cofreVerde = new Cofre(
			imagenCerrado = "Green Chest Closed.png",
			imagenAbierto = "Green Chest Open.png",
			position= game.at(6.5,9))
			
		const cofreAzul2 = new Cofre(
			imagenCerrado = "Blue CHest Closed.png",
			imagenAbierto = "Blue Chest Open.png",
			position= game.at(1,9))
			
		game.addVisual(esqueleto)
		game.addVisual(murcielago)
		game.addVisual(arbolFuego)
		game.addVisual(cofreAzul)
		game.addVisual(cofreRojo)
		game.addVisual(cofreVerde)
		game.addVisual(cofreAzul2)
	}

	method configurarMecanicas() {
		config.configurarTeclas()
		config.configurarColisiones()
	}

	method terminar() {
		game.clear()
	}
}
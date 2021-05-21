import wollok.game.*
import ataques.*

object hangar {

	const enemigos = [ new NavePequenia(), new NaveMediana(), new NaveGrande() ]
	const property enemigosEnJuego = []

	method generarEnemigoSiSeRequiere() {
		if (self.seRequiereEnemigo()) {
			self.generarEnemigo()
		}
	}

	method seRequiereEnemigo() {
		return game.allVisuals().filter{ objeto => objeto.tipo() == "enemigo" }.size() <= 5
	}

	method generarEnemigo() {
		const enemigoNuevo = self.enemigoAleatorio()
		game.addVisual(enemigoNuevo)
		enemigoNuevo.dispararTodoElTiempo()
		enemigosEnJuego.add(enemigoNuevo)
	}

	method enemigoAleatorio() {
		return enemigos.anyOne()
	}

}

class NavePequenia {

	var property vida = 100
	const property tipo = "enemigo"
	var property position = game.at(10.randomUpTo(20), 0.randomUpTo(10))

	method image() {
		return "nave-chica.png"
	}

	method dispararTodoElTiempo() {
		game.onTick(500, "enemigos", { self.disparar()})
	}

	method disparar() {
		// Instanciamos el disparo, lo mostramos y le damos la orden para que se mueva.
		const disparo = new Disparo(position = self.position().left(1), damage = 20)
		game.addVisual(disparo)
		disparo.moverse() // (el movimiento es provisorio para despues ver como pararlo cuando este fuera del tablero
		// sino se lagea porque empiezan a juntarse)
	}

}

class NaveMediana {

	var property vida = 250
	const property tipo = "enemigo"
	var property position = game.at(10.randomUpTo(20), 0.randomUpTo(10))

	method image() {
		return "nave-mediana.png"
	}

	method dispararTodoElTiempo() {
		game.onTick(500, "enemigos", { self.disparar()})
	}

	method disparar() {
		const disparo = new Disparo(position = self.position().left(1), damage = 30)
		game.addVisual(disparo)
		disparo.moverse()
	}

}

class NaveGrande {

	var property vida = 500
	const property tipo = "enemigo"
	var property position = game.at(10.randomUpTo(20), 0.randomUpTo(10))

	method image() {
		return "nave-grande.png"
	}

	method dispararTodoElTiempo() {
		game.onTick(500, "enemigos", { self.disparar()})
	}

	method disparar() {
		const disparo = new Disparo(position = self.position().left(1), damage = 20)
		game.addVisual(disparo)
		disparo.moverse()
	}

}

object jugador {

	var property vida = 1000
	const property tipo = "jugador"
	var property position = game.at(0, 8)

//	method position() {
//		//habría que ponerle una posición fija dentro de la pantalla de inicio
//		return game.at(0,25)
//	}
	method image() {
		return "player1.png"
	}

	method disparar() {
		const disparo = new Disparo(position = self.position().left(10), damage = 20)
		game.addVisual(disparo)
		disparo.moverse()
	}

	method irA(posicion) {
		position = posicion
	}

}


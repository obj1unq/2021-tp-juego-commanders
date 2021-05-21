import wollok.game.*
import ataques.*

object hangar {

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
//		enemigoNuevo.movimiento()
		enemigosEnJuego.add(enemigoNuevo)
	}

	method enemigoAleatorio() {
	const enemigos = [new NavePequenia(), new NaveMediana(), new NaveGrande()]
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
	
	method movimiento() {
		//TODO: agregarle un patron de movimiento
	}

}

class NaveMediana {

	var property vida = 250
	const property tipo = "enemigo"
	var property position = game.at(10.randomUpTo(20), 0.randomUpTo(10))
	var property direccion = "arriba"

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
/*
	method movimiento() {
		game.onTick(100, "enemigoEnMovimiento", { self.moverse()})
	}

	method moverse() {
		if (self.position().x() <= -10) {
			self.desaparecer()
		} else {
			self.iaMovimiento()
		}
	}

	method desaparecer() {
		game.removeTickEvent("enemigoEnMovimiento")
		game.removeVisual(self)
	}

	method iaMovimiento() {
		if (self.position().y() < 10 && self.direccion == "arriba") 
			{self.irDiagonalArriba()}
		elseif
		(self.position().y() == 10)
		{ self.direccion = "abajo"
			self.irDiagonalAbajo()
		}
		elseif
		(self.position() > 0 && direccion == "abajo")
		{ self.irDiagonalAbajo()}
		else{
			direccion = "arriba"
			self.irDiagonalArriba()
		}
	}
	
	method irA(nuevaPosicion) {
		position = nuevaPosicion
	}
	
	method irDiagonalArriba() {
		self.irA(game.at(self.position().x()-1, self.position().y()+1))
	}
	
	method irDiagonalAbajo() {
		self.irA(game.at(self.position().x()-1, self.position().y()-1))
	}
	* 
	*/
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
	
	method movimiento() {
		//TODO: agregarle un patron de movimiento
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


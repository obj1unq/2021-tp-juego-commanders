import wollok.game.*
import ataques.*
import wollok.game.*

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
	
	method eliminarEnemigosPerdidos() {
		const enemigosPerdidos = enemigosEnJuego.filter{enemigo => enemigo.position().x() <= -1}
		enemigosPerdidos.forEach{enemigo => enemigo.desaparecer()}
		enemigosEnJuego.removeAll(enemigosPerdidos)
	}
	
	method movimientoEnemigo() {
		game.onTick(300, "movimiento de enemigos", {enemigosEnJuego.forEach{enemigo=>enemigo.iaMovimiento()}})
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
		game.onTick(1000, "enemigos", { self.disparar()})
	}

	method disparar() {
		gestorDeDisparos.disparar(20, self.position())
	}
	
//	method movimiento() {
//		game.onTick(300, "EnemigoEnMovimiento", {self.moverseSiEstaEnPantalla()})
//	}
//
//	method moverseSiEstaEnPantalla() {
//		if (self.position().x() <= -10) {
//			self.desaparecer()
//		} else {
//			self.iaMovimiento()
//		}
//	}

	method desaparecer() {
		game.removeVisual(self)
	}

	method iaMovimiento() {
		self.irA(self.position().left(1))
	}
	
	method irA(nuevaPosicion) {
		position = nuevaPosicion
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
		game.onTick(1000, "enemigos", { self.disparar()})
	}

	method disparar() {
		gestorDeDisparos.disparar(20, self.position())
	}

	method movimiento() {
		game.onTick(300, "enemigoEnMovimiento", { self.moverseSiEstaEnPantalla()})
	}

	method moverseSiEstaEnPantalla() {
		if (self.position().x() <= -10) {
			self.desaparecer()
		} else {
			self.iaMovimiento()
		}
	}

	method desaparecer() {
		game.removeVisual(self)
	}

	method iaMovimiento() {
		self.irA(self.position().left(1))
	}
	
	method irA(nuevaPosicion) {
		position = nuevaPosicion
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
		game.onTick(1000, "enemigos", { self.disparar()})
	}

	method disparar() {
		gestorDeDisparos.disparar(20, self.position())
	}
	
	method movimiento() {
		game.onTick(300, "enemigoEnMovimiento", { self.moverseSiEstaEnPantalla()})
	}

	method moverseSiEstaEnPantalla() {
		if (self.position().x() <= -10) {
			self.desaparecer()
		} else {
			self.iaMovimiento()
		}
	}

	method desaparecer() {
		game.removeVisual(self)
	}

	method iaMovimiento() {
		self.irA(self.position().left(1))
	}
	
	method irA(nuevaPosicion) {
		position = nuevaPosicion
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

//	method disparar() {
//		const disparo = new Disparo(position = self.position().left(10), damage = 20)
//		game.addVisual(disparo)
//		disparo.moverse()
//	}

	method irA(posicion) {
		position = posicion
	}

}


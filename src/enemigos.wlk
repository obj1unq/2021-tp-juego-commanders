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
		enemigosEnJuego.add(enemigoNuevo)
	}

	method enemigoAleatorio() {
		const enemigos = [ new NavePequenia(), new NaveMediana(), new NaveGrande() ]
		return enemigos.anyOne()
	}

	method eliminarEnemigosPerdidos() {
		const enemigosPerdidos = enemigosEnJuego.filter{ enemigo => enemigo.position().x() <= -1 }
		enemigosPerdidos.forEach{ enemigo => enemigo.desaparecer()}
		enemigosEnJuego.removeAll(enemigosPerdidos)
	}

	method movimientoEnemigo() {
		game.onTick(300, "movimiento de enemigos", { enemigosEnJuego.forEach{ enemigo => enemigo.iaMovimiento()}})
	}

	method eliminarEnemigo(enemigo) {
		enemigosEnJuego.remove(enemigo)
		enemigo.desaparecer()
	}

}

class Nave {

	const property tipo = "enemigo"
	var property position = game.at(10.randomUpTo(20), 0.randomUpTo(10))

	method dispararTodoElTiempo() {
		game.onTick(1000, "enemigos", { self.disparar()})
	}

	method disparar() {
		gestorDeDisparos.disparar(20, self.position())
	}

	method desaparecer() {
		position = game.at(-800, 0)
		game.removeVisual(self)
	}

	method iaMovimiento() {
		self.irA(self.position().left(1))
	}

	method irA(nuevaPosicion) {
		position = nuevaPosicion
	}

	method teEncontro(algo) {
		algo.chocar(self)
	}

	method chocar(algo) {
	}

	method moverseSiEstaEnPantalla() {
		if (self.position().x() <= -10) {
			self.desaparecer()
		} else {
			self.iaMovimiento()
		}
	}

}

class NavePequenia inherits Nave {

	var property vida = 100

	method image() {
		return "nave-chica.png"
	}

}

class NaveMediana inherits Nave {

	var property vida = 250
	var property direccion = "arriba"

	method image() {
		return "nave-mediana.png"
	}

}

class NaveGrande inherits Nave {

	var property vida = 500

	method image() {
		return "nave-grande.png"
	}

}


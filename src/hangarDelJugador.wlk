import wollok.game.*
import configuraciones.*
import enemigos.*
import ataques.*

object gestorDelJugador {

	var property jugadorActual = jugador

	method partesDelJugador() {
		jugadorActual.crearPartesDeLaNave()
	}

	method resetJugador() {
		jugadorActual.vida(1000)
		jugadorActual.position(game.at(0, 8))
		jugadorActual.eliminarPartes()
	}

}

object jugador {

	var property vida = 1000
	const property tipo = "jugador"
	var property position = game.at(0, 8)
	const property damage = 100
	const property partes = []
	var property cantidadEnemigosEliminados = 0
	
	method configurarColisiones() {
		config.configurarColisiones(self)
		partes.forEach({ parte => config.configurarColisiones(parte)})
	}

	method image() {
		return "naveJugador.png"
	}

	method disparar() {
		const disparoJugador = new DisparoAliado(damage = 20, position = self.position().right(3))
		const sonidoDisparo = new SonidoDisparo()
		game.addVisual(disparoJugador)
		sonidoDisparo.sonido()
		disparoJugador.movimientoConstante()
//		gestorDeDisparos.disparoJugador(self.damage(), self.position())
	}

	method irA(nuevaPosicion) {
		if (self.posicionDentroDePantalla(nuevaPosicion)) {
			position = nuevaPosicion
		}
	}

	method posicionDentroDePantalla(posicion) {
		return (posicion.x() >= 0 && posicion.x() <= 19 && posicion.y() >= 0 && posicion.y() <= 9
		)
	}

	method movimientoConstanteHacia(direccion) {
		return game.onTick(500, "calculoPosition", direccion)
	} // no esta en uso

	method chocar(nave) {
		vida -= nave.vida()
		nave.eliminar()
		game.say(self, vida.toString())
		//hangar.eliminarEnemigo(nave)
		cantidadEnemigosEliminados += 1
	}

	method recibirDisparo(algo) {
		vida -= algo.damage()
		algo.desaparecer()
		game.say(self, vida.toString())
//		gestorDeDisparos.eliminarDisparo(algo)
	}

	method crearPartesDeLaNave() {
		self.agregarParte(1, 0)
		self.agregarParte(2, 0)
	}

	method agregarParte(x, y) {
		const parte = new Proxy(original = self, x = x, y = y)
		game.addVisual(parte)
		partes.add(parte)
	}

	method teEncontro(algo) {
	// no hace nada
	}

	method desaparecer() {
		self.eliminarPartes()
		game.removeVisual(self)
	}

	method eliminarPartes() {
		partes.forEach({ parte => parte.desaparecer()})
	}

}




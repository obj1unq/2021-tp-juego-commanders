import wollok.game.*
import hangarDelJugador.*
import ataques.*
import enemigos.*

object nivel1 {

	method iniciar() {
		game.clear()
		game.addVisual(jugador) // jugador está en el wlk de enemigos... lo puse ahí para probarlo
		self.configurarMecanicas()
	}

	method configurarMecanicas() {
		config.configuracionTeclas()
		config.aparicionEnemigosAleatorios()
		config.fixDisparos()
		config.fixEnemigos()
		hangar.movimientoEnemigo()
		gestorDeDisparos.movimientoDisparo()
		config.configurarColisiones()
	}

}

object config {

	method configuracionTeclas() {
		keyboard.w().onPressDo({ jugador.irA(jugador.position().up(1))})
		keyboard.s().onPressDo({ jugador.irA(jugador.position().down(1))})
		keyboard.a().onPressDo({ jugador.irA(jugador.position().left(1))})
		keyboard.d().onPressDo({ jugador.irA(jugador.position().right(1))})
		keyboard.space().onPressDo({ jugador.disparar()}) // Tecla para el disparo del jugador.
//		hay que cambiar esto porque rompe al tocar espacio
	}

	method aparicionEnemigosAleatorios() {
		// cada cierto tiempo aparece un enemigo aleatorio
		game.onTick(2000, "enemigoAleatorio", { hangar.generarEnemigoSiSeRequiere()})
	}

	method fixDisparos() {
		game.onTick(5000, "eliminarBalasPerdidas", { gestorDeDisparos.eliminarBalasPerdidas()})
	}

	method fixEnemigos() {
		game.onTick(5000, "eliminarEnemigosPerdidos", { hangar.eliminarEnemigosPerdidos()})
	}

	method configurarColisiones() {
		game.onCollideDo(jugador, { algo => algo.teEncontro(jugador)})
	}

}


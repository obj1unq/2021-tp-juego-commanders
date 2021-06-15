import wollok.game.*
import hangarDelJugador.*
import ataques.*
import enemigos.*

object config {
		
	const jugador = gestorDelJugador.jugadorActual()
		
	method configurarMecanicas() {
		self.configuracionTeclas()
		self.aparicionEnemigosAleatorios()
//		self.fixDisparos()
//		self.fixEnemigos()
//		hangar.movimientoEnemigo()
//		gestorDeDisparos.movimientoDisparo()
		jugador.configurarColisiones()
	}

	method configuracionTeclas() {
		
		
		keyboard.w().onPressDo({ jugador.irA(jugador.position().up(1))})
		keyboard.s().onPressDo({ jugador.irA(jugador.position().down(1))})
		keyboard.a().onPressDo({ jugador.irA(jugador.position().left(1))})
		keyboard.d().onPressDo({ jugador.irA(jugador.position().right(1))})
		keyboard.space().onPressDo({ jugador.disparar()})
	}

	method aparicionEnemigosAleatorios() {
		// cada cierto tiempo aparece un enemigo aleatorio
		game.onTick(4000, "enemigoAleatorio", { hangar.generarEnemigoSiSeRequiere()})
	}

//	method fixDisparos() {
//		game.onTick(5000, "eliminarBalasPerdidas", { gestorDeDisparos.eliminarBalasPerdidas()})
//	}

//	method fixEnemigos() {
//		game.onTick(5000, "eliminarEnemigosPerdidos", { hangar.eliminarEnemigosPerdidos()})
//	}

	method configurarColisiones(cosa) {
		game.onCollideDo(cosa, { algo => algo.teEncontro(cosa)})
	}

}



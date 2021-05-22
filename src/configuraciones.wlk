import wollok.game.*
import hangarEnemigo.*
import hangarDelJugador.*
import ataques.*

object nivel1 {

	method iniciar() {
		game.clear()
		game.addVisual(jugador) // jugador está en el wlk de enemigos... lo puse ahí para probarlo
		config.configuracionTeclas()
		config.aparicionEnemigosAleatorios()
		config.fixDisparos()
		config.fixEnemigos()
	}

}

object config {

	method configuracionTeclas() {
		keyboard.w().onPressDo({ jugador.movimientoConstanteHacia({jugador.position().up(1)})})
		keyboard.s().onPressDo({ jugador.movimientoConstanteHacia({jugador.position().down(1)})})
		keyboard.a().onPressDo({ jugador.movimientoConstanteHacia({jugador.position().left(1)})})
		keyboard.d().onPressDo({ jugador.movimientoConstanteHacia({jugador.position().rigth(1)})})
		keyboard.space().onPressDo({ /* */
		}) // Tecla para el disparo del jugador.
	}

	method aparicionEnemigosAleatorios() {
		// cada cierto tiempo aparece un enemigo aleatorio
		game.onTick(2000, "enemigoAleatorio", { hangar.generarEnemigoSiSeRequiere()})
	}
	
	method fixDisparos() {
		game.onTick(5000, "eliminarBalasPerdidas", {gestorDeDisparos.eliminarBalasPerdidas()})
	}
	
	method fixEnemigos() {
		game.onTick(5000, "eliminarEnemigosPerdidos", {hangar.eliminarEnemigosPerdidos()})
	}

}


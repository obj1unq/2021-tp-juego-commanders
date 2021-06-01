import wollok.game.*
import configuraciones.*
import hangarDelJugador.*

class Nivel {
	
	const property jugador = gestorDelJugador.jugadorActual()
	
	method iniciar() {
		game.clear()
		game.addVisual(jugador)
		config.configurarMecanicas()
	}
}

import wollok.game.*
import configuraciones.*
import hangarDelJugador.*

class Nivel {
	
	const property jugador = gestorDelJugador.jugadorActual()
	
	method iniciar() {
		game.clear()
		game.addVisual(fondoMontania)
		game.addVisual(jugador)
		
		config.configurarMecanicas()
	}
	
	
}

object fondoMontania{
	method image() = "montaniaInicial.png"

	method position() = game.at(0, -1)
}

import wollok.game.*
import configuraciones.*
import hangarDelJugador.*
import enemigos.*

class Nivel {
	
	const property jugador = gestorDelJugador.jugadorActual()
	
	method iniciar() {
		const musica = new Sonido() //la clase Sonido esta en enemigos
		
		game.clear()
		fondo.iniciar()
//		musica.musicaDeFondo()
// hay que implementar el sonido de fondo, lo dejo comentado porque rompe
		game.addVisual(jugador)
		gestorDelJugador.partesDelJugador()
		
		config.configurarMecanicas()
	}
	
	
}
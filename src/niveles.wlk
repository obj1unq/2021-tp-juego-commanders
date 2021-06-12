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
		
		config.configurarMecanicas()
	}
	
	
}

object fondo {
	
	method iniciar(){
		game.addVisual(fondoMontania)
		game.addVisual(montaniaBucle)
		montaniaBucle.movimientoConstante()
	}
}

object fondoMontania{
	method image() = "montaniaInicial.png"

	method position() = game.at(0, -1)
}

object montaniaBucle {
	var property position = game.at(0,-1)
	
	method image() = "montaniaBucle.png"
	
	method movimientoConstante(){
		game.onTick(1000, "movimientoFondo", {self.moverse()})
	}
	
	method moverse(){
		if (self.position().x() <= -20){
			position = game.at(-1,-1)
		}
		else {
			position = position.left(1)
		}
	}
}

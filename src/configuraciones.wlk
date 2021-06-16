import wollok.game.*
import hangarDelJugador.*
import ataques.*
import enemigos.*
import niveles.*

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
		game.onTick(4000, "enemigoAleatorio", { gestorDeNiveles.nivelActual().hangar().generarEnemigoSiSeRequiere()})
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



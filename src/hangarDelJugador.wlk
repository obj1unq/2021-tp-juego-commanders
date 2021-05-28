import wollok.game.*
import configuraciones.*
import enemigos.*
import ataques.*

object jugador {

	var property vida = 1000
	const property tipo = "jugador"
	var property position = game.at(0, 8)
	const property damage = 100

//	const direcciones = [arriba = {self.position().up(1)},]
//	const abajo = {jugador.position().down(1)}
//	const izquierda = {jugador.position().left(1)}
//	const derecha = {jugador.position().rigth(1)}
//	method position() {
//		//habría que ponerle una posición fija dentro de la pantalla de inicio
//		return game.at(0,25)
//	}
	method image() {
		return "player1.png"
	}

	method disparar() {
		gestorDeDisparos.disparoJugador(self.damage(), self.position())
	}

	method irA(nuevaPosicion) {
		position = nuevaPosicion
	}

	method movimientoConstanteHacia(direccion) {
		return game.onTick(500, "calculoPosition", direccion)
	} // no esta en uso

	method chocar(nave) {
		vida -= nave.vida()
		hangar.eliminarEnemigo(nave)
	}

	method recibirDisparo(algo) {
		vida -= algo.damage()
		gestorDeDisparos.eliminarDisparo(algo)
	}

}


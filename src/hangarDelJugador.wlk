import wollok.game.*
import configuraciones.*
import enemigos.*
import ataques.*

//class HangarDelJugador {
//	
//	
//}
//// aca podemos definir distintas tipos de naves a elegir por el jugador al iniciar el game
//// se pueden hacer objeto disparo con una lista de tipos de disparos
//
//
//object disparo{ // esto se puede setiar segun la nave elegida o el bonus que agarre
//	const property velocidad 
//	var imagen
//	var tipo  
//}

object jugador {

	var property vida = 1000
	const property tipo = "jugador"
	var property position = game.at(0, 8)
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
		gestorDeDisparos.disparoJugador()
	}
//
//	method moverseHacia(posicion) {
//		game.onTick(500, "movimientoConstante", { self.irA(posicion)})
//	}
	method irA(nuevaPosicion) {
		position = nuevaPosicion
	}
//	method 
	method movimientoConstanteHacia(direccion) {
	return game.onTick(500, "calculoPosition", direccion)
	} 
	
	method chocar(nave) {
		vida -=nave.vida()
		hangar.eliminarEnemigo(nave)
	}
	
	method recibirDisparo(disparo) {
		vida -=disparo.damage()
		gestorDeDisparos.eliminarDisparo(disparo)
	}
//}moverseSiEstaEnPantalla() {
//		if (self.position().x() <= -10) {
//			self.desaparecer()
//		} else {
//			self.iaMovimiento()
//		}
//	}
//
//	method desaparecer() {
//		game.removeTickEvent("EnemigoEnMovimiento")
//		game.removeVisual(self)
//	}
}
import wollok.game.*
import hangarDelJugador.*

object gestorDeDisparos{
	const disparosActivos = []
	const disparosDelJugador = []
	
	method disparar(damage, posicion) {
		const nuevoDisparo = new Disparo(damage = damage, position = posicion)
		game.addVisual(nuevoDisparo)
//		nuevoDisparo.movimiento()
		disparosActivos.add(nuevoDisparo)
	}
	
	method disparoJugador() {
		const nuevoDisparoJugador = new DisparoJugador(damage = damage, position = game.at(jugador.position().x(), jugador.position().y()))
		game.addVisual(nuevoDisparoJugador)
//		nuevoDisparo.movimiento()
		disparosDelJugador.add(nuevoDisparoJugador)
	}
	
	method eliminarBalasPerdidas(){
		const balasPerdidas = disparosActivos.filter{disparo => disparo.position().x() <= -1}
		balasPerdidas.forEach{bala => bala.desaparecer()}
		disparosActivos.removeAll(balasPerdidas)
	}
	
	method movimientoDisparo() {
		game.onTick(50, "movimiento de disparos", {disparosActivos.forEach{disparo=>disparo.iaMovimiento()}})
	}
	
	method eliminarDisparo(disparo) {
		disparosActivos.remove(disparo)
		disparo.desaparecer()
	}
}

class Disparo {

	// Debemos setearle el daño y la posicion cada vez que se instancia un disparo.
	var property damage
	var property position
	const property tipo = "proyectil"

	method damage() {
		return damage
	}

	method image() {
		return "bulletBlue.png"
	}

	method irA(nuevaPosicion) {
		position = nuevaPosicion
	}

//	method movimiento() {
//		// modifique un poco el comportamiento de los disparos para que desaparescan antes de salir de la pantalla
//		game.onTick(50, "Movimiento Disparo", { self.iaMovimiento()})
//		}

	method desaparecer() {
//		game.removeTickEvent("Movimiento Disparo")
		game.removeVisual(self)
	}
	
	method iaMovimiento(){
		self.irA(self.position().left(1))
	}

}

class DisparoJugador {
	var property damage
	var property position
	const property tipo = "proyectil"
	
	method damage() {
		return damage
	}
	
	method image() {
		return "bulletBlue.png"
	}

	method irA(nuevaPosicion) {
		position = nuevaPosicion
	}
	
	method iaMovimiento(){
		self.irA(self.position().right(1))
	}
}

object lanzallamas {

	const damage = 40
	var property position
	const property tipo = "proyectil"

	method image() {
		return "lanzallamas.png"
	}

	method damage() {
		return damage
	}

	method irA(nuevaPosicion) {
		position = nuevaPosicion
	}
	
//	method teEncontro(algo) {
//		algo.recibirDisparo(self)
//	}

}


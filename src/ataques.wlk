import wollok.game.*
import hangarDelJugador.*

// ya no es necesario el gestor de disparos porque los disparos eliminan su propio onTick al desaparecer
// lo dejo comentado por si necesitamos implementarlo en algun momento

//object gestorDeDisparos {
//
//	const disparosActivos = []
//
//	method disparar(damage, posicion) {
//		const nuevoDisparo = new Disparo(damage = damage, position = posicion)
//		game.addVisual(nuevoDisparo)
//		disparosActivos.add(nuevoDisparo)
//	}
//
//	method disparoJugador(damage, position) {
//		const nuevoDisparoJugador = new DisparoJugador(damage = damage, position = position)
//		game.addVisual(nuevoDisparoJugador)
//		disparosActivos.add(nuevoDisparoJugador)
//	}
//
//	method eliminarBalasPerdidas() {
//		const balasPerdidas = disparosActivos.filter{ disparo => disparo.position().x() <= -1 }
//		balasPerdidas.forEach{ bala => bala.desaparecer()}
//		disparosActivos.removeAll(balasPerdidas)
//	}
//
//	method movimientoDisparo() {
//		game.onTick(50, "movimiento de disparos", { disparosActivos.forEach{ disparo => disparo.iaMovimiento()}})
//	}
//
//	method eliminarDisparo(disparo) {
//		disparosActivos.remove(disparo)
//		disparo.desaparecer()
//	}
//
//}

class Disparo {

	// Debemos setearle el daño y la posicion cada vez que se instancia un disparo.
	var property damage
	var property position
	const property tipo = "proyectil"
	const id = 0.randomUpTo(10000)

	method damage() {
		return damage
	}

	method image() {
		return "disparoAliado1.png"
	}
	
	method nombre() {
		return id.toString()
	}

	method irA(nuevaPosicion) {
		position = nuevaPosicion
	}

	method desaparecer() {
		game.removeTickEvent("disparo"+self.nombre())
		game.removeVisual(self)
	}
	
	method movimientoConstante() {
		game.onTick(50,"disparo"+self.nombre(), {self.movimiento()})
	}
	
	method iaMovimiento()
	
	method movimiento() {
		if (self.estaEnPantalla()) {
			self.iaMovimiento()
		}
		else {
			self.desaparecer()
		}
	}
	
	method estaEnPantalla() {
		return (position.x()>=0 && 
				position.x()<=20 &&
				position.y()>=0 &&
				position.y()<=10
		)
	}
	
	method teEncontro(algo) {
		algo.recibirDisparo(self)
	}

}

class DisparoEnemigo inherits Disparo {
	
	override method image() {
		return "disparoEnemigo1.png"
	}
	
	override method iaMovimiento() {
		self.irA(self.position().left(1))
	}
}

class DisparoAliado inherits Disparo {

	override method iaMovimiento() {
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

	method teEncontro(algo) {
		algo.recibirDisparo(self)
	}

}


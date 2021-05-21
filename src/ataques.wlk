import wollok.game.*

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

	method moverse() {
		// modifique un poco el comportamiento de los disparos para que desaparescan antes de salir de la pantalla
		game.onTick(50, "Movimiento Disparo", { if (self.position().x() <= -10) {
				self.desactivarDisparo()
			} else {
				self.irA(self.position().left(1))
			}
		})
	}

	method desactivarDisparo() { // este metodo hay que modificarlo porque tira errores
		game.removeTickEvent("Movimiento Disparo")
		game.removeVisual(self)
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

}


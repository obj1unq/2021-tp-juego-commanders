import wollok.game.*

object gestorDeDisparos{
	const disparosActivos = []
	
	method disparar(damage, posicion) {
		const nuevoDisparo = new Disparo(damage = damage, position = posicion)
		game.addVisual(nuevoDisparo)
		nuevoDisparo.movimiento()
		disparosActivos.add(nuevoDisparo)
	}
	
	method eliminarBalasPerdidas(){
		const balasPerdidas = disparosActivos.filter{disparo => disparo.position().x() <= -1}
		balasPerdidas.forEach{bala => bala.desaparecer()}
		disparosActivos.removeAllSuchThat{disparo => disparo.position().x() <= -1}
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

	method movimiento() {
		// modifique un poco el comportamiento de los disparos para que desaparescan antes de salir de la pantalla
		game.onTick(50, "Movimiento Disparo", { self.iaMovimiento()})
		}
	
	method moverseSiEstaEnPantalla() {
//		if(self.position().x() <= -10) {
//			self.desaparecer()
//		}
//		else {
			self.iaMovimiento()
//		}
	}

	method desaparecer() { // este metodo hay que modificarlo porque tira errores
		game.removeTickEvent("Movimiento Disparo")
		game.removeVisual(self)
	}
	
	method iaMovimiento(){
		self.irA(self.position().left(1))
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


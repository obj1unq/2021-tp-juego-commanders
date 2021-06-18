import wollok.game.*
import hangarDelJugador.*
import direcciones.*

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
	
	method chocar(algo){
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

class Explosion {
	const property position
	var property image = "explosion1.png"
	const vel = 100
	//TODO: modificar esta clase para que no lagee
	method animacion() {
		game.schedule(vel, {
			image = "explosion2.png"
			self.a1()
		})
	}
	
	method a1(){
		game.schedule(vel, {
			image = "explosion3.png"
			self.a2()
		})
	}
	
	method a2(){
		game.schedule(vel, {
			image = "explosion4.png"
			self.a3()
		})
	}
	
	method a3(){
		game.schedule(vel, {
			image = "explosion5.png"
			self.a4()
		})
	}
	
	method a4(){
		game.schedule(vel, {
			image = "explosion6.png"
			self.a5()
		})
	}
	
	method a5(){
		game.schedule(vel, {
			image = "explosion7.png"
			self.a6()
		})
	}
	
	method a6(){
		game.schedule(vel, {
			game.removeVisual(self)
		})
	}
	
	method teEncontro(algo){
		//no hace nada
	}
}

object embestida {
	var contador = 20
	
	method usar(algo){
		game.onTick(50, "embestida", {self.embestir(algo)})
		game.schedule(1500, {game.removeTickEvent("embestida")
							 contador = 20
		})
	}
	
	method embestir(algo){
		if ((contador > 0)and algo.position().x()>0){
			izquierda.mover(algo)
			contador -= 1
		}
		else {
			derecha.mover(algo)
			contador = 0
		}
	}
}

object metralleta {
	method usar(algo){
		
	}
}


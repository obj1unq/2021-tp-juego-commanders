import wollok.game.*
import ataques.*

object hangar {

	const property enemigosEnJuego = []

	method generarEnemigoSiSeRequiere() {
		if (self.seRequiereEnemigo()) {
			self.generarEnemigo()
		}
	}

	method seRequiereEnemigo() {
		return enemigosEnJuego.size() <= 3
//		return game.allVisuals().filter{ objeto => objeto.tipo() == "enemigo" }.size() <= 3
	}

	method generarEnemigo() {
		const enemigoNuevo = self.enemigoAleatorio()
		game.addVisual(enemigoNuevo)
		enemigoNuevo.dispararTodoElTiempo()
		enemigosEnJuego.add(enemigoNuevo)
	}

	method enemigoAleatorio() {
		const enemigos = [ 	new NavePequenia(),
							new NavePequenia(),
							new NavePequenia(),
							new NaveMediana(),
							new NaveGrande()]
		return enemigos.anyOne()
	}

	method eliminarEnemigosPerdidos() {
		const enemigosPerdidos = enemigosEnJuego.filter{ enemigo => enemigo.position().x() <= -1 }
		enemigosPerdidos.forEach{ enemigo => enemigo.desaparecer()}
		enemigosEnJuego.removeAll(enemigosPerdidos)
	}

	method movimientoEnemigo() {
		game.onTick(300, "movimiento de enemigos", { enemigosEnJuego.forEach{ enemigo => enemigo.iaMovimiento()}})
	}

	method eliminarEnemigo(enemigo) {
		enemigosEnJuego.remove(enemigo)
		enemigo.desaparecer()
	}

}

class Nave {
	
	const property id = 0.randomUpTo(10000)
	const property tipo = "enemigo"
	var property position = game.at(10.randomUpTo(20), 0.randomUpTo(10))

	method dispararTodoElTiempo() {
		game.onTick(1000, "enemigo"+self.nombre(), { self.disparar()})
	}

	method disparar() {
		gestorDeDisparos.disparar(20, self.position())
	}

	method desaparecer() {
		game.removeTickEvent("enemigo"+self.nombre())
		game.removeVisual(self)
	}
	
	method nombre() {
		return id.toString()
	}

	method iaMovimiento() {
		self.irA(self.position().left(1))
	}

	method irA(nuevaPosicion) {
		position = nuevaPosicion
	}

	method teEncontro(algo) {
		algo.chocar(self)
	}

	method chocar(algo) {
	}

	method moverseSiEstaEnPantalla() {
		if (self.position().x() <= -10) {
			self.desaparecer()
		} else {
			self.iaMovimiento()
		}
	}
	
	method nombreDelOnTick(){
		return "enemigos"+self.nombre()
	}

}

class NavePequenia inherits Nave {

	var property vida = 100
	var property direccion = "arriba"

	method image() {
		return "nave-chica.png"
	}
	
	override method iaMovimiento() {
		self.cambiarDireccionSiEsNecesario()
		self.irA(game.at(self.position().x()-1, self.direccionActual()))
	}
	
	method direccionActual() {
		if (direccion == "arriba") {
			return self.position().y()+1
		}
		else if (direccion == "abajo") {
			return self.position().y()-1
		}
		else {
			return 666 // esto nunca va a pasar
		}
		
	}
	
	method cambiarDireccionSiEsNecesario() {
		if (self.position().y()>=9) {
			direccion = "abajo"
		}
		else if (self.position().y()<=0) {
			direccion = "arriba"
		}
	}
}

class NaveMediana inherits Nave {

	var property vida = 250
	var property direccion = "arriba"
	var property contadorDePasos = 5

	method image() {
		return "nave-mediana.png"
	}
	
	override method iaMovimiento() {
		if (self.estaEnBorde() && contadorDePasos > 0) {
			self.irA(self.position().left(1))
			contadorDePasos -= 1
		}
		else if (contadorDePasos == 0) {
			self.cambiarDireccion()
			self.irA(self.direccionActual())
			contadorDePasos = 5
		}
		else {
			self.irA(self.direccionActual())
		}
	}
	
	method direccionActual() {
		if (direccion == "arriba") {
			return game.at(self.position().x(),self.position().y()+1)
		}
		else if (direccion == "abajo") {
			return game.at(self.position().x(),self.position().y()-1)
		}
		else {
			return game.at(666,666) // esto nunca va a pasar
		}
	}
	
	method cambiarDireccion() {
		if (direccion == "arriba"){
			direccion = "abajo"
		}
		else {
			direccion ="arriba"
		}
	}
	
	method estaEnBorde() {
		return 	self.position().y()<=0 ||
				self.position().y()>=9
	}
}

class NaveGrande inherits Nave {

	var property vida = 500

	method image() {
		return "nave-grande.png"
	}

}


import wollok.game.*
import hangarDelJugador.*
import direcciones.*

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
	
	method teEncontro(algo) 
	
//	method chocar(algo){
//		algo.recibirDisparo(self)
//	}

}

class DisparoEnemigo inherits Disparo {
	
	override method image() {
		return "disparoEnemigo1.png"
	}
	
	override method iaMovimiento() {
		self.irA(self.position().left(1))
	}
	override method teEncontro(algo) {
		algo.recibirDisparoEnemigo(self)
	}
}

class DisparoAliado inherits Disparo {

	override method iaMovimiento() {
		self.irA(self.position().right(1))
	}
	override method teEncontro(algo){
		algo.recibirDisparoJugador(self)
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

class Animacion {
	
	var property image
	var indice = 0
	
	method animacion() //lista de 4 imagenes
	
	method ejecutarAnimacion(wollokmon){
		self.siguienteImagen()
		game.addVisualIn(self, wollokmon.position()) 
		game.schedule(400, ({self.siguienteImagen()}))
		game.schedule(800, ({self.siguienteImagen()}))
		game.schedule(1200, ({self.siguienteImagen()}))
		game.schedule(1500, ({
			game.removeVisual(self)
		}))
	}
	
	method siguienteImagen(){
		image = self.animacion().get(indice)
		indice = (indice + 1) % 4
	}
	
}

class Explosion {
	
	
	const property position
	var property image = "explosion1.png"
	const vel = 100
	/*
	const frames = ["explosion1.png","explosion2.png","explosion3.png","explosion4.png","explosion5.png","explosion6.png","explosion7.png"]
	var indice = 0
	
	method animacion() {
		self.siguienteFrame()
		game.addVisualIn(self, position) 
		game.schedule(vel, ({self.siguienteFrame()}))
		game.schedule(vel, ({self.siguienteFrame()}))
		game.schedule(vel, ({self.siguienteFrame()}))
		game.schedule(vel, ({game.removeVisual(self)}))
	}
		
	method siguienteFrame(){
		image = frames.get(indice)
		indice += 1
	}
	*/
	
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

class SonidoDisparo {
	const sonido = game.sound("disparo.mp3")
	
	method sonido(){
		sonido.volume(0.2)
		sonido.play()
	} 
}


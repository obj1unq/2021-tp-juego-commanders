import wollok.game.*
import hangarDelJugador.*
import ataques.*
import enemigos.*
import niveles.*

object config {

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
		game.onTick(800, "movimientoFondo", {self.moverse()})
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

object musicaInicio{
	const musica = game.sound("musicaFondo.mp3")
	
	method iniciarSiNoEstaSonando(){
		if(not self.musicaSonando()){
			self.iniciar()
		}
	}
	
	method iniciar(){
		musica.shouldLoop(true)
		musica.volume(0.2)
		musica.play()
		
	}
	
	method musicaSonando(){
		return musica.played()
	}
}

class Proxy {

	const original
	const x
	const y

	method position() {
		return original.position().right(x).up(y)
	}

	method image() {
		return "vacio.png"
	}

	method chocar(algo) {
		original.chocar(algo)
	}

	method recibirDisparo(disparo) {
		original.recibirDisparo(disparo)
	}

	method teEncontro(algo) {
	}

	method desaparecer() {
		game.removeVisual(self)
	}

}



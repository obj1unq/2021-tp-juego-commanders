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
	method recibirDisparoEnemigo(disparo){
		original.recibirDisparoEnemigo(disparo)
	}
	method recibirDisparoJugador(disparo) {
		original.recibirDisparoJugador(disparo)
	}

	method teEncontro(algo) {
	}

	method desaparecer() {
		game.removeVisual(self)
	}

}

class S{
	method image() = "letras/letraS.png"

	method position() = game.at(10, 11)
}

class C{
	method image() = "letras/letraC.png"

	method position() = game.at(11, 11)
}

class O{
	method image() = "letras/letraO.png"

	method position() = game.at(12, 11)
}

class R{
	method image() = "letras/letraR.png"

	method position() = game.at(13, 11)
}

class E{
	method image() = "letras/letraE.png"

	method position() = game.at(14, 11)
}


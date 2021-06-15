import wollok.game.*
import configuraciones.*
import enemigos.*
import ataques.*

object gestorDelJugador {
	var property jugadorActual = new Jugador()
	
	method partesDelJugador(){
		jugadorActual.crearPartesDeLaNave()
	}
}

class Jugador {

	var property vida = 1000
	const property tipo = "jugador"
	var property position = game.at(0, 8)
	const property damage = 100
	const property partes = []

//	const direcciones = [arriba = {self.position().up(1)},]
//	const abajo = {jugador.position().down(1)}
//	const izquierda = {jugador.position().left(1)}
//	const derecha = {jugador.position().rigth(1)}
//	method position() {
//		//habría que ponerle una posición fija dentro de la pantalla de inicio
//		return game.at(0,25)
//	}

//	override method initialize() {
//		self.crearPartesDeLaNave()
//	}
	
	method configurarColisiones() {
		config.configurarColisiones(self)
		partes.forEach({parte=>config.configurarColisiones(parte)})
	}

	method image() {
		return "naveJugador.png"
	}

	method disparar() {
		const disparoJugador = new DisparoAliado(damage=20, position=self.position().right(1))
		game.addVisual(disparoJugador)
		disparoJugador.movimientoConstante()
//		gestorDeDisparos.disparoJugador(self.damage(), self.position())
	}

	method irA(nuevaPosicion) {
		if (self.posicionDentroDePantalla(nuevaPosicion)) {
		position = nuevaPosicion			
		}
	}
	
	method posicionDentroDePantalla(posicion) {
		return (posicion.x()>=0 && 
				posicion.x()<=19 &&
				posicion.y()>=0 &&
				posicion.y()<=9
		)
	}

	method movimientoConstanteHacia(direccion) {
		return game.onTick(500, "calculoPosition", direccion)
	} // no esta en uso

	method chocar(nave) {
		vida -= nave.vida()
		nave.desaparecer()
//		hangar.eliminarEnemigo(nave)
	}

	method recibirDisparo(algo) {
		vida -= algo.damage()
		algo.desaparecer()
//		gestorDeDisparos.eliminarDisparo(algo)
	}
	
	method crearPartesDeLaNave(){
		self.agregarParte(1,0)
		self.agregarParte(2,0)
	}
	
	method agregarParte(x,y){
		const parte = new Proxy(original = self, x = x, y = y)
		game.addVisual(parte)
		partes.add(parte)
	}

}

class Proxy{
  const original
  const x
  const y
//  const position
  method position() { 
  	return original.position().right(x).up(y)
  }
  method chocar(algo) { 
    original.chocar(algo)
  }
  
  method recibirDisparo(disparo){
  	original.recibirDisparo(disparo)
  }
}
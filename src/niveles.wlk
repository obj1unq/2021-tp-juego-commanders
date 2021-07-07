import wollok.game.*
import configuraciones.*
import hangarDelJugador.*
import enemigos.*

class GestorDeNiveles {
	
	method iniciar() { 
		game.clear()
		game.addVisual(self)
		self.configuracionTeclas()
		//detener musica si esta sonando
		self.iniciarMusica()
	}
	
	method position(){return game.origin()}
	method image()
	method configuracionTeclas()
	
	method iniciarMusica() {
		game.schedule(500, {musicaInicio.iniciarSiNoEstaSonando()})
	}
	
}
	

object menuInicio inherits GestorDeNiveles{
	
	override method image() {
		return "menuInicio.png"
	}
	
	override method configuracionTeclas(){
		keyboard.num1().onPressDo({nivel1.iniciar()})
	}
}

class Nivel  inherits GestorDeNiveles {

	const property jugador = gestorDelJugador.jugadorActual()
	var property enemigosAsesinados = 0
	
	override method image() {
		return "fondo3.png"
	}

	override method iniciar() {
		super()		 
		//fondo.iniciar()
		game.addVisual(jugador)
		gestorDelJugador.partesDelJugador()
		self.configurarMecanicas()
	}
	
	method configurarMecanicas() {
		self.aparicionEnemigosAleatorios()
		jugador.configurarColisiones()
	}

	override method configuracionTeclas() {		
		keyboard.w().onPressDo({ jugador.irA(jugador.position().up(1))})
		keyboard.s().onPressDo({ jugador.irA(jugador.position().down(1))})
		keyboard.a().onPressDo({ jugador.irA(jugador.position().left(1))})
		keyboard.d().onPressDo({ jugador.irA(jugador.position().right(1))})
		keyboard.space().onPressDo({ jugador.disparar()})	
	}

	method aparicionEnemigosAleatorios() {
		// cada cierto tiempo aparece un enemigo aleatorio
		game.onTick(4000, "enemigoAleatorio", { hangar.generarEnemigoSiSeRequiere(self)})
	}
	
	method pasarNivel() {
		if (enemigosAsesinados >= self.enemigosRequeridos()) {
			self.siguienteNivel()
		}
	}

	method enemigosRequeridos()

	method aumentarContador() {
		enemigosAsesinados += 1
		self.pasarNivel()
	}

	method siguienteNivel()
	
	method posicionAleatoria(){
		return game.at(10.randomUpTo(20), 0.randomUpTo(10))
	}

}

object nivel1 inherits Nivel {

	method enemigos() {
		return [ new NavePequenia(position = self.posicionAleatoria()) ]
	}

	override method siguienteNivel() {
		nivel3.iniciar()
	}
	
	override method enemigosRequeridos(){
		return 3
	}

}

object nivel2 inherits Nivel {

	method enemigos() {
		return [new NavePequenia(position = self.posicionAleatoria()), 
				new NavePequenia(position = self.posicionAleatoria()), 
				new NaveMediana(position = self.posicionAleatoria())
		]
	}
	
	override method enemigosRequeridos(){
		return 6
	}

	override method siguienteNivel() {
		nivel3.iniciar()
	}

}

object  nivel3 inherits Nivel {

	method enemigos() {
		return [new NavePequenia(position = self.posicionAleatoria()), 
				new NavePequenia(position = self.posicionAleatoria()), 
				new NavePequenia(position = self.posicionAleatoria()), 
				new NaveMediana(position = self.posicionAleatoria()), 
				new NaveMediana(position = self.posicionAleatoria()), 
				new NaveGrande(position = self.posicionAleatoria())
		]
	}

	override method enemigosRequeridos(){
		return 10
	}

	override method siguienteNivel() {
		nivel4.iniciar()
	}

}

object nivel4 inherits Nivel {

	method enemigos() {
		return []
	}
	
	override method enemigosRequeridos(){
		return 1
	}

	override method siguienteNivel() {
		game.stop()
	}
	
	override method iniciar(){
		super()
		self.agregarJefe()
	}
	
	method agregarJefe(){
		const jefe = new Jefe()
		game.addVisual(jefe)
		jefe.configurarColisiones()
		jefe.crearPartesDeLaNave()
		jefe.iaAtaque()
		jefe.movimientoJefe()
	}

}


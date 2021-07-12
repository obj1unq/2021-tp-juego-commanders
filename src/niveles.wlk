import wollok.game.*
import configuraciones.*
import hangarDelJugador.*
import enemigos.*

class GestorDeNiveles {
	
	method iniciar() { 
		game.clear()
		game.addVisual(self)
		self.configuracionTeclas()
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
		keyboard.num2().onPressDo({game.say(self, "Aun en construcción")})
		keyboard.num3().onPressDo({game.stop()})
	}
}

class Nivel  inherits GestorDeNiveles {

	const property jugador = gestorDelJugador.jugadorActual()
	const s = new S()
	const c = new C()
	const o = new O()
	const r = new R()
	const e = new E()
	override method image() {
		return "fondo3.png"
	}

	override method iniciar() {
		super()		 
		fondo.iniciar()
		game.addVisual(jugador)
		game.addVisual(s)
		game.addVisual(c)
		game.addVisual(o)
		game.addVisual(r)
		game.addVisual(e)
		self.mostrarVidas(jugador)
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
		keyboard.backspace().onPressDo({menuInicio.iniciar()})
	}

	method aparicionEnemigosAleatorios() {
		// cada cierto tiempo aparece un enemigo aleatorio
		game.onTick(4000, "enemigoAleatorio", {
			 self.pasarNivel()
			 hangar.generarEnemigoSiSeRequiere(self)})
	}
	
	method pasarNivel() {
		if (jugador.cantidadEnemigosEliminados() >= self.enemigosRequeridos()) {
			self.siguienteNivel()
		}
	}

	method enemigosRequeridos()

	method siguienteNivel()
	
	method posicionAleatoria(){
		return game.at(10.randomUpTo(20), 0.randomUpTo(10))
	}
	
	method mostrarVidas(_jugador) {
		jugador.corazones().forEach({ corazon => game.addVisual(corazon)})
	}
	method teEncontro(algo){}
}

object nivel1 inherits Nivel {

	method enemigos() {
		return [ new NavePequenia(position = self.posicionAleatoria()) ]
	}
	
	override method enemigosRequeridos(){
		return 3
	}

	override method siguienteNivel() {
		nivel2.iniciar()
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
object estadisticas inherits GestorDeNiveles{
	var property puntosAcumulados = 0
	var property cantNavePequenia
	var property cantNaveMediana
	var property cantNaveGrande
	
	override method image(){ return ""} // poner imagen con un titulo de estadisticas 
	override method position() = game.at(game.center().x(), 10)
	
	override method configuracionTeclas(){
		keyboard.x().onPressDo({self.terminoElJuego()})
    	keyboard.c().onPressDo({menuInicio.iniciar()})
	}
	
	method showPerdiste(){
		game.addVisual(perdedor)
		game.addVisual(self)
		game.say(perdedor, "derribaste un total de "+self.totalDeNavesDerribadas()+" naves enemigas y sumaste "+puntosAcumulados+" puntos")
	}
	
	method showGanaste(){
		game.addVisual(ganador)
		game.addVisual(self)
		game.say(ganador, "derribaste un total de "+self.totalDeNavesDerribadas()+" naves enemigas y sumaste "+puntosAcumulados+" puntos")
	}
	
	method terminoElJuego() { game.stop() }
	
	method sumarPuntos(puntosDeLaNave) { puntosAcumulados += puntosDeLaNave }
	
	method derriboNavePequenia() { cantNavePequenia += 1}
	method derriboNaveMediana() { cantNaveMediana += 1}
	method derriboNaveGrande() { cantNaveGrande += 1}
	method totalDeNavesDerribadas() = cantNavePequenia+cantNaveMediana+cantNaveGrande
}
object ganador{
	method image(){} // poner imagen que muestre cuando gane
	method position() = game.at(game.center().x(), 5)
}
object perdedor{
	method image(){} // poner imagen que muestre cuando pierde
	method position() = game.at(game.center().x(), 5)
}





import wollok.game.*
import configuraciones.*
import hangarDelJugador.*
import enemigos.*

object gestorDeNiveles {
	var property nivelActual = new Nivel4()
}

class Nivel {
	const property hangar = new Hangar(nivelActual = self)
	const property jugador = gestorDelJugador.jugadorActual()
	
	method iniciar() {
		const musica = new Sonido() //la clase Sonido esta en enemigos
		
		game.clear()
		fondo.iniciar()
//		musica.musicaDeFondo()
// hay que implementar el sonido de fondo, lo dejo comentado porque rompe
		game.addVisual(jugador)
		gestorDelJugador.partesDelJugador()
		
		config.configurarMecanicas()
	}
}

class Nivel1 inherits Nivel{
	
	method enemigos(){
		return [new NavePequenia()]
	}
}

class Nivel2 inherits Nivel{
	
	method enemigos(){
		return [new NavePequenia(), 
				new NavePequenia(), 
				new NaveMediana()]
	}
}

class Nivel3 inherits Nivel{
	
	method enemigos(){
		return [new NavePequenia(),
				new NavePequenia(),
				new NavePequenia(),
				new NaveMediana(),
				new NaveMediana(),
				new NaveGrande()]
	}
}

class Nivel4 inherits Nivel{
	
	method enemigos(){
		return []
	}
}
import wollok.game.*
import configuraciones.*
import hangarDelJugador.*
import enemigos.*

object gestorDeNiveles {

	var property nivelActual = new Nivel1()

	method cambiarNivel(nivel) {
		nivelActual = nivel
	}

	method resetearJugador() {
		gestorDelJugador.resetJugador()
	}

	method iniciarNivel() {
//		game.clear()
		self.resetearJugador()
		nivelActual.iniciar()
	}

}

class Nivel {

	const property hangar = new Hangar(nivelActual = self)
	const property jugador = gestorDelJugador.jugadorActual()
	var property enemigosAsesinados = 0

	method iniciar() {
		const musica = new Sonido() // la clase Sonido esta en enemigos
		game.clear()
		fondo.iniciar()
//		musica.musicaDeFondo()
// hay que implementar el sonido de fondo, lo dejo comentado porque rompe
		game.addVisual(jugador)
		gestorDelJugador.partesDelJugador()
		config.configurarMecanicas()
	}

	method pasarNivel() {
		if (enemigosAsesinados >= self.enemigosRequeridos()) {
			self.siguienteNivel()
		}
	}

	method enemigosRequeridos() {
		return 100
	}

	method aumentarContador() {
		enemigosAsesinados += 1
		self.pasarNivel()
	}

	method siguienteNivel()

}

class Nivel1 inherits Nivel {

	const property enemigosRequeridos = 3

	method enemigos() {
		return [ new NavePequenia() ]
	}

	override method enemigosRequeridos() {
		return enemigosRequeridos
	}

	override method siguienteNivel() {
//		game.clear()
		gestorDeNiveles.cambiarNivel(new Nivel2())
		gestorDeNiveles.iniciarNivel()
	}

}

class Nivel2 inherits Nivel {

	const property enemigosRequeridos = 3

	method enemigos() {
		return [ new NavePequenia(), new NavePequenia(), new NaveMediana() ]
	}

	override method enemigosRequeridos() {
		return enemigosRequeridos
	}

	override method siguienteNivel() {
//		game.clear()
		gestorDeNiveles.cambiarNivel(new Nivel3())
		gestorDeNiveles.iniciarNivel()
	}

}

class Nivel3 inherits Nivel {

	const property enemigosRequeridos = 3

	method enemigos() {
		return [ new NavePequenia(), new NavePequenia(), new NavePequenia(), new NaveMediana(), new NaveMediana(), new NaveGrande() ]
	}

	override method enemigosRequeridos() {
		return enemigosRequeridos
	}

	override method siguienteNivel() {
		game.clear()
		gestorDeNiveles.cambiarNivel(new Nivel4())
		gestorDeNiveles.iniciarNivel()
	}

}

class Nivel4 inherits Nivel {

	const property enemigosRequeridos = 1

	method enemigos() {
		return []
	}

	override method siguienteNivel() {
		game.stop()
	}

}


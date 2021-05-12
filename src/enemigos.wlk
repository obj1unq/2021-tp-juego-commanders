import wollok.game.*
import ataques.*

object navePequenia {
	var property vida = 100
	
	method position() {
		return game.at(25,20)
	}
	
	method imagen() {
		return "nave1.png"
	}
	
	method disparar() {
		game.addVisual(disparo)
	}
}

object naveMediana {
	var property vida = 250
	
	method position() {
		return game.at(25,25)
	}
	
	method imagen() {
		return "nave2.png"
	}
	
	method disparar() {
		game.addVisual(disparo)
	}
}

object naveGrande {
	var property vida = 500
	
	method position() {
		return game.at(25,40)
	}
	
	method imagen() {
		return "nave3.png"
	}
	
	method disparar() {
		game.addVisual(disparo)
	}
}
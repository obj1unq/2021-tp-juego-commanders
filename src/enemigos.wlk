import wollok.game.*

object navePequenia {
	var property vida = 100
	
	method position() {
		return game.at(5,2)
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
		return game.at(5,5)
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
		return game.at(5,8)
	}
	
	method imagen() {
		return "nave2.png"
	}
	
	method disparar() {
		game.addVisual(disparo)
	}
}
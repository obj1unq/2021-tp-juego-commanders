import wollok.game.*
import ataques.*

object navePequenia {
	var property vida = 100
	
	method position() {
		return game.at(25,10)
	}
	
	method image() {
		return "nave.png"
	}
	
	method disparar() {
		game.addVisualIn(disparo, self.position().left(20))
	}
}

object naveMediana {
	var property vida = 250
	
	method position() {
		return game.at(25,25)
	}
	
	method image() {
		return "nave.png"
	}
	
	method disparar() {
		game.addVisualIn(disparo, self.position().left(20))
	}
}

object naveGrande {
	var property vida = 500
	
	method position() {
		return game.at(25,40)
	}
	
	method image() {
		return "nave.png"
	}
	
	method disparar() {
		game.addVisualIn(disparo, self.position().left(20))
	}
	
	method dispararTodoElTiempo() {
		game.onTick(2000, "naveDispara", {self.disparar()})
	}
}
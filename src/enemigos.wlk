import wollok.game.*
import ataques.*

object navePequenia {
	var property vida = 100
	const property tipo = "enemigo"
	
	method position() {
		return game.at(25,10)
	}
	
	method image() {
		return "nave.png"
	}
	
	method disparar() {
		game.addVisual(new DisparoEnemigo(position = self.position().left(5)))
	}
	
}

object naveMediana {
	var property vida = 250
	const property tipo = "enemigo"
	
	method position() {
		return game.at(25,25)
	}
	
	method image() {
		return "nave.png"
	}
	
	method disparar() {
		game.addVisual(new DisparoEnemigo(position = self.position().left(5)))
	}
	
}

object naveGrande {
	var property vida = 500
	const property tipo = "enemigo"
	
	method position() {
		return game.at(25,40)
	}
	
	method image() {
		return "nave.png"
	}
	
	method disparar() {
		game.addVisual(new DisparoEnemigo(position = self.position().left(5)))
	}
	
}
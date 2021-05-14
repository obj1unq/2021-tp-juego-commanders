import wollok.game.*
import ataques.*

class NavePequenia {
	var property vida = 100
	const property tipo = "enemigo"
	var property position = game.at(30.randomUpTo(40), 10.randomUpTo(40))
	
	method image() {
		return "nave1.png"
	}
	
	method disparar() {
		game.addVisual(new DisparoEnemigo(position = self.position().left(1)))
	}
	
}

class NaveMediana {
	var property vida = 250
	const property tipo = "enemigo"
	var property position = game.at(30.randomUpTo(40), 10.randomUpTo(40))
	
	method image() {
		return "nave2.png"
	}
	
	method disparar() {
		game.addVisual(new DisparoEnemigo(position = self.position().left(1)))
	}
	
}

class NaveGrande {
	var property vida = 500
	const property tipo = "enemigo"
	var property position = game.at(30.randomUpTo(40), 10.randomUpTo(40))
	
	method image() {
		return "nave3.png"
	}
	
	method disparar() {
		game.addVisual(new DisparoEnemigo(position = self.position().left(1)))
	}
	
}
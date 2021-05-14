import wollok.game.*
import ataques.*

class NavePequenia {
	var property vida = 100
	const property tipo = "enemigo"
	var property position = null
	
	method position() {
		if (position == null) {
			position = posicion.random()
			return position
		}
		else {return position}
	}
	
	method image() {
		return "nave-chica.png"
	}
	
	method disparar() {
		game.addVisual(new DisparoEnemigo(position = self.position().left(1)))
	}
	
}

class NaveMediana {
	var property vida = 250
	const property tipo = "enemigo"
	var property position = null
	
	method position() {
		if (position == null) {
			position = posicion.random()
			return position
		}
		else {return position}
	}
	
	method image() {
		return "nave-mediana.png"
	}
	
	method disparar() {
		game.addVisual(new DisparoEnemigo(position = self.position().left(1)))
	}
	
}

class NaveGrande {
	var property vida = 500
	const property tipo = "enemigo"
	var property position = null
	
	method position() {
		if (position == null) {
			position = posicion.random()
			return position
		}
		else {return position}
	}
	
	method image() {
		return "nave-grande.png"
	}
	
	method disparar() {
		game.addVisual(new DisparoEnemigo(position = self.position().left(1)))
	}
	
}

class Jugador {
	var property vida = 1000
	const property tipo = "jugador"
	
	method position() {
		//habría que ponerle una posición fija dentro de la pantalla de inicio
		return game.at(0,25)
	}
	
	method image() {
		return "player1.png"
	}
	
	method disparar() {
		game.addVisual(new DisparoEnemigo(position = self.position().right(1)))
	}
	
}


object posicion {
	const posibles = [game.at(30,0), game.at(30,10), game.at(30,20), game.at(30,30), game.at(30,40)]
	
	method random() {
		return posibles.anyOne()
	}
}
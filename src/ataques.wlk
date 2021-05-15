import wollok.game.*

class Disparo {
	//Debemos setearle el daño y la posicion cada vez que se instancia un disparo.
	var property damage
	var property position
	
	method damage(){
		return damage
	}
	
	method image(){
		return "disparoAzul.png"
	}

	method irA(nuevaPosicion){
		position = nuevaPosicion
	}
	
	method moverse(){
		game.onTick(50,"Movimiento Disparo", {
			
			self.irA(self.position().right(1))
		})
	}	
}

object lanzallamas {
	const damage = 40
	var property position
	
	method image(){
		return "lanzallamas.png"
	}
	
	method damage(){
		return damage
	}
	
	method irA(nuevaPosicion){
		position = nuevaPosicion
	}
}
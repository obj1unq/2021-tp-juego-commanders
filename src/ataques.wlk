import wollok.game.*

class Disparo {
	//Debemos setearle el daño y la posicion cada vez que se instancia un disparo.
	var property damage
	var property position
	
	method damage(){
		return damage
	}
	
	method image(){
		return "bulletBlue.png"
	}

	method irA(nuevaPosicion){
		position = nuevaPosicion
	}
	
	method moverse(){
		game.onTick(50,"Movimiento Disparo", {
			self.desactivarMovimiento()
			self.irA(self.position().left(1))
		})
	}
	method desactivarMovimiento() {
		if(self.position().x() <= -10){
			game.removeTickEvent("Movimiento Disparo")
			game.removeVisual(self)
		} 
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
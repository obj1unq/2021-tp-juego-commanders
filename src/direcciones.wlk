import wollok.game.*

object arriba {
	
	method moverSiPuede(algo){
		if(!(algo.position().y() == 7)){
			self.mover(algo)
		}
		else {
			algo.direccion(abajo)
			abajo.mover(algo)
		}
	}
	
	method mover(algo){
		algo.position(algo.position().up(1))
	}
}

object abajo {
	
	method moverSiPuede(algo){
		if(!(algo.position().y() == 0)){
			self.mover(algo)
		}
		else {
			algo.direccion(arriba)
			arriba.mover(algo)
		}
	}
	
	method mover(algo){
		algo.position(algo.position().down(1))
	}
}

object izquierda {
	
	method moverSiPuede(algo){
		if(!(algo.position().x() == 0)){
			self.mover(algo)
		}
		else {
			algo.direccion(derecha)
			derecha.mover(algo)
		}
	}
	
	method mover(algo){
		algo.position(algo.position().left(1))
	}
}

object derecha {
	
	method moverSiPuede(algo){
		if(!(algo.position().x() == 20)){
			self.mover(algo)
		}
		else {
			algo.direccion(izquierda)
			izquierda.mover(algo)
		}
	}
	
	method mover(algo){
		algo.position(algo.position().right(1))
	}
}
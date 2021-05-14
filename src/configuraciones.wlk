import wollok.game.*
import enemigos.*

object nivel1 {
	method iniciar(){
		game.addVisual(new NavePequenia())
		game.addVisual(new NaveMediana())
		game.addVisual(new NaveGrande())
		game.addVisual(new Jugador())//jugador está en el wlk de enemigos... lo puse ahí para probarlo
		
		config.configuracionTeclas()
		config.dispararTodoElTiempo()
	}
}

object config {
	method configuracionTeclas(){
		keyboard.w().onPressDo({/* accion*/})
		keyboard.s().onPressDo({/* */})
		keyboard.a().onPressDo({/* */})
		keyboard.d().onPressDo({/* */})
	}
	
	method dispararTodoElTiempo(){
		game.onTick(2000, "enemigos", {self.enemigosDisparar()})
	}
	
	method enemigosDisparar(){
		self.enemigosEnPantalla().forEach{enemigo=>enemigo.disparar()}
	}
	
	method enemigosEnPantalla(){
		return game.allVisuals().filter{objeto=>objeto.tipo()=="enemigo"}
	}
}


import wollok.game.*
import enemigos.*

object nivel1 {
	method iniciar(){
		//game.addVisual(new NavePequenia())
		//game.addVisual(new NaveMediana())
		//game.addVisual(new NaveGrande())
		game.addVisual(new Jugador())//jugador está en el wlk de enemigos... lo puse ahí para probarlo
		
		config.configuracionTeclas()
		config.aparicionEnemigosAleatorios()
	}
}

object config {
	method configuracionTeclas(){
		keyboard.w().onPressDo({/* accion*/})
		keyboard.s().onPressDo({/* */})
		keyboard.a().onPressDo({/* */})
		keyboard.d().onPressDo({/* */})
		keyboard.space().onPressDo({/* */})//Tecla para el disparo del jugador.
	}
	
	method aparicionEnemigosAleatorios(){
		//Aca hay que hacer que se vayan creando cada cierto tiempo un enemigo.
		const enemigo = new NavePequenia()
		game.addVisual(enemigo)
		enemigo.dispararTodoElTiempo()
	}
	/* 
	method enemigosDisparar(){
		self.enemigosEnPantalla().forEach{enemigo=>enemigo.disparar()}
	}
	
	method enemigosEnPantalla(){
		return game.allVisuals().filter{objeto=>objeto.tipo()=="enemigo"}
	}
	* 
	*/
}


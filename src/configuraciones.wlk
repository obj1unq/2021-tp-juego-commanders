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
		//game.onTick(2000, "disparoAutomatico", {config.enemigosDisparar()})
		game.schedule(27000, {game.removeTickEvent("enemigoAleatorio")})
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
		var enemigo
		//cada cierto tiempo aparece un enemigo aleatorio
		game.onTick(5000, "enemigoAleatorio" , {
			enemigo = self.enemigoAleatorio()
			game.addVisual(enemigo)
			enemigo.dispararTodoElTiempo()	
		})
	}
	
	method enemigoAleatorio(){
		//lista de los posibles enemigos a aparecer
		const enemigo = [new NavePequenia(), new NaveMediana(), new NaveGrande()]
		return enemigo.anyOne()
	}
	
	//tuve que activar los ultimos 2 metodos para mandarles instrucciones a todos los enemigos en pantalla
	method enemigosDisparar(){
		self.enemigosEnPantalla().forEach{enemigos=>enemigos.disparar()}
	}
	
	method enemigosEnPantalla(){//este metodo utiliza el tipo "enemigo" para hacer que todos disparen
		return game.allVisuals().filter{objeto=>objeto.tipo()=="enemigo"}
		//tuve que hacer que el resto de objetos tambien entendieran el mensaje tipo() para evitar que rompan el programa
	}
	
	
}


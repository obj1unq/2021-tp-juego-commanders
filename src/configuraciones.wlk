import wollok.game.*
import enemigos.*

object nivel1 {
	method iniciar(){
		//game.addVisual(new NavePequenia())
		//game.addVisual(new NaveMediana())
		//game.addVisual(new NaveGrande())
		game.addVisual(jugador)//jugador está en el wlk de enemigos... lo puse ahí para probarlo
		
		config.configuracionTeclas()
		config.aparicionEnemigosAleatorios()
		game.onTick(2000, "disparoAutomatico", {config.enemigosDisparar()})
		game.schedule(27000, {game.removeTickEvent("enemigoAleatorio")})
	}
}

object config {
	
	method configuracionTeclas(){
		keyboard.w().onPressDo({jugador.irA(jugador.position().up(1))})
		keyboard.s().onPressDo({jugador.irA(jugador.position().down(1))})
		keyboard.a().onPressDo({jugador.irA(jugador.position().left(1))})
		keyboard.d().onPressDo({jugador.irA(jugador.position().right(1))})
		keyboard.space().onPressDo({/* */})//Tecla para el disparo del jugador.
	}
	
	method aparicionEnemigosAleatorios(){
		//cada cierto tiempo aparece un enemigo aleatorio
		
		game.onTick(5000, "enemigoAleatorio" , {game.addVisual(self.enemigoAleatorio())})
		//la frecuencia con la que aparece un enemigo es 5000
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


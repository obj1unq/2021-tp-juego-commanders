import wollok.game.*
import enemigos.*

object nivel1 {
	method iniciar(){
		game.addVisual(navePequenia)
		game.addVisual(naveMediana)
		game.addVisual(naveGrande)
		
		self.configuracionTeclas()
	}
	
	method configuracionTeclas(){
		keyboard.w().onPressDo({/* accion*/})
		keyboard.s().onPressDo({/* */})
		keyboard.a().onPressDo({/* */})
		keyboard.d().onPressDo({/* */})
	}
	
}

import wollok.game.*
import ataques.*
import configuraciones.*
import hangarDelJugador.*
import niveles.*

class Hangar {
	
	const nivelActual
	const property enemigosEnJuego = []

	method generarEnemigoSiSeRequiere() {
		if (self.seRequiereEnemigo()) {
			self.generarEnemigo()
		}
	}

	method seRequiereEnemigo() {
		return (enemigosEnJuego.size() <= 3) and (nivelActual.enemigos().size()>0)
//		return game.allVisuals().filter{ objeto => objeto.tipo() == "enemigo" }.size() <= 3
	} 

	method generarEnemigo() {
		const enemigoNuevo = self.enemigoAleatorio()
		game.addVisual(enemigoNuevo)
		enemigoNuevo.configurarColisiones()
		enemigoNuevo.crearPartesDeLaNave()
		enemigoNuevo.dispararTodoElTiempo()
		enemigoNuevo.moverseTodoElTiempo()
		enemigosEnJuego.add(enemigoNuevo)
	}

	method enemigoAleatorio() {
		return nivelActual.enemigos().anyOne()
	}

	method eliminarEnemigo(enemigo) {
		enemigosEnJuego.remove(enemigo)
	}

}

class Sonido {
	const property disparo = game.sound("disparo.mp3")
//	const property fondo = game.sound("musicaFondo.mp3")
	
//	method musicaDeFondo(){
//		fondo.play()
//		game.onTick(20000, "musicaDeFondo", {
//			fondo.stop()
//			fondo.play()
//		})
//	}
}

class Nave {
	const property id = 0.randomUpTo(10000)
	const property tipo = "enemigo"
	var property position = game.at(21,0)//game.at(10.randomUpTo(20), 0.randomUpTo(10))
	const property partes = []

//	const disparoSonido = game.sound("disparo.mp3")
	
	override method initialize(){
		game.onCollideDo(self, {algo=>self.teEncontro(algo)})
		
	}
	
	method configurarColisiones(){
		config.configurarColisiones(self)
		partes.forEach({parte=>config.configurarColisiones(parte)})
	}
	
	method dispararTodoElTiempo() {
		game.onTick(1000, "disparo"+self.nombre(), { self.disparar()})
	}

	method disparar() {
		const disparo=new DisparoEnemigo(damage=20,position=self.position().left(1))
		game.addVisual(disparo)
		new Sonido().disparo().play()
		disparo.movimientoConstante()
//		gestorDeDisparos.disparar(20, self.position())
	}

	method desaparecer() {
		const explosion = new Explosion(position = self.position())
		
		game.removeTickEvent("movimiento"+self.nombre())
		game.removeTickEvent("disparo"+self.nombre())
		gestorDeNiveles.nivelActual().hangar().eliminarEnemigo(self)
		game.addVisual(explosion)
		explosion.animacion()
		gestorDeNiveles.nivelActual().aumentarContador()
		partes.forEach({parte=>parte.desaparecer()})
		game.removeVisual(self)
	}
	
	method nombre() {
		return id.toString()
	}
	
	method moverseTodoElTiempo(){
		game.onTick(self.velocidad(),"movimiento"+self.nombre(), {self.movimiento()})
	}
	
	method movimiento() {
		if (self.posicionDentroDePantalla()) {
			self.iaMovimiento()
		}
		else {
			self.desaparecer()
		}
	}
	
	method posicionDentroDePantalla() {
		return (position.x()>=0 && 
				position.x()<=20 &&
				position.y()>=-1 &&
				position.y()<=10
		)
	}

	method iaMovimiento() {
		self.irA(self.position().left(1))
	}

	method irA(nuevaPosicion) {
		position = nuevaPosicion
	}
	
	method velocidad() {
		return 800
	}

	method teEncontro(algo) {
		algo.chocar(self)
	}

	method chocar(algo) {
	}

	method moverseSiEstaEnPantalla() {
		if (self.position().x() <= -10) {
			self.desaparecer()
		} else {
			self.iaMovimiento()
		}
	}
	
	method recibirDisparo(disparo){
		self.perderVida(disparo.damage())
		disparo.desaparecer()
	}
	
	method perderVida(danio)
	
	method agregarParte(x,y){
		const parte = new Proxy(original = self, x = x, y = y)
		game.addVisual(parte)
		partes.add(parte)
	}
}

class NavePequenia inherits Nave {

	var property vida = 100
	var property direccion = "arriba"
	
	override method partes(){
		return[]
	}

	method image() {
		return "naveEnemiga1.png"
	}
	
	method crearPartesDeLaNave(){
		self.agregarParte(1,0)
	}
	
	override method iaMovimiento() {
		self.cambiarDireccionSiEsNecesario()
		self.irA(game.at(self.position().x()-1, self.direccionActual()))
	}
	
	method direccionActual() {
		if (direccion == "arriba") {
			return self.position().y()+1
		}
		else if (direccion == "abajo") {
			return self.position().y()-1
		}
		else {
			return 666 // esto nunca va a pasar
		}
		
	}
	
	method cambiarDireccionSiEsNecesario() {
		if (self.position().y()>=9) {
			direccion = "abajo"
		}
		else if (self.position().y()<=0) {
			direccion = "arriba"
		}
	}
	
	override method velocidad() {
		return 300
	}
	
	override method perderVida(danio){
		vida -= danio
	}
}

class NaveMediana inherits Nave {

	var property vida = 250
	var property direccion = "arriba"
	var property contadorDePasos = 5

	method image() {
		return "naveEnemiga2.png"
	}
	
	method crearPartesDeLaNave(){
		self.agregarParte(1,0)
		self.agregarParte(2,0)
	}
	
	override method iaMovimiento() {
		if (self.estaEnBorde() && contadorDePasos > 0) {
			self.irA(self.position().left(1))
			contadorDePasos -= 1
		}
		else if (contadorDePasos == 0) {
			self.cambiarDireccion()
			self.irA(self.direccionActual())
			contadorDePasos = 5
		}
		else {
			self.irA(self.direccionActual())
		}
	}
	
	method direccionActual() {
		if (direccion == "arriba") {
			return game.at(self.position().x(),self.position().y()+1)
		}
		else if (direccion == "abajo") {
			return game.at(self.position().x(),self.position().y()-1)
		}
		else {
			return game.at(666,666) // esto nunca va a pasar
		}
	}
	
	method cambiarDireccion() {
		if (direccion == "arriba"){
			direccion = "abajo"
		}
		else {
			direccion ="arriba"
		}
	}
	
	method estaEnBorde() {
		return 	self.position().y()<=0 ||
				self.position().y()>=9
	}
	
	override method velocidad() {
		return 500
	}
	
	override method perderVida(danio){
		vida -= danio
	}
}

class NaveGrande inherits Nave {

	var property vida = 500

	method image() {
		return "nave-grande.png"
	}
	
	method crearPartesDeLaNave(){
		self.agregarParte(1,0)
		self.agregarParte(2,0)
		self.agregarParte(3,0)
		self.agregarParte(4,0)
	}
	
	override method perderVida(danio){
		vida -= danio
	}

}

class Jefe inherits Nave {
	var property vida = 10000
	var property subditos = []
	
	method image(){
		return "jefe.png"
	}
	
	override method perderVida(danio){
		if(subditos.isEmpty()){
			vida -= danio
		}
	}
	
	method movimientoJefe(){
		game.onTick(200, "movimientoJefe", {self.iaMovimiento()})
	}
	
	override method iaMovimiento(){
		if(!(position == self.posicionJefe())){
			position = position.left(1)
		}
		else {
			game.removeTickEvent("movimientoJefe")
			self.invocarSubditos()
			self.iaAtaque()
		}
	}
	
	method posicionJefe(){
		return game.at(16,0)
	}
	
	method invocarSubditos(){
		game.onTick(20000, "nuevoSubdito", {self.subditoNecesario()})
	}
	
	method subditoNecesario(){
		if(self.necesitaSubdito()){
			self.nuevoSubdito()
		}
	}
	
	method necesitaSubdito(){
		return subditos.size() < 2
	}
	
	method nuevoSubdito(){
		const subdito = new Subdito(jefe=self, position=game.at(10.randomUpTo(12),0.randomUpTo(7)) )
		game.addVisual(subdito)
		subditos.add(subdito)
		subdito.configurarColisiones()
		subdito.crearPartesDeLaNave()
		subdito.movimientoSubdito()
		subdito.iaAtaque()
	}
	
	method perderSubdito(subdito){
		subditos.remove(subdito)
	}
	
	method iaAtaque(){
		
	}
	
	method crearPartesDeLaNave(){
		
	}
}

class Subdito inherits Nave {
	var property vida = 500
	const jefe
	
	method image(){
		return "subdito.png"
	}
	
	override method perderVida(danio){
		vida -= danio
	}
	
	override method desaparecer(){
		jefe.perderSubdito(self)
		super()
	}
	
	method iaAtaque(){
		
	}
	
	method movimientoSubdito(){
		
	}
	
	method crearPartesDeLaNave(){
		
	}
}


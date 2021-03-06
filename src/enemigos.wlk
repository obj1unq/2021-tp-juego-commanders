import wollok.game.*
import ataques.*
import configuraciones.*
import hangarDelJugador.*
import niveles.*
import direcciones.*

object hangar {
	
	const property enemigosEnJuego = []

	method generarEnemigoSiSeRequiere(nivelActual) {
		if (self.seRequiereEnemigo()) {
			self.generarEnemigo(nivelActual)
		}
	}

	method seRequiereEnemigo() {
		return enemigosEnJuego.size() <= 3
	} 

	method generarEnemigo(nivelActual) {
		const enemigoNuevo = self.enemigoAleatorio(nivelActual)
		game.addVisual(enemigoNuevo)
		enemigoNuevo.configurarColisiones()
		enemigoNuevo.crearPartesDeLaNave()
		enemigoNuevo.dispararTodoElTiempo()
		enemigoNuevo.moverseTodoElTiempo()
		enemigosEnJuego.add(enemigoNuevo)
	}

	method enemigoAleatorio(nivelActual) {
		return nivelActual.enemigos().anyOne()
	}

	method eliminarEnemigo(enemigo) {
		enemigosEnJuego.remove(enemigo)
	}

}


class Nave {
	const property id = 0.randomUpTo(10000)
	const property tipo = "enemigo" // esto se podria referenciar a un objeto
	var property vida = 100
	var property position = game.at(21,0)
	var property partes = []
	var property direccion = arriba
	var property puntosAlDesaparecer = 50

	method configurarColisiones(){
		config.configurarColisiones(self)
		partes.forEach({parte=>config.configurarColisiones(parte)})
	}

	
	method dispararTodoElTiempo() {
		game.onTick(1000, "disparo"+self.nombre(), { self.disparar()})
	}

	method disparar() {
		const disparo=new DisparoEnemigo(damage=100,position=self.position().left(1))
		const sonidoDisparo = new SonidoDisparo()
		game.addVisual(disparo)
		sonidoDisparo.sonido()
		disparo.movimientoConstante()
	}

	method desaparecer() {
		const explosion = new Explosion(position = self.position())
		
		game.removeTickEvent("movimiento"+self.nombre())
		game.removeTickEvent("disparo"+self.nombre())
		hangar.eliminarEnemigo(self)
		game.addVisual(explosion)
		explosion.animacion()
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
		return (position.x()>=-1 && 
				position.x()<=20 &&
				position.y()>=-1 &&
				position.y()<=12
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

	method eliminar() {
		self.desaparecer()
		hangar.eliminarEnemigo(self)
		self.eliminarPartes()    
	}

	method moverseSiEstaEnPantalla() {
		if (self.position().x() <= -10) {
			self.desaparecer()
		} else {
			self.iaMovimiento()
		}
	}
	method recibirDisparoEnemigo(disparo) {} // los disparos entre las mismas naves enemigas del jugador no se da??an entre ellas
	method recibirDisparoJugador(disparo){
		estadisticas.sumarPuntos(puntosAlDesaparecer)
		self.eliminar()
		disparo.desaparecer()
	}
	
	method crearPartesDeLaNave()
	method eliminarPartes() { self.partes([]) }
	method agregarParte(x,y){
		const parte = new Proxy(original = self, x = x, y = y)
		game.addVisual(parte)
		partes.add(parte)
	}
	method chocar(algo){} // si chocan entre las naves enemigas no sucede nada
}

class NavePequenia inherits Nave {

	override method vida(){
		return 100
	}

	method image() {
		return "naveEnemiga1.png"
	}
	
	override method recibirDisparoJugador(disparo) {
		super(disparo)
		estadisticas.derriboNavePequenia()
	}

	override method crearPartesDeLaNave(){
		self.agregarParte(1,0)
	}
	
	override method iaMovimiento() {
		self.cambiarDireccionSiEsNecesario()
		self.irA(game.at(self.position().x()-1, self.direccionActual()))
	}
	
	method direccionActual() {
		if (direccion.apuntaAMisma(arriba)) { 
			return self.position().y()+1
		}
		else if (direccion.apuntaAMisma(abajo)) {
			return self.position().y()-1
		}
		else {
			return 0 // TODO: posible self.error("")
		}
		
	}
	
	method cambiarDireccionSiEsNecesario() {
		if (self.position().y()>=9) {
			direccion = abajo
		}
		else if (self.position().y()<=0) {
			direccion = arriba
		}
	}
	
	override method velocidad() {
		return 300
	}
}

class NaveMediana inherits Nave {
	var property contadorDePasos = 5

	override method puntosAlDesaparecer() = 100
	
	override method vida()	= 150

	method image() {
		return "naveEnemiga2.png"
	}
	
	override method recibirDisparoJugador(disparo) {
		super(disparo)
		estadisticas.derriboNaveMediana()
	}
	
	override method crearPartesDeLaNave(){
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
		if (direccion.apuntaAMisma(arriba)) {
			return game.at(self.position().x(),self.position().y()+1)
		}
		else if (direccion.apuntaAMisma(abajo)) {
			return game.at(self.position().x(),self.position().y()-1)
		}
		else {
			return game.at(0,0) // TODO: posible self error
		}
	}
	
	method cambiarDireccion() {
		if (direccion.puedeMover(self)){ 
			direccion = abajo
		}
		else {
			direccion = arriba
		}
	}
	
	method estaEnBorde() {
		return 	self.position().y()<=0 ||
				self.position().y()>=9
	}
	
	override method velocidad() {
		return 500
	}
}

class NaveGrande inherits Nave {

	override method vida(){
		return 300
	}
	override method puntosAlDesaparecer() = 150

	method image() {
		return "nave-grande.png"
	}
	override method recibirDisparoJugador(disparo) {
		super(disparo)
		estadisticas.derriboNaveGrande()
	}
	override method crearPartesDeLaNave(){
		self.agregarParte(1,0)
		self.agregarParte(2,0)
		self.agregarParte(3,0)
		self.agregarParte(4,0)
		self.agregarParte(1,1)
		self.agregarParte(2,1)
		self.agregarParte(3,1)
		self.agregarParte(4,1)
	}
}

class Jefe inherits Nave {
	
	var property subditos = []
	
	override method puntosAlDesaparecer() = 1000
	
	override method vida(){
		return 800
	}
	
	method image(){
		return "jefe.png"
	}
	
	method perderVida(danio){
		if(subditos.isEmpty()){
			vida -= danio
		}
	}
	
	override method recibirDisparoJugador(disparo){
		self.perderVida(disparo)
		disparo.desaparecer()
		self.meVencio()
	}
	method meVencio(){ 
		if(vida== 0) {
			self.desaparecer()
			jugador.gano()
			
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
		const subdito = new Subdito(jefe=self, position=game.at(15,3) )
		game.addVisual(subdito)
		subditos.add(subdito)
		subdito.configurarColisiones()
		subdito.crearPartesDeLaNave()
		subdito.movimientoInicial()
		subdito.iaAtaque()
	}
	
	method perderSubdito(subdito){
		if(subdito.vida()==0){
			estadisticas.sumarPuntos(subdito.puntosAlDesaparecer())
			subdito.desaparecer()
			subditos.remove(subdito)
		}
	}
	
	method iaAtaque(){
		game.onTick(15000,"ataqueJefe", {self.ataqueJefe()})
	}
	
	method ataqueJefe(){
		if (self.tieneSubdito()){
			subditos.anyOne().iaAtaque()
		}
		else {
			self.ultimate()
		}
	}
	
	method tieneSubdito(){
		return !(subditos.isEmpty())
	}
	
	method ultimate(){
		//TODO: agregar el ataque que usara el jefe cuando no tenga subditos
	}
	
	override method crearPartesDeLaNave(){
		self.agregarParte(0,1)
		self.agregarParte(0,2)
		self.agregarParte(0,3)
		self.agregarParte(0,4)
		self.agregarParte(1,1)
		self.agregarParte(1,2)
		self.agregarParte(1,3)
		self.agregarParte(1,4)
	}
}

class Subdito inherits Nave {
	
	const jefe
	const ataques = [embestida]
	
	override method puntosAlDesaparecer() = 500
	override method vida(){
		return 400
	}
	
	method image(){
		return "subdito.png"
	}
	
	method perderVida(disparo){
		vida -= disparo.damage()
		self.desaparecerSiCorresponde()
	}
	
	override method recibirDisparoJugador(disparo){
		self.perderVida(disparo)
		disparo.desaparecer()
	}
	
	method desaparecerSiCorresponde(){
		jefe.perderSubdito(self)
	}
	
	method iaAtaque(){
		game.schedule(5000,{ataques.anyOne().usar(self)})
	}
	
	method movimientoInicial(){
		game.onTick(200,"movimientoInicial"+self.nombre(),{self.iaMovimientoInicial()})
	}
	
	method iaMovimientoInicial(){
		if (!(position.x()==10)){
			position = position.left(1)
		}
		else {
			game.removeTickEvent("movimientoInicial"+self.nombre())
			self.movimientoSubdito()
		}
	}
	
	method movimientoSubdito(){
		game.onTick(200, "movimientoSubdito", {self.iaMovimiento()})
	}
	
	override method iaMovimiento(){
		direccion.moverSiPuede(self)
	}
	
	override method crearPartesDeLaNave(){
		self.agregarParte(1,0)
		self.agregarParte(2,0)
		self.agregarParte(1,1)
		self.agregarParte(2,1)
	}
}


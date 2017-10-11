class Estado {
	
	var duenio
	
	constructor(_duenio) {
		duenio = _duenio
	}
	
	method estaContento() = false
}

class Contento inherits Estado {
	method comer() {
		duenio.ponerseMasFeliz(1)
	}
	
	override method estaContento() = true
}

class Hambriento inherits Estado {
	method comer() {
		duenio.ponerseContento()
	}
}

class Triste inherits Estado {
	var cuandoSePusoTriste = new Date()

	method cuandoSePusoTriste(_fecha) {
		cuandoSePusoTriste = _fecha	
	}
	
	method comer() {
		if (self.estaTristeHaceMucho()) {
			duenio.ponerseContento()
		} else {
			error.throwWithMessage("No es correcto que coma si está triste hace poco")
		}
	}
	
	method estaTristeHaceMucho() = (new Date() - cuandoSePusoTriste) > 1 
}

class Tamagotchi {

	var estado
	var felicidad = 0
	
	constructor() {
		self.ponerseContento()
	}
	
	method comer() {
		estado.comer()		
	}	

	method ponerseMasFeliz(cuanto) {
		felicidad += cuanto
	}

	method estado() = estado	
	method felicidad() = felicidad
	
	method estaContento() = estado.estaContento()
	
	method ponerseContento() {
		estado = new Contento(self)
	}
	
	method ponerseHambriento() {
		estado = new Hambriento(self)
	}	

	method ponerseTriste() {
		estado = new Triste(self)
	}	

}

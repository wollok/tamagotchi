class Estado {
	
	var duenio
	
	constructor(_duenio) {
		duenio = _duenio
	}
	
	method estaContento() = false
}

class Contento inherits Estado {
	var vecesQueJugo = 0
	
	method comer() {
		duenio.ponerseMasFeliz(1)
	}
	
	method jugarSolo() {
		duenio.ponerseMasFeliz(2)
		vecesQueJugo++
		if (vecesQueJugo > 2) {
			duenio.ponerseHambriento()
		}
	}
	
	method jugarCon(otro) {	
		otro.jugarSolo()
		duenio.ponerseMasFeliz(4)	
	}
	
	override method estaContento() = true
}

class Hambriento inherits Estado {
	method comer() {
		duenio.ponerseContento()
	}
	
	method jugarSolo() {
		duenio.ponerseMenosFeliz(4)
	}
	
	method jugarCon(otro) {	}
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
	
	method jugarSolo() {
		duenio.ponerseContento()
	}
	
	method estaTristeHaceMucho() = (new Date() - cuandoSePusoTriste) > 1
	
	method jugarCon(otro) {	
		duenio.ponerseContento()
		otro.ponerseContento()
	}
}

class Tamagotchi {

	var estado
	var felicidad = 0
	
	constructor() {
		estado = new Contento(self)
	}
	
	method comer() {
		estado.comer()		
	}	

	method jugarSolo() {
		estado.jugarSolo()
	}

	method jugarCon(otro) {
		estado.jugarCon(otro)
	}
	
	method ponerseMasFeliz(cuanto) {
		felicidad += cuanto
	}

	method ponerseMenosFeliz(cuanto) {
		self.ponerseMasFeliz(cuanto.invert())
	}

	method estado() = estado	
	method felicidad() = felicidad
	
	method estaContento() = estado.estaContento()
	
	method ponerseContento() {
		if (!self.estaContento()) {
			estado = new Contento(self)
		}
	}
	
	method ponerseHambriento() {
		estado = new Hambriento(self)
	}	

	method ponerseTriste() {
		estado = new Triste(self)
	}	

}

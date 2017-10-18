class Tamagotchi {

	/** El estado es un int, que maneja diferentes estados
		1  	contento
		2	triste
		3	hambriento
		4	cansado (a futuro)
	 */
	var estado
	var felicidad = 0
	
	// Pérdida de cohesión
	// el objeto Tamagotchi debe guardar información del estado temporal
	// que no es común para todos los estados
	var vecesQueJugo = 0
	var cuandoSePusoTriste = new Date()
	
	constructor() {
		self.ponerseContento()
	}

	method estaTristeHaceMucho() = (new Date() - cuandoSePusoTriste) > 1
	
	method comer() {
		// Contento
		if (estado == 1) {
			self.ponerseMasFeliz(1)
		}
		// Triste 
		if (estado == 2) {
			if (self.estaTristeHaceMucho()) {
				self.ponerseContento()
			} else {
				error.throwWithMessage("No es correcto que coma si está triste hace poco")
			}
		}
		// Hambriento
		if (estado == 3) {
			self.ponerseContento()
		}
	}	

	method jugarSolo() {
		// Contento
		if (estado == 1) {
			self.ponerseMasFeliz(2)
			self.actualizarVecesQueJugo()
		} else {
			// Triste 
			if (estado == 2) {
				self.ponerseContento()			
			} else {
				// Hambriento
				if (estado == 3) {
					self.ponerseMenosFeliz(4)
				}
			}
		}
	}

	method actualizarVecesQueJugo() {
		vecesQueJugo++
		if (vecesQueJugo > 2) {
			self.ponerseHambriento()
		}
	}

	method jugarCon(otro) {
		// Contento
		if (estado == 1) {
			otro.jugarSolo()
			self.ponerseMasFeliz(4)
			self.actualizarVecesQueJugo()
		}
		// Triste 
		if (estado == 2) {
			self.ponerseContento()
			otro.ponerseContento()			
		}
		// Hambriento
		if (estado == 3) {
		}
	}
	
	method ponerseMasFeliz(cuanto) {
		felicidad += cuanto
	}

	method ponerseMenosFeliz(cuanto) {
		self.ponerseMasFeliz(cuanto.invert())
	}

	method estado() = estado	
	method felicidad() = felicidad
	method cuandoSePusoTriste(fecha) { cuandoSePusoTriste = fecha }
	
	method estaContento() = estado == 1
	method estaHambriento() = self.verificarEstado(3)
	method estaTriste() = self.verificarEstado(2)
		
	method ponerseContento() {
		estado = 1 // Contento
		vecesQueJugo = 0
	}
	
	method ponerseHambriento() {
		estado = 3 // Hambriento
	}	

	method ponerseTriste() {
		estado = 2 // Triste
		cuandoSePusoTriste = new Date()
	}
	
	method verificarEstado(_estado) = estado == _estado

}

import cervezas.*
import carpas.*

class Persona {
	const property peso
	const property jarrasCompradas = []
	const property leGustaMusicaTradicional
	const property nivelDeAguante
	method estaEbria() = self.peso() * self.nivelDeAguante() < self.totalDeAlcoholIngerido()
	method leGustaCerveza(unaMarca)
	method totalDeAlcoholIngerido() = self.jarrasCompradas().sum { j => j.cantidadDeAlcohol() }
	method quiereEntrarA(unaCarpa) = self.leGustaCerveza(unaCarpa.marca()) and unaCarpa.tieneMusicaTradicional() == self.leGustaMusicaTradicional()
	method puedeEntrarA(unaCarpa) = self.quiereEntrarA(unaCarpa) and unaCarpa.dejaIngresarA(self)
	method entrarEn(unaCarpa) { unaCarpa.ingresarA(self) }
	method retirarseDe(unaCarpa) { unaCarpa.retirarA(self) }
	method esEbrioEmpedernido() = self.estaEbria() and self.jarrasCompradas().all { j => j.capacidadEnLitros() >= 1 }
	method tomarJarraDeCerveza(unaJarra) { self.jarrasCompradas().add(unaJarra) }
	method paisOrigen()
	method esPatriota() = self.jarrasCompradas().all { j => j.marca().paisOrigen() == self.paisOrigen() }
	method marcasCompradas() = self.jarrasCompradas().map({ j => j.marca() }).asSet()
	method esCompatibleCon(unaPersona) {
		const coincidencias = self.marcasCompradas().intersection(unaPersona.marcasCompradas())
		const diferencias = self.marcasCompradas().difference(unaPersona.marcasCompradas())
		//tambien contempleando cada diferencia de ambos lados:
		//const diferencias = self.marcasCompradas().union(unaPersona.marcasCompradas()).difference(coincidencias)
		return coincidencias.size() > diferencias.size()
	}
	method carpasEnLasQueBebio() = self.jarrasCompradas().map({ j => j.carpaDondeFueServida() }).asSet()
	method tamaniosDeJarrasBebidas() = self.jarrasCompradas().map({ j => j.capacidadEnLitros() }).asSet()
	method bebioJarrasDeDistintosTamanios() = self.tamaniosDeJarrasBebidas().size() == self.jarrasCompradas().size()
	method estaEntrandoEnElVicio() {
		var resultado
		if (self.bebioJarrasDeDistintosTamanios()) {
			
			resultado = true
		}
		else {
			resultado = false
		}
		return resultado
	}
	method gastoTotalEnCerveza() = self.jarrasCompradas().sum { j => j.precio() }
	method mayorPrecioDeJarra() = self.jarrasCompradas().map({ j => j.precio() }).max()
	method jarraMasCara() = self.jarrasCompradas().find({j=>j.precio() == self.mayorPrecioDeJarra()})
}

class Belga inherits Persona{
	override method leGustaCerveza(unaMarca) = unaMarca.gramosLupuloXLitro() > 4
	override method paisOrigen() = "Belgica"
}

class Checo inherits Persona{
	override method leGustaCerveza(unaMarca) = unaMarca.graduacion() > 4
	override method paisOrigen() = "Republica Checa"
}

class Aleman inherits Persona{
	override method leGustaCerveza(unaMarca) = true
	override method quiereEntrarA(unaCarpa) = super(unaCarpa) and unaCarpa.cantidadPersonasDentro().even()
	override method paisOrigen() = "Alemania"
}


import cervezas.*
import personas.*

object recargoFijo {		method recargo(unaCarpa) = 30 }
object recargoCantidad {	method recargo(unaCarpa) = if (unaCarpa.cantidadPersonasDentro() >= unaCarpa.limite() * 0.5 ) { 40 } else { 25 } }
object recargoEbriedad {	method recargo(unaCarpa) = if (unaCarpa.porcentajeDeEbrios() >= 75) { 50 } else { 20 } }

class Carpa {
	var property limite
	var property tieneMusicaTradicional
	var property marca
	var property recargoActual
	const property personasDentro = []
	method cantidadPersonasDentro() = self.personasDentro().size()
	method dejaIngresarA(unaPersona) = self.cantidadPersonasDentro() < self.limite() and not unaPersona.estaEbria()
	method ingresarA(unaPersona) {
		if (not unaPersona.puedeEntrarA(self)){ self.error("La persona no puede ingresar") }
		self.personasDentro().add(unaPersona)
	}
	method retirarA(unaPersona){
		if (not self.personasDentro().contains(unaPersona)){ self.error("La persona no esta en la carpa") }
		self.personasDentro().remove(unaPersona)
	}
	method servirJarraA(capacidadDeJarra,unaPersona){
		if (not self.personasDentro().contains(unaPersona)){ self.error("La persona no esta en la carpa") }
		unaPersona.tomarJarraDeCerveza(new JarraDeCerveza(capacidadEnLitros=capacidadDeJarra,marca=self.marca(),carpaDondeFueServida=self))
	}
	method cantidadEbriosEmpedernidos() = self.personasDentro().count { p => p.esEbrioEmpedernido() }
	method esHomogenea() = self.personasDentro().map({ p => p.paisOrigen() }).asSet().size() == 1
	method asistentesNoServidos() = self.personasDentro().filter({ p => not p.carpasEnLasQueBebio().contains(self) })
	method porcentajeDeEbrios() = self.personasDentro().count({ p => p.estaEbria() }) / self.cantidadPersonasDentro() * 100
	method precioPorLitro() = self.marca().precioBasePorLitro() * ( 1 + (self.recargoActual().recargo(self) * 0.01) )
}

object graduacionReglamentaria{
	var property graduacion = 5
}

class Cerveza {
	const property gramosLupuloXLitro
	const property paisOrigen
	const property precioBasePorLitro
	method graduacion()
	method alcoholXLitro()
	
}

class Rubia inherits Cerveza{
	const property graduacion
	override method alcoholXLitro() = self.graduacion() * 0.01
}

class Negra inherits Cerveza{
	override method graduacion() = graduacionReglamentaria.graduacion().min(self.gramosLupuloXLitro() * 2)
	override method alcoholXLitro() = self.graduacion() * 0.01
}

class Roja inherits Negra{
	override method graduacion() = super() * 1.25
}

class JarraDeCerveza{
	const property capacidadEnLitros
	const property marca
	const property carpaDondeFueServida
	const property precio = self.carpaDondeFueServida().precioPorLitro() * self.capacidadEnLitros()
	method cantidadDeAlcohol() = self.capacidadEnLitros() * self.marca().alcoholXLitro()
}


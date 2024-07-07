import wollok.game.*
import juego.*
import pantalla.*
import tablero.*
import cartas.*

class Casillero{ //Clase Base
	var property position
	const img
	
	method image() = img
	method esCasilleroEspecial() = false
	method esProvincia() = false
	method esTren() = false
}

class Provincia inherits Casillero{
	var titular = banco
	
	override method esProvincia() = true
	method costo() = 400
	method alquiler() = self.costo() * 0.5
	
	method titular() = titular
	method transferirA(nuevoTitular){titular = nuevoTitular}
	method esDelBanco() = banco.misPropiedades().contains(self)
}

class Tren inherits Provincia{
	override method esProvincia() = false
	override method esTren() = true
	override method costo() = 1000
}

class CasilleroEspecial inherits Casillero{
	override method esCasilleroEspecial() = true
}

object salida{
	method esCasilleroEspecial() = true
	method position() = game.at(8,0)
	method image() = "casilleros/salida.png"
	
	method activarCasillero(){
		turno.playerOnTurn().cobrarSalario()
		const cobrasDoble = new Popup(img="popups/cobrasDoble.png",position=game.at(1,2))
		cobrasDoble.addVisual()
		game.schedule(2000,{ cobrasDoble.removeVisual() })
	}
}

class Carcel inherits CasilleroEspecial{
	method activarCasillero(){
		turno.playerOnTurn().caePreso()
		game.sound("sounds/guardia.mp3").play()
		const preso = new Popup(img="popups/preso.png",position=game.at(2,2))
		preso.addVisual()
		game.schedule(2500,{preso.removeVisual()})
	}
}

class CasilleroSuerte inherits CasilleroEspecial{
	method activarCasillero(){
		const randomLuckyCard = new Suerte()
		randomLuckyCard.activar()
	}
}

class CasilleroMufa inherits CasilleroEspecial{
	method activarCasillero(){
		const randomMufaCard = new Mufa()
		randomMufaCard.activar()
	}
}

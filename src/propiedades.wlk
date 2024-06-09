import wollok.game.*
import juego.*
import pantalla.*
import tablero.*
import cartas.*

class Casillero{ //Clase Base
	var property position
	var img
	
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
	const property tipo
	
	override method esCasilleroEspecial() = true
	
	method activarCasillero(){
		const ubicacion = juego.playerOnTurn().currentLocation()
		if (ubicacion.tipo() == "Salida"){
			juego.playerOnTurn().cobrarSalario()
			const cobrasDoble = new Popup(img="popups/cobrasDoble.png",position=game.at(1,2))
			cobrasDoble.addVisual()
			game.schedule(2000,{ cobrasDoble.removeVisual() })
			
		}else if (ubicacion.tipo() == "Suerte"){
			const randomLuckyCard = new Suerte()
			randomLuckyCard.activar()
			
		}else if(ubicacion.tipo() == "Carcel"){
			juego.playerOnTurn().caePreso()
			game.sound("sounds/guardia.mp3").play()
			const preso = new Popup(img="popups/preso.png",position=game.at(2,2))
			preso.addVisual()
			game.schedule(2500,{preso.removeVisual()})
			
		}else if (ubicacion.tipo() == "Mufa"){
			const randomMufaCard = new Mufa()
			randomMufaCard.activar()
		}		
	}
}

class Label inherits Visual{}
import wollok.game.*
import juego.*

class Visual{
    var property position = game.at(0,0)
    var img = ""

    method image() = img
    
    method addVisual(){
    	if (!game.hasVisual(self)){
    		game.addVisual(self)
    	}
    }
    
    method removeVisual(){
    	if (game.hasVisual(self)){
    		game.removeVisual(self)
    	}
    }

}

class Fondo inherits Visual{
}

class Popup inherits Visual{

	override method addVisual(){
		if (!game.hasVisual(self)){
		juego.popupEnPantalla().add(self)
		}
		super()

	}
	
	override method removeVisual(){
		if (game.hasVisual(self)){
		juego.popupEnPantalla().remove(self)
		}
		super()
	}
}

class Selector inherits Visual{
	method moveDown(){
		if(position.y() > 6) position = position.down(1)
	}
	
	method moveUp(){
		if(position.y() < 8) position = position.up(1)
	}
}

class Instrucciones inherits Visual{
	override method position() = game.at(2,2)
}

class Animation inherits Visual{
	var frame = 1
	const fps = 500
	
	override method image() = img + frame.toString() + ".png"
	
	method fps() = fps
	
	method animation(cantidadDeFrames){
    	frame = if (frame < cantidadDeFrames) frame+1 else 1
    	game.schedule(self.fps(), { => self.animation(cantidadDeFrames) })
    }
}

class IndicadorJugador inherits Animation{
	override method image() = "UI/playerOnTurn" + juego.playerOnTurn().numero() + "-" + frame + ".png"
}

class WinScreen inherits Animation{
	var ganador =
		if (jugadores.size()>1){
			jugadores.filter({ j => j.deuda() == 0 }).max({ j => j.dinero()})
		}else{
			jugadores.first()}
	
	override method image() = "fondos/victoria-" + self.ganador().nombre() + "-" + frame.toString() + ".png"

	method ganador() = ganador

}

 class DineroModifier inherits Animation{

 	override method position() = game.at(5,1)
 	
 	override method image() = "UI/" + super() 
 	
 	//Activa la animación y además lo agrega y luego remueve del tablero.
 	override method animation(cantidadDeFrames){ //CantDeFrames=4 al invocar
		self.addVisual()
		game.onTick(250, "moneyAnimation", { frame = if (frame < cantidadDeFrames) frame+1 else 1})
		game.schedule(1000,{
			game.removeTickEvent("moneyAnimation")
			self.removeVisual()
		})
	}

	//Animación de dinero al comprar Tren o Provincia
	method comprarProvinciaOTren(){
		if (juego.playerOnTurn().currentLocation().esProvincia()){
			const comprarPropiedad = new DineroModifier(img="menos400-")
			comprarPropiedad.animation(4)
		}else{
			const comprarTren = new DineroModifier(img="menos1000-")
			comprarTren.animation(4)			
		}
	}
	
	method transferencia(){
		if (juego.playerOnTurn().currentLocation().esProvincia()){
			const transferirPropiedad = new DineroModifier(img="menos600-")
			transferirPropiedad.animation(4)
		}else{
			const comprarTren = new DineroModifier(img="menos1500-")
			comprarTren.animation(4)
		}
	}
 
 }
 
class MarcadorDuenio{
	var property position = juego.playerOnTurn().position()
	const img = juego.playerOnTurn().nombre()
	method image() = "registros/" + img + ".png"
}



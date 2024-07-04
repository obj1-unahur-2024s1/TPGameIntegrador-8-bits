import wollok.game.*
import juego.*
import pantalla.*
import jugadores.*
import tablero.*


object teclado{
	
	method configuracion(){
		//Movimientos de Selector
		keyboard.up().onPressDo{if (!juego.partidaIniciada())
			tablero.selector().moveUp()}
		keyboard.down().onPressDo{if (!juego.partidaIniciada())
			tablero.selector().moveDown()}
	
		//Empezar partida (Selecciona cantidad de jugadores, elimina Start Menu y genera el tablero)
		keyboard.enter().onPressDo{
		const player1 = new Player(img = "registros/jugador1.png", nombre="player1",numero=1)
		const player2 = new Player(img = "registros/jugador2.png", nombre="player2",numero=2)
		const player3 = new Player(img = "registros/jugador3.png", nombre="player3",numero=3)
		const player4 = new Player(img = "registros/jugador4.png", nombre="player4",numero=4)
		
			if (!juego.partidaIniciada() and tablero.selector().position().y() == 8){
				juego.iniciarPartida([player1,player2])
			}
			else if (!juego.partidaIniciada() and tablero.selector().position().y() == 7){
				juego.iniciarPartida([player1,player2,player3])
			}
			else if (!juego.partidaIniciada() and tablero.selector().position().y() == 6){
				juego.iniciarPartida([player1,player2,player3,player4])
			}
		}
		
		//Mostrar instrucciones
		keyboard.i().onPressDo{
			if (!game.hasVisual(tablero.instrucciones1()) and
				!game.hasVisual(tablero.instrucciones2()) and
				!game.hasVisual(tablero.teclas())
			){game.addVisual(tablero.instrucciones1())}
			else if(game.hasVisual(tablero.instrucciones1())){
				game.removeVisual(tablero.instrucciones1())
			}else if(game.hasVisual(tablero.instrucciones2())){
				game.removeVisual(tablero.instrucciones2())
			}else {game.removeVisual(tablero.teclas())}
		}
		
		keyboard.right().onPressDo{
			if (game.hasVisual(tablero.instrucciones1())){
				game.removeVisual(tablero.instrucciones1())
				game.addVisual(tablero.instrucciones2())}
			else if (game.hasVisual(tablero.instrucciones2())){
				game.removeVisual(tablero.instrucciones2())
				game.addVisual(tablero.teclas())}
		}
		keyboard.left().onPressDo{
			if (game.hasVisual(tablero.teclas())){
				game.removeVisual(tablero.teclas())
				game.addVisual(tablero.instrucciones2())}
			else if (game.hasVisual(tablero.instrucciones2())){
				game.removeVisual(tablero.instrucciones2())
				game.addVisual(tablero.instrucciones1())}
		}
		
		//Tirar dados
		keyboard.space().onPressDo{
			if (!juego.jugadores().isEmpty() and juego.popupEnPantalla().isEmpty()){
				juego.playerOnTurn().tirarDados()}
			}
		
		//Comprar propiedad a otro jugador
		keyboard.t().onPressDo{
			//Retorna la región actual
			const currentRegion = regiones.todasLasRegiones().filter({ r => r.contains(juego.playerOnTurn().currentLocation())}).uniqueElement()
			
			if (juego.partidaIniciada() and !juego.playerOnTurn().currentLocation().esCasilleroEspecial()){ //Valida que no sea casillero especial
				if (juego.playerOnTurn().dinero() < juego.playerOnTurn().currentLocation().costo()*1.5){
					const dineroInsuficiente = new Popup(img="popups/dineroInsuficiente.png",position=game.at(1,2))
					dineroInsuficiente.addVisual()
					game.schedule(1500,{ dineroInsuficiente.removeVisual() })
				}
				//Valida si el dueño de la ubicación actual es dueño de la region completa
				else if (!juego.playerOnTurn().currentLocation().esDelBanco() and
					currentRegion.all({p => p.titular() == juego.playerOnTurn().currentLocation().titular()})){
					const terrateniente = new Popup(img="popups/terrateniente.png",position=game.at(1,2))
					terrateniente.addVisual()
					game.schedule(2000,{ terrateniente.removeVisual() })
				}	
				else if (!juego.jugadores().isEmpty() and
						!juego.playerOnTurn().currentLocation().esDelBanco() and
						!juego.playerOnTurn().mePertenece(juego.playerOnTurn().currentLocation())){
					juego.playerOnTurn().transferencia()
				}
			}
		}

		//Pedir Prestamo y Pagar Deudas
		keyboard.o().onPressDo{
			if (!juego.jugadores().isEmpty() and juego.popupEnPantalla().isEmpty()){
				juego.playerOnTurn().pedirPrestamo()}
		}
		keyboard.p().onPressDo{
			if (!juego.jugadores().isEmpty() and juego.popupEnPantalla().isEmpty() and juego.playerOnTurn().deuda() > 0){
				if (juego.playerOnTurn().debeFianza()) juego.playerOnTurn().pagarFianza()
				else juego.playerOnTurn().pagarDeudas()}
		}
		
		//Finalizar turno
		keyboard.f().onPressDo{
			if (juego.partidaIniciada() and		//Valida que haya comenzado la partida 
				juego.popupEnPantalla().isEmpty() and	//Valida que no hay otro popup abierto
				juego.playerOnTurn().finDeTurno())	//Valida que ya terminó el turno
					{juego.endTurn()}
		}
		
	}
}
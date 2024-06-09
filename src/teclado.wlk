import wollok.game.*
import juego.*
import pantalla.*
import jugadores.*
import tablero.*


object teclado{
	
	method configuracion(){
		//Movimientos de Selector
		keyboard.up().onPressDo{if (!juego.partidaIniciada())
			selector.moveUp()}
		keyboard.down().onPressDo{if (!juego.partidaIniciada())
			selector.moveDown()}
	
		//Empezar partida (Selecciona cantidad de jugadores, elimina Start Menu y genera el tablero)
		keyboard.enter().onPressDo{
			if (!juego.partidaIniciada() and selector.position().y() == 8){
				juego.iniciarPartida([player1,player2])
			}
			else if (!juego.partidaIniciada() and selector.position().y() == 7){
				juego.iniciarPartida([player1,player2,player3])
			}
			else if (!juego.partidaIniciada() and selector.position().y() == 6){
				juego.iniciarPartida([player1,player2,player3,player4])
			}
		}
		
		//Mostrar instrucciones
		keyboard.i().onPressDo{
			if (!game.hasVisual(instrucciones1) and
				!game.hasVisual(instrucciones2) and
				!game.hasVisual(teclas)
			){game.addVisual(instrucciones1)}
			else if(game.hasVisual(instrucciones1)){
				game.removeVisual(instrucciones1)
			}else if(game.hasVisual(instrucciones2)){
				game.removeVisual(instrucciones2)
			}else {game.removeVisual(teclas)}
		}
		
		keyboard.right().onPressDo{
			if (game.hasVisual(instrucciones1)){
				game.removeVisual(instrucciones1)
				game.addVisual(instrucciones2)}
			else if (game.hasVisual(instrucciones2)){
				game.removeVisual(instrucciones2)
				game.addVisual(teclas)}
		}
		keyboard.left().onPressDo{
			if (game.hasVisual(teclas)){
				game.removeVisual(teclas)
				game.addVisual(instrucciones2)}
			else if (game.hasVisual(instrucciones2)){
				game.removeVisual(instrucciones2)
				game.addVisual(instrucciones1)}
		}
		
		//Tirar dados
		keyboard.space().onPressDo{
			if (!jugadores.isEmpty() and juego.popupEnPantalla().isEmpty()){
				juego.playerOnTurn().tirarDados()}
			}
		
		//Comprar propiedad a otro jugador
		keyboard.t().onPressDo{
			//Retorna la región actual
			const currentRegion = regiones.filter({ r => r.contains(juego.playerOnTurn().currentLocation())}).uniqueElement()
			
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
				else if (!jugadores.isEmpty() and
						!juego.playerOnTurn().currentLocation().esDelBanco() and
						!juego.playerOnTurn().mePertenece(juego.playerOnTurn().currentLocation())){
					juego.playerOnTurn().transferencia()
				}
			}
		}

		//Pedir Prestamo y Pagar Deudas
		keyboard.o().onPressDo{
			if (!jugadores.isEmpty() and juego.popupEnPantalla().isEmpty()){
				juego.playerOnTurn().pedirPrestamo()}
		}
		keyboard.p().onPressDo{
			if (!jugadores.isEmpty() and juego.popupEnPantalla().isEmpty() and juego.playerOnTurn().deuda() > 0){
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
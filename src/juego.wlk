import wollok.game.*
import pantalla.*
import jugadores.*
import tablero.*
import cartas.*
import balance.*
import propiedades.*
import teclado.*

object juego{
	var property popupEnPantalla = []
	const property jugadores = []
	
	method partidaIniciada() = !jugadores.isEmpty()
	
	method iniciar(){
		//Configuraciones
		game.width(9)
		game.height(9)
		game.cellSize(128)
		game.boardGround("boardground.png")
		game.title("Argentópolis")
		
		//Cancion 
		song.menu().shouldLoop(true)
		game.schedule(500, { song.menu().play()} )		

		//Pantalla principal
		tablero.startMenu().addVisual()
		tablero.selector().addVisual()
		tablero.selectPlayerScreen().addVisual()
		tablero.selectPlayerScreen().animation(2)
		
		//Configuraciones de teclado
		teclado.configuracion()
		
		game.start()
	}

	//Agrega Jugadores e inicia la partida.
    method iniciarPartida(players){
        tablero.generarTablero()
		jugadores.addAll(players)
        jugadores.forEach{ j => game.addVisual(j)}
        self.mostrarBalance()
        game.onCollideDo(salida, {player => turno.playerOnTurn().cobrarSalario()})
    }
	
	method mostrarBalance(){
		jugadores.forEach{ j =>
			const balance = new Balance(unJugador=j)
			balance.addVisual()
		}
	}
	
}

object turno{
	var turnoJugadorNro = 0
	
	//Retorna o establece el Nro de Jugador activo en este turno
	method turnoJugadorNro() = turnoJugadorNro+1
	method turnoJugadorNro(jugador){turnoJugadorNro = jugador}
	method playerOnTurn() = juego.jugadores().get(turnoJugadorNro)
	method playerOnTurn(jugador){juego.jugadores().get(jugador)}
	
	method endTurn(){
		//Reestablece el turno y la tirada de dados del jugador del siguiente turno
		self.playerOnTurn().yaTiro(false)
		self.playerOnTurn().finDeTurno(false)
		//Asigna el turno al siguiente jugador y lo indica en un popup
		turnoJugadorNro = if (turnoJugadorNro == juego.jugadores().size()-1) 0 else turnoJugadorNro+1
		const imgPlayerTurn = new Popup(img = "popups/" + self.playerOnTurn().nombre().toString() + "turn.png",position=game.at(1,2))
		imgPlayerTurn.addVisual()
		game.schedule(1000, {imgPlayerTurn.removeVisual()} )
	}

	
	
}

object song{
	const property menu = game.sound("sounds/muchachos.mp3")
	const property partida = game.sound("sounds/zambaDeMiEsperanza.mp3")
	const property win = game.sound("sounds/winSong.mp3")
}


import wollok.game.*
import pantalla.*
import jugadores.*
import tablero.*
import cartas.*
import balance.*
import propiedades.*
import teclado.*


//Jugadores
const player1 = new Player(img = "registros/jugador1.png", nombre="player1",numero=1)
const player2 = new Player(img = "registros/jugador2.png", nombre="player2",numero=2)
const player3 = new Player(img = "registros/jugador3.png", nombre="player3",numero=3)
const player4 = new Player(img = "registros/jugador4.png", nombre="player4",numero=4)
const jugadores = []

//Sonidos
const soundMenu = game.sound("sounds/muchachos.mp3")
const playingSong = game.sound("sounds/zambaDeMiEsperanza.mp3")
const winSong = game.sound("sounds/winSong.mp3")

//Fondos y Tablero
const startMenu = new Fondo(img="fondos/startMenu.png")
const selectPlayerScreen = new Animation(img="UI/seleccionarJugadores",position = game.at(0,0))
const selector = new Selector(img="UI/selector.png", position=game.at(0,8))
const mapaArgentina = new Fondo(position=game.at(1,1),img="fondos/argentina.png")
const indicadorTurno = new IndicadorJugador(position=game.at(5,7))

//Instrucciones
const instrucciones1 = new Instrucciones(img = "popups/instrucciones1.png")
const instrucciones2 = new Instrucciones(img = "popups/instrucciones2.png")
const teclas = new Instrucciones(img = "popups/teclas.png")
const teclaInstrucciones = new Visual(position=game.at(3,1),img="UI/teclaInstrucciones.png")

//Animacion dinero
const dineroAnimation = new DineroModifier(img="")


object juego{
	var turnoJugadorNro = 0
	var property popupEnPantalla = []
	
	method partidaIniciada() = !game.hasVisual(startMenu)
	
	method iniciar(){
		//Configuraciones
		game.width(9)
		game.height(9)
		game.cellSize(128)
		game.boardGround("boardground.png")
		game.title("Argentópolis")
		
		soundMenu.shouldLoop(true)
		game.schedule(500, { soundMenu.play()} )
//		game.schedule(501, { soundMenu.pause()} ) //AGREGADO DURANTE EL DESARROLLO PARA NO ESCUCHAR LA CANCION
		
		//Pantalla principal
		startMenu.addVisual()
		selector.addVisual()
		selectPlayerScreen.addVisual()
		selectPlayerScreen.animation(2)
		
		//Configuraciones de teclado
		teclado.configuracion()
		
		game.start()
	}

	//Agrega Jugadores e inicia la partida.
    method iniciarPartida(players){
        self.generarTablero()
		jugadores.addAll(players)
        jugadores.forEach{ j => game.addVisual(j)}
        self.mostrarBalance()
    }
	
	method mostrarBalance(){
		jugadores.forEach{ j =>
			const balance = new Balance(unJugador=j)
			balance.addVisual()
		}
	}
	
	method endTurn(){
		//Reestablece el turno y la tirada de dados del jugador del siguiente turno
		self.playerOnTurn().yaTiro(false)
		self.playerOnTurn().finDeTurno(false)
		//Asigna el turno al siguiente jugador y lo indica en un popup
		turnoJugadorNro = if (turnoJugadorNro == jugadores.size()-1) 0 else turnoJugadorNro+1
		const imgPlayerTurn = new Popup(img = "popups/" + self.playerOnTurn().nombre().toString() + "turn.png",position=game.at(1,2))
		imgPlayerTurn.addVisual()
		game.schedule(1000, {imgPlayerTurn.removeVisual()} )
	}

	//Retorna o establece el Nro de Jugador activo en este turno
	method turnoJugadorNro() = turnoJugadorNro+1
	method turnoJugadorNro(jugador){turnoJugadorNro = jugador}
	method playerOnTurn() = jugadores.get(turnoJugadorNro)
	method playerOnTurn(jugador){jugadores.get(jugador)}

	method generarTablero(){
		//Elimina el Menu de Inicio
		soundMenu.stop()
		startMenu.removeVisual()
		selectPlayerScreen.removeVisual()
		selector.removeVisual()
		//Fondo de tablero
		mapaArgentina.addVisual()
		//Tecla en pantalla para abrir instrucciones
		teclaInstrucciones.addVisual()
		//Indicador de Jugador en turno actual
		indicadorTurno.addVisual()
		indicadorTurno.animation(2)
		//Coloca todos los casilleros y etiquetas del tablero
		casilleros.forEach{casillero => game.addVisual(casillero)}
		banco.todasDelBanco(casilleros)
		//Música de partida
		playingSong.shouldLoop(true)
		game.schedule(300,{playingSong.play()})
		
		//PARA COBRAR DESPUES DE LA PRIMER VUELTA AL MENOS 1 TIENE QUE HABER COMPRADO UNA PROPIEDAD
		game.onCollideDo(salida, {player => self.playerOnTurn().cobrarSalario()})
	}
	
}


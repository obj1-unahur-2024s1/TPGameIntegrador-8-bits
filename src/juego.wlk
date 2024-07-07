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

	method generarTablero(){
		//Elimina el Menu de Inicio
		song.menu().stop()
		tablero.startMenu().removeVisual()
		tablero.selectPlayerScreen().removeVisual()
		tablero.selector().removeVisual()
		//Fondo de tablero
		tablero.mapaArgentina().addVisual()
		//Tecla en pantalla para abrir instrucciones
		tablero.teclaInstrucciones().addVisual()
		//Indicador de Jugador en turno actual
		tablero.indicadorTurno().addVisual()
		tablero.indicadorTurno().animation(2)
		//Coloca todos los casilleros y etiquetas del tablero
		self.generarCasilleros()
		//Música de partida
		song.partida().shouldLoop(true)
		game.schedule(300,{song.partida().play()})
		
		//PARA COBRAR DESPUES DE LA PRIMER VUELTA AL MENOS 1 TIENE QUE HABER COMPRADO UNA PROPIEDAD
		game.onCollideDo(salida, {player => turno.playerOnTurn().cobrarSalario()})
	}
	
	method generarCasilleros(){				
		const casilleros =[
			banco,salida,
			new CasilleroSuerte(position = game.at(0,0),img="casilleros/suerte.png"),
			new Carcel(position = game.at(0,8),img="casilleros/carcel.png"),
			new CasilleroMufa(position = game.at(8,8),img="casilleros/mufa.png"),

			new Visual(position = game.at(7,1), img = "casilleros/label-malvinasEntreRios.png"),
			new Visual(position = game.at(6,1), img = "casilleros/label-buenosAires.png"),
			new Visual(position = game.at(5,1), img = "casilleros/label-santaFe.png"),
			new Visual(position = game.at(4,1), img = "casilleros/label-sarmiento.png"),
			new Visual(position = game.at(3,1), img = "casilleros/label-santiago.png"),
			new Visual(position = game.at(2,1), img = "casilleros/label-laPampa.png"),
			new Visual(position = game.at(1,1), img = "casilleros/label-cordobaChaco.png"),
			new Visual(position = game.at(1,2), img = "casilleros/label-corrientes.png"),
			new Visual(position = game.at(1,3), img = "casilleros/label-misiones.png"),
			new Visual(position = game.at(1,4), img = "casilleros/label-roca.png"),
			new Visual(position = game.at(1,5), img = "casilleros/label-formosa.png"),
			new Visual(position = game.at(1,6), img = "casilleros/label-jujuy.png"),
			new Visual(position = game.at(1,7), img = "casilleros/label-saltaTucuman.png"),
			new Visual(position = game.at(2,7), img = "casilleros/label-catamarca.png"),
			new Visual(position = game.at(3,7), img = "casilleros/label-laRioja.png"),
			new Visual(position = game.at(4,7), img = "casilleros/label-mitre.png"),
			new Visual(position = game.at(5,7), img = "casilleros/label-sanJuan.png"),
			new Visual(position = game.at(6,7), img = "casilleros/label-sanLuis.png"),
			new Visual(position = game.at(7,7), img = "casilleros/label-mendozaChubut.png"),
			new Visual(position = game.at(7,6), img = "casilleros/label-rioNegro.png"),
			new Visual(position = game.at(7,5), img = "casilleros/label-neuquen.png"),
			new Visual(position = game.at(7,4), img = "casilleros/label-sanMartin.png"),
			new Visual(position = game.at(7,3), img = "casilleros/label-santaCruz.png"),
			new Visual(position = game.at(7,2), img = "casilleros/label-tierraDelFuego.png")
			]
		
		casilleros.forEach{casillero => game.addVisual(casillero)}
		banco.todasDelBanco(casilleros)
		
		regiones.todasLasRegiones().forEach{ unaRegion =>
			unaRegion.forEach{ubicacion => game.addVisual(ubicacion) }
			banco.todasDelBanco(unaRegion)
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


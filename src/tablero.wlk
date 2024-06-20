import wollok.game.*
import juego.*
import pantalla.*
import propiedades.*

object tablero{
	const property startMenu = new Fondo(img="fondos/startMenu.png")
	const property selectPlayerScreen = new Animation(img="UI/seleccionarJugadores",position = game.at(0,0))
	const property selector = new Selector(img="UI/selector.png", position=game.at(0,8))
	const property mapaArgentina = new Fondo(position=game.at(1,1),img="fondos/argentina.png")
	const property indicadorTurno = new IndicadorJugador(position=game.at(5,7))
	const property instrucciones1 = new Instrucciones(img = "popups/instrucciones1.png")
	const property instrucciones2 = new Instrucciones(img = "popups/instrucciones2.png")
	const property teclas = new Instrucciones(img = "popups/teclas.png")
	const property teclaInstrucciones = new Visual(position=game.at(3,1),img="UI/teclaInstrucciones.png")
	const property dineroAnimation = new DineroModifier(img="")
}

class Dado inherits Visual{
	const property valor = [1,2,3,4,5,6].anyOne()
	
	override method position() = game.at(4,1)
	override method image() = "dados/dado" + valor.toString() + ".png"
}

object banco{
	var property position = game.at(6,1)
	var property dinero = 9999999
	const misPropiedades = #{}
	
	method image() = "UI/MrArgentopoly.png"
	
	method todasDelBanco(propiedades){
		propiedades.forEach{unCasillero => misPropiedades.add(unCasillero)}
	}
	
	method misPropiedades() = misPropiedades
	
	method cobrar(monto){dinero += monto}
	method pagar(monto){dinero -= monto}
}

//Provincias y Trenes
const entreRios = new Provincia(position = game.at(7,0), img = "casilleros/entreRios.png")
const buenosAires = new Provincia(position = game.at(6,0), img = "casilleros/buenosAires.png")
const santaFe = new Provincia(position = game.at(5,0), img = "casilleros/santaFe.png")
const sarmiento = new Tren(position = game.at(4,0), img = "casilleros/sarmiento.png")
const santiago = new Provincia(position = game.at(3,0), img = "casilleros/santiago.png")
const laPampa = new Provincia(position = game.at(2,0), img = "casilleros/laPampa.png")
const cordoba = new Provincia(position = game.at(1,0), img = "casilleros/cordoba.png")
const chaco = new Provincia(position = game.at(0,1), img = "casilleros/chaco.png")
const corrientes = new Provincia(position = game.at(0,2), img = "casilleros/corrientes.png")
const misiones = new Provincia(position = game.at(0,3), img = "casilleros/misiones.png")
const roca = new Tren(position = game.at(0,4), img = "casilleros/roca.png")
const formosa = new Provincia(position = game.at(0,5), img = "casilleros/formosa.png")
const jujuy = new Provincia(position = game.at(0,6), img = "casilleros/jujuy.png")
const salta = new Provincia(position = game.at(0,7), img = "casilleros/salta.png")
const tucuman = new Provincia(position = game.at(1,8), img = "casilleros/tucuman.png")
const catamarca = new Provincia(position = game.at(2,8), img = "casilleros/catamarca.png")
const laRioja = new Provincia(position = game.at(3,8), img = "casilleros/laRioja.png")
const mitre = new Tren(position = game.at(4,8), img = "casilleros/mitre.png")
const sanJuan = new Provincia(position = game.at(5,8), img = "casilleros/sanJuan.png")
const sanLuis = new Provincia(position = game.at(6,8), img = "casilleros/sanLuis.png")
const mendoza = new Provincia(position = game.at(7,8), img = "casilleros/mendoza.png")
const chubut = new Provincia(position = game.at(8,7), img = "casilleros/chubut.png")
const rioNegro = new Provincia(position = game.at(8,6), img = "casilleros/rioNegro.png")
const neuquen = new Provincia(position = game.at(8,5), img = "casilleros/neuquen.png")
const sanMartin = new Tren(position = game.at(8,4), img = "casilleros/sanMartin.png")
const santaCruz = new Provincia(position = game.at(8,3), img = "casilleros/santaCruz.png")
const tierraDelFuego = new Provincia(position = game.at(8,2), img = "casilleros/tierraDelFuego.png")
const malvinas = new Provincia(position = game.at(8,1), img = "casilleros/malvinas.png")

//Regiones
const region1 = [entreRios,buenosAires,santaFe]
const region2 = [santiago,laPampa,cordoba]
const region3 = [chaco,corrientes,misiones]
const region4 = [formosa,jujuy,salta]
const region5 = [tucuman,catamarca,laRioja]
const region6 = [sanJuan,sanLuis,mendoza]
const region7 = [chubut,rioNegro,neuquen]
const region8 = [santaCruz,tierraDelFuego,malvinas]
const trenes = [sarmiento,roca,mitre,sanMartin]

const regiones = [
	region1,region2,region3,region4,
	region5,region6,region7,region8,
	trenes]

//CasillerosEspeciales Y Etiquetas Dobles
const salida = new CasilleroEspecial(position = game.at(8,0),img="casilleros/salida.png",tipo="Salida")
const suerte =  new CasilleroEspecial(position = game.at(0,0),img="casilleros/suerte.png",tipo="Suerte")
const carcel = new CasilleroEspecial(position = game.at(0,8),img="casilleros/carcel.png",tipo="Carcel")
const mufa =  new CasilleroEspecial(position = game.at(8,8),img="casilleros/mufa.png",tipo="Mufa")

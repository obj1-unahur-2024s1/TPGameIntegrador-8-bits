import wollok.game.*
import juego.*
import pantalla.*
import propiedades.*


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


//Instancias de Casilleros, Regiones y Etiquetas

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

//Etiquetas
const labelmalvinasEntreRios = new Label(position = game.at(7,1), img = "casilleros/label-malvinasEntreRios.png")
const labelBuenosAires = new Label(position = game.at(6,1), img = "casilleros/label-buenosAires.png")
const labelSantaFe = new Label(position = game.at(5,1), img = "casilleros/label-santaFe.png")
const labelSarmiento = new Label(position = game.at(4,1), img = "casilleros/label-sarmiento.png")
const labelSantiago = new Label(position = game.at(3,1), img = "casilleros/label-santiago.png")
const labelLaPampa = new Label(position = game.at(2,1), img = "casilleros/label-laPampa.png")
const labelCordobaChaco = new Label(position = game.at(1,1), img = "casilleros/label-cordobaChaco.png")
const labelCorrientes = new Label(position = game.at(1,2), img = "casilleros/label-corrientes.png")
const labelMisiones = new Label(position = game.at(1,3), img = "casilleros/label-misiones.png")
const labelRoca = new Label(position = game.at(1,4), img = "casilleros/label-roca.png")
const labelFormosa = new Label(position = game.at(1,5), img = "casilleros/label-formosa.png")
const labelJujuy = new Label(position = game.at(1,6), img = "casilleros/label-jujuy.png")
const labelSaltaTucuman = new Label(position = game.at(1,7), img = "casilleros/label-saltaTucuman.png")
const labelCatamarca = new Label(position = game.at(2,7), img = "casilleros/label-catamarca.png")
const labelLaRioja = new Label(position = game.at(3,7), img = "casilleros/label-laRioja.png")
const labelMitre = new Label(position = game.at(4,7), img = "casilleros/label-mitre.png")
const labelSanJuan = new Label(position = game.at(5,7), img = "casilleros/label-sanJuan.png")
const labelSanLuis = new Label(position = game.at(6,7), img = "casilleros/label-sanLuis.png")
const labelMendozaChubut = new Label(position = game.at(7,7), img = "casilleros/label-mendozaChubut.png")
const labelRioNegro = new Label(position = game.at(7,6), img = "casilleros/label-rioNegro.png")
const labelNeuquen = new Label(position = game.at(7,5), img = "casilleros/label-neuquen.png")
const labelSanMartin = new Label(position = game.at(7,4), img = "casilleros/label-sanMartin.png")
const labelSantaCruz = new Label(position = game.at(7,3), img = "casilleros/label-santaCruz.png")
const labelTierraDelFuego = new Label(position = game.at(7,2), img = "casilleros/label-tierraDelFuego.png")


const casilleros =[
	banco,salida,suerte,carcel,mufa,
	
	labelmalvinasEntreRios,labelBuenosAires,labelSantaFe,labelSarmiento,labelSantiago,
	labelLaPampa,labelCordobaChaco,labelCorrientes,labelMisiones,labelRoca,labelFormosa,labelJujuy,
	labelSaltaTucuman,labelCatamarca,labelLaRioja,labelMitre,labelSanJuan,labelSanLuis,labelMendozaChubut,
	labelRioNegro,labelNeuquen,labelSanMartin,labelSantaCruz,labelTierraDelFuego,
	
	entreRios,buenosAires,santaFe,sarmiento,santiago,laPampa,cordoba,chaco,corrientes,misiones,roca,
	formosa,jujuy,salta,tucuman,catamarca,laRioja,mitre,sanJuan,sanLuis,mendoza,chubut,rioNegro,
	neuquen,sanMartin,santaCruz,tierraDelFuego,malvinas
	]
// example.wlk
// example.wlk
// example.wlk
// example.wlk
// example.wlk

// hacer #{} conjunto vacio 
class Actividad {
  const idiomas = #{} 
  //get de idiomas
  method idiomas()=idiomas 
  //el get, no es necesario le agregue el property
  method initialize() {
    if(idiomas.isEmpty())  {self.error("debe ser una colección que tenga al menos un idioma en formato string")}
  }
  method esInteresante() = idiomas.size() > 1
  method sirveParaBroncearse() = true //es true para todos a menos que cambie su condicion

  method dias()
  method implicaEsfuerzo() = true 

}

class ViajeDePlaya inherits Actividad {
  const largo
  override method dias() = largo / 500
  override method implicaEsfuerzo() = largo > 1200
  //override method sirveParaBroncearse() = true
  // ya la hereda y esta en true ademas 
}

class ExcursionACiudad inherits Actividad {
  const property cantidadAtracciones
  override method esInteresante() = super() || cantidadAtracciones == 5
  override method dias() = cantidadAtracciones / 2
  override method sirveParaBroncearse() = false
  override method implicaEsfuerzo() = cantidadAtracciones.between(5, 8)
}

//subclase es falsa por defoult lucautMethod, hereda el de la clase
//sobreescribe a la clase con super la sub
class ExcursionTropical inherits ExcursionACiudad {
  override method dias() = super() + 1
  override method sirveParaBroncearse() = true
}

class SalidaDeTrekking inherits Actividad {
  const kms
  const diasDeSol
  override method esInteresante() = super() && diasDeSol > 140
  override method dias() = kms / 50
  override method implicaEsfuerzo() = kms > 80
  override method sirveParaBroncearse() {
    return
    diasDeSol > 200 ||
    (diasDeSol.between(100, 200) && kms > 120)
  }

}

//en la herencia nose pueden sobreescribir los atributos
// var idiomas = #{"español"} -------> NO
class ClaseDeGimnasia inherits Actividad {
  //mas optima, forzamos una validacion
  method initialize() {
    //probar el override method 
    idiomas.clear()
    idiomas.add("español")
  }
  //solo si lo solicita , es una variante y hay que llamarlo
  //deja al constructor fuera de juego
  //method validador() {
    //if(!idiomas==#{"español"}) {
      //self.error("el unico idioma disponible es español")
    //}
  //}
  override method idiomas() = #{"español"} //es redundante porque se valida en la creación, pero está muy bien.
  override method dias() = 1
  // implica Esfuerzo esta true en actividad
  override method sirveParaBroncearse() = false
}


//Socio
class Socio { 
  const property actividades = []
  const maximoActividades
  var edad
  const idiomas = #{} //conjunto de idiomas que habla el socio

  method edad()=edad
  
  method initialize() {
    actividades.clear() //limpia la lista de actividades
  }
  

  //Actividad para registrar
  method registrarActividad(unaActividad) {
    if(maximoActividades==actividades.size()) {
      self.error("el socio alcanzó el máximo de actividades")
    }
    actividades.add(unaActividad)
  }
  //todos cumplen esa condicion all es un mesnaje mas
  method esAdoradorDelSol() = actividades.all({a=>a.sirveParaBroncearse()})
  method actividadesEsforzadas() = actividades.filter({a=>a.implicaEsfuerzo()})
  method leAtrae(unaActividad) //metodo abstracto y lo desarrollo dentro de cada subclase
}

class SocioTranquilo inherits Socio {
  override method leAtrae(unaActividad) = unaActividad.dias() >= 4
}

class SocioCoherente inherits Socio {
  override method leAtrae(unaActividad) {
    return
    if(self.esAdoradorDelSol()) {unaActividad.sirveParaBroncearse()} 
    else {unaActividad.implicaEsfuerzo()}
  }
}

//interseccion del conjunto
class SocioRelajado inherits Socio {
  override method leAtrae(unaActividad) {
    return
    not idiomas.intersection(
      unaActividad.idiomas()).isEmpty()
  }//si no me da vacio la interceccion entre idiomas le atrae
  //NOT
}
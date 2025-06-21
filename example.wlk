// example.wlk

// hacer 
class Actividad {
  const property idiomas = #{}
  method initialize() {
    if(idiomas.isEmpty())  {self.error("debe ser una colección que tenga al menos un idioma en formato string")}
  }
  method esInteresante() = idiomas.size() > 1
  method sirveParaBroncearse() = true
  method dias()
  method implicaEsfuerzo() = true

}

class ViajeDePlaya inherits Actividad {
  const largo
  override method dias() = largo / 500
  override method implicaEsfuerzo() = largo > 1200

}

class ExcursionACiudad inherits Actividad {
  const property cantidadAtracciones
  override method esInteresante() = super() || cantidadAtracciones == 5
  override method dias() = cantidadAtracciones / 2
  override method sirveParaBroncearse() = false
  override method implicaEsfuerzo() = cantidadAtracciones.between(5, 8)
}

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

class ClaseDeGimnasia inherits Actividad {
  //mas optima
  method initialize() {
    idiomas.clear()
    idiomas.add("español")
  }
  //solo si lo solicita 
  method validador() {
    if(!idiomas==#{"español"}) {
      self.error("el unico idioma disponible es español")
    }
  }
  override method idiomas() = #{"español"} //es redundante porque se valida en la creación, pero está muy bien.
  override method dias() = 1
  override method sirveParaBroncearse() = false
}


//Socio
class Socio {
  const property actividades = []
  const maximoActividades
  var edad
  const idiomas = #{}
  
  method initialize() {
    actividades.clear() //limpia la lista de actividades
  }
  

  //Actividad
  method registrarActividad(unaActividad) {
    if(maximoActividades==actividades.size()) {
      self.error("el socio alcanzó el máximo de actividades")
    }
    actividades.add(unaActividad)
  }
  method esAdoradorDelSol() = actividades.all({a=>a.sirveParaBroncearse()})
  method actividadesEsforzadas() = actividades.filter({a=>a.implicaEsfuerzo()})
  method leAtrae(unaActividad)
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

class SocioRelajado inherits Socio {
  override method leAtrae(unaActividad) {
    return
    not idiomas.intersection(unaActividad.idiomas()).isEmpty()
  }
}
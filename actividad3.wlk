// actividad3.wlk
// actividad3.wlk
// actividad3.wlk
// actividad3.wlk



/*
esRecomendadaPara a la clase Actividad y sobrescribirlo en las subclases ViajeDePlaya y ClaseDeGimnasia para implementar la lógica específica para cada tipo de actividad.
*/
class Actividad {
  const idiomas = #{}
  method idiomas()=idiomas
  method initialize() {
    if(idiomas.isEmpty()) {self.error("debe ser una colección que tenga al menos un idioma en formato string")}
  }
  method esInteresante() = idiomas.size() > 1
  method sirveParaBroncearse() = true
  method dias()
  method implicaEsfuerzo() = true

  //punto 6 
  method esRecomendadaPara(unSocio) = false // Por defecto, una actividad no es recomendada
}

class ViajeDePlaya inherits Actividad {
  const largo
  override method dias() = largo / 500
  override method implicaEsfuerzo() = largo > 1200
  
  //punto 6
  override method esRecomendadaPara(unSocio) = 
    self.esInteresante() and unSocio.leAtrae(self) and not unSocio.yaRealizo(self)
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
  method initialize() {
    idiomas.clear()
    idiomas.add("español")
  }
  override method idiomas() = #{"español"}
  override method dias() = 1
  override method sirveParaBroncearse() = false

  //punto 6 sobreescribi los metodos
  override method esRecomendadaPara(unSocio) = unSocio.edad().between(20, 30)
}

class Socio {
  const property actividades = []
  const maximoActividades
  var edad
  const idiomas = #{}

  method edad()=edad
  
  method initialize() {
    actividades.clear()
  }
  
  method registrarActividad(unaActividad) {
    if(maximoActividades==actividades.size()) {
      self.error("el socio alcanzó el máximo de actividades")
    }
    actividades.add(unaActividad)
  }
  method esAdoradorDelSol() = actividades.all({a=>a.sirveParaBroncearse()})
  method actividadesEsforzadas() = actividades.filter({a=>a.implicaEsfuerzo()})
  method leAtrae(unaActividad)

  //punto 6 sobreescribi los metodos
  method yaRealizo(unaActividad) = actividades.contains(unaActividad)
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
    not idiomas.intersection(
      unaActividad.idiomas()).isEmpty()
  }
}
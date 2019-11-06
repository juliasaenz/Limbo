// 'P' AVANZA MOLDE
// 'R' RESETEA TODO
// 'Q' y 'W' VOLUMEN MOLDE
// 'L' SILENCIA USUARIO
// 'O' SILENCIA MOLDE

import ddf.minim.*;
import ddf.minim.ugens.*;

Minim minim;

int actual = 0;  
int ciclos = 0;
int volumen = 6;
boolean fin = false;
Molde M;
Usuario U;
void setup() {
  size(640, 240);
  minim = new Minim(this);
  M = new Molde();
  U = new Usuario();

  M.InicializarMolde();
  U.InicializarUsuario();
}

void draw () {
  if(!fin){
  M.SeEscucha(actual, volumen);
  U.ControlPitch();
  U.Ondas();
  } else {
   M.Fin(volumen, actual); 
   U.Fin(0.5);
  }
}

void keyPressed() {
  // USUARIO
  // Play y Pausa
  if ( key == 'l') {
    if ( U.EstaSonando() ) {
      println("pausa");
      U.Pausa();
    } else {
      U.Play();
      println("play");
    }
  }
  // MOLDE
  //progresivo
  if (key == 'p') {
    actual++;
    if (actual <= 4) {
      M.Rompe();
      fin = false;
    } else {
      fin = true;
      println("fin");
    }
  }
  
  // Subir Volumen si quieto
  if ( volumen > 12 ) {
    volumen = 12;
  }
  if (volumen < -8) {
    volumen = -8;
  }
  if ( key == 'q') {
    volumen = volumen - 5; 
    println( "volumen: " + volumen);
  }
  if ( key == 'w') {
    volumen = volumen + 5;
    println( "volumen: " + volumen);
  }
  println("actual: " + actual);
  println( "volumen: " + volumen);
  // Play y Pausa
  if ( key == 'o') {
    if ( M.EstaSonando()) {
      M.Pausa();
    } else {
      M.Play();
    }
  }
  // reseteo
  if ( key == 'r'){
    actual = 0;
    fin = false;
  }
}

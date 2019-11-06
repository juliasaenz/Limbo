
class Molde {

  int estados = 5;
  int silencio = -400;
  int sonido = 6;
  FilePlayer[] Molde = new FilePlayer[estados];
  AudioSample Cambio;
  AudioSample Fin;
  Gain[] gain = new Gain[estados];
  AudioOutput out, out_;
  String Archivo[] = new String[estados];
  Molde () {
  }

  void InicializarMolde () {
    Archivo[0] = "m0.mp3";
    Archivo[1] = "m1.mp3";
    Archivo[2] = "m2.mp3";
    Archivo[3] = "m3.mp3";
    Archivo[4] = "m4.mp3";
    for (int i = 0; i < estados; i = i+1) {
      Molde[i] = new FilePlayer( minim.loadFileStream(Archivo[i]));
      Molde[i].loop();
      gain[i] = new Gain(0.f);
      out = minim.getLineOut();
      Molde[i].patch(gain[i]).patch(out);
      gain[i].setValue(silencio);
    }
    Cambio = minim.loadSample("t3.mp3");
    Fin = minim.loadSample("u1.mp3");
    println(actual);
  }

  void SeEscucha(int act, int val) {
    for (int i = 0; i < estados; i = i+1) {
      if ( i == act) {
        gain[i].setValue(val);
      } else {
        gain[i].setValue(silencio);
      }
    }
    //println( "se escucha:" + act);
   // out.setGain(val);  
  }

  void Rompe() {
    Cambio.trigger();
  }
  
  void Fin (int val, int a){
   // Fin.trigger(); 
   for (float i = val ; i >= -6; i = i-0.0002) {
      gain[4].setValue(i);
      println("volumen:" + i);
    }
   Molde[4].pause();
  }
  
  boolean EstaSonando () {
    if ( Molde[0].isPlaying()) {
      return true;
    } else {
      return false;
  }
  }
  void Play () {
    for (int i = 0; i < estados; i = i+1) {
      Molde[i].loop();
    }
  }
  void Pausa () {
    for (int i = 0; i < estados; i = i+1) {
      Molde[i].pause();
    }
  }
  
  void Quieto(){
    out.setGain(8);  
  }
  ///////////////////////////////////
}

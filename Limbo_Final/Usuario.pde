class Usuario {
  FilePlayer Usuario;
  Gain       gain;
  TickRate rateControl;
  AudioOutput out;
  float max = 10, min = -10; 
  // Cargar Archivos
  String fileName = "u4.mp3";

  Usuario() {
  }

  void InicializarUsuario () {
    Usuario = new FilePlayer( minim.loadFileStream(fileName) );
    Usuario.loop();
    rateControl = new TickRate(1.f);
    out = minim.getLineOut();
    Usuario.patch(rateControl).patch(out);
    rateControl.setInterpolation( true );
  }

  void ControlPitch () {
      float rate = map(mouseX, 0, width, 0.0f, 3.f);
      rateControl.value.setLastValue(rate);
      //println("rate: " + rate);
  }

  void Ondas() {
    background( 0 );
    stroke( 255 );

    // Ondas
    for ( int i = 0; i < out.bufferSize() - 1; i++ ) {
      // find the x position of each buffer value
      float x1  =  map( i, 0, out.bufferSize(), 0, width );
      float x2  =  map( i+1, 0, out.bufferSize(), 0, width );
      // draw a line from one buffer position to the next for both channels
      line( x1, 50 + out.left.get(i)*50, x2, 50 + out.left.get(i+1)*50);
      line( x1, 150 + out.right.get(i)*50, x2, 150 + out.right.get(i+1)*50);
    }
  }

  boolean EstaSonando () {
    if ( Usuario.isPlaying()) {
      return true;
    } else {
      return false;
    }
  }

  void Play () {
    Usuario.loop();
  }
  void Pausa () {
    Usuario.pause();
  }

  void Fin (float val) {
    rateControl.value.setLastValue(val);
  }
  //////////////////////////////////
}

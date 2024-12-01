import processing.serial.*;

Serial myPort;
int[] estadosEntradas = {1, 1};
int[] estadosSalidas = {0, 0};
boolean[] estadoLEDs = {false, false};

void setup() {
  size(600, 400);
  myPort = new Serial(this, Serial.list()[1], 9600);
  myPort.clear();
  textAlign(CENTER, CENTER);
}

void draw() {
  background(255);
  
  // Dibujar nombres y estados de las entradas
  textSize(16);
  fill(0);
  text("Entrada 1 (Pulsador 1)", 150, 60);
  if (estadosEntradas[0] == 0) {
    fill(0, 255, 0); // Verde para "encendido"
  } else {
    fill(255, 0, 0); // Rojo para "apagado"
  }
  rect(125, 80, 50, 50);
  
  fill(0);
  text("Entrada 2 (Pulsador 2)", 450, 60);
  if (estadosEntradas[1] == 0) {
    fill(0, 255, 0); // Verde para "encendido"
  } else {
    fill(255, 0, 0); // Rojo para "apagado"
  }
  rect(425, 80, 50, 50);

  // Dibujar nombres y estados de las salidas como círculos
  fill(0);
  text("Salida 1 (LED 1)", 225, 220);
  if (estadosSalidas[0] == 1) {
    fill(0, 255, 0); // Verde para "encendido"
  } else {
    fill(255, 0, 0); // Rojo para "apagado"
  }
  ellipse(225, 270, 50, 50);
  
  fill(0);
  text("Salida 2 (LED 2)", 375, 220);
  if (estadosSalidas[1] == 1) {
    fill(0, 255, 0); // Verde para "encendido"
  } else {
    fill(255, 0, 0); // Rojo para "apagado"
  }
  ellipse(375, 270, 50, 50);
}

void mousePressed() {
  // Activar/desactivar LED1
  if (dist(mouseX, mouseY, 225, 270) < 25) {
    estadoLEDs[0] = !estadoLEDs[0];
    if (estadoLEDs[0]) {
      myPort.write("LED1 ON\n");
      estadosSalidas[0] = 1;
    } else {
      myPort.write("LED1 OFF\n");
      estadosSalidas[0] = 0;
    }
  }
  
  // Activar/desactivar LED2
  if (dist(mouseX, mouseY, 375, 270) < 25) {
    estadoLEDs[1] = !estadoLEDs[1];
    if (estadoLEDs[1]) {
      myPort.write("LED2 ON\n");
      estadosSalidas[1] = 1;
    } else {
      myPort.write("LED2 OFF\n");
      estadosSalidas[1] = 0;
    }
  }
}

void serialEvent(Serial p) {
  String val = p.readStringUntil('\n');
  if (val != null) {
    val = trim(val);
    if (val.startsWith("ENTRADA")) {
      String[] data = split(val, ' ');
      estadosEntradas[0] = int(data[1]);
      estadosEntradas[1] = int(data[2]);
      estadoLEDs[0] = int(data[3]) == 1;
      estadoLEDs[1] = int(data[4]) == 1;
      estadosSalidas[0] = int(data[3]);
      estadosSalidas[1] = int(data[4]);
    }
  }
}

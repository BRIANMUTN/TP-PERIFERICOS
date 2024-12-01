const int PULSADOR1 = 7; // Pulsador para LED1
const int PULSADOR2 = 6; // Pulsador para LED2
const int LED1 = 10;
const int LED2 = 11;

bool estadoLED1 = false;
bool estadoLED2 = false;

void setup() {
  Serial.begin(9600);
  pinMode(PULSADOR1, INPUT_PULLUP);
  pinMode(PULSADOR2, INPUT_PULLUP);
  pinMode(LED1, OUTPUT);
  pinMode(LED2, OUTPUT);
}

void loop() {
  int estadoPulsador1 = digitalRead(PULSADOR1);
  int estadoPulsador2 = digitalRead(PULSADOR2);

  // Leer comandos de Processing
  if (Serial.available() > 0) {
    String comando = Serial.readStringUntil('\n');
    if (comando == "LED1 ON") {
      estadoLED1 = true;
    } else if (comando == "LED1 OFF") {
      estadoLED1 = false;
    } else if (comando == "LED2 ON") {
      estadoLED2 = true;
    } else if (comando == "LED2 OFF") {
      estadoLED2 = false;
    }
  }

  // Activar LEDs según los pulsadores
  if (estadoPulsador1 == LOW) {
    estadoLED1 = true;
  } else if (estadoPulsador2 == LOW) {
    estadoLED2 = true;
  }

  // Actualizar estado de los LEDs
  digitalWrite(LED1, estadoLED1 ? HIGH : LOW);
  digitalWrite(LED2, estadoLED2 ? HIGH : LOW);

  // Enviar estados de entrada a Processing
  Serial.print("ENTRADA ");
  Serial.print(estadoPulsador1);
  Serial.print(" ");
  Serial.print(estadoPulsador2);
  Serial.print(" ");
  Serial.print(estadoLED1 ? "1" : "0");
  Serial.print(" ");
  Serial.println(estadoLED2 ? "1" : "0");

  delay(100); // Retardo para evitar el parpadeo de los LEDs
}

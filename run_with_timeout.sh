#!/bin/bash

# Führe das Python-Skript im Hintergrund aus
python3 app.py &
APP_PID=$!

# Warte 30 Sekunden
sleep 30

# Prüfe, ob der Prozess noch läuft
if ps -p $APP_PID > /dev/null
then
   # Wenn der Prozess noch läuft, beende ihn
   kill $APP_PID
   echo "Der Prozess wurde nach 30 Sekunden gestoppt."
else
   echo "Der Prozess wurde innerhalb der Zeit erfolgreich abgeschlossen."
fi

# Beende das Skript erfolgreich
exit 0

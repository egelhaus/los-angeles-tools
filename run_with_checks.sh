#!/bin/bash

set -e  # Beendet das Skript bei jedem Fehler

# Aktualisiere und installiere notwendige Pakete
apt update
apt install npm python3 python3-venv python3-pip python3-full -y

# Erstelle und aktiviere die virtuelle Umgebung
python3 -m venv venv
source venv/bin/activate

# Installiere Abhängigkeiten
pip install --upgrade pip  # Stelle sicher, dass pip aktuell ist
pip install --break-system-packages -r requirements.txt

# Installiere Linter und Sicherheits-Tools
pip install flake8 pylint bandit

# Führe Syntax-Überprüfung durch
echo "Führe Syntax-Überprüfung durch..."
flake8 . || { echo "Syntax-Fehler gefunden."; exit 1; }
pylint **/*.py || { echo "Stil-Fehler gefunden."; exit 1; }

# Führe Sicherheits-Überprüfung durch
echo "Führe Sicherheits-Überprüfung durch..."
bandit -r . || { echo "Sicherheitsprobleme gefunden."; exit 1; }

# Starte das Python-Skript im Hintergrund und speichere die PID
python3 app.py > app.log 2>&1 &
APP_PID=$!

# Warte 30 Sekunden
sleep 30

# Prüfe, ob der Prozess noch läuft
if ps -p $APP_PID > /dev/null
then
   # Wenn der Prozess noch läuft, beende ihn
   kill $APP_PID
   wait $APP_PID 2>/dev/null
   echo "Der Prozess wurde nach 30 Sekunden gestoppt."
else
   echo "Der Prozess wurde innerhalb der Zeit erfolgreich abgeschlossen."
fi

# Überprüfe, ob Fehler in der Log-Datei vorhanden sind
if grep -i "error" app.log > /dev/null
then
    echo "Fehler wurden im Python-Skript festgestellt."
    exit 1
else
    echo "Das Python-Skript hat ohne Fehler abgeschlossen."
    exit 0
fi

#!/bin/bash

# =============================================================================
# SETUP PROGETTO COMPUTAZIONALE: Cu FCC
# Percorso Progetto: /Users/vittoriodibona/Desktop/Tutorial_LAMMPS/Esame/CopperQE
# =============================================================================

# 1. DEFINIZIONE PERCORSI
BASE_DIR="/Users/vittoriodibona/Desktop/Tutorial_LAMMPS/Esame/CopperQE"
QE_DIR="/Users/vittoriodibona/computational_software/qe-7.2"
PSEUDO_NAME="Cu.pbe-dn-kjpaw_psl.1.0.0.UPF"

# Colori per l'output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}--- Inizio Setup Struttura Directory ---${NC}"
echo "Target: $BASE_DIR"

# 2. CREAZIONE TREE DI DIRECTORY
# Creiamo la cartella base se non esiste
if [ ! -d "$BASE_DIR" ]; then
    echo "La cartella base non esisteva, la creo..."
    mkdir -p "$BASE_DIR"
fi

cd "$BASE_DIR"

# Creazione sottocartelle
echo "Generazione sottocartelle..."

# Cartella per i pseudopotenziali locali del progetto
mkdir -p pseudo

# Cartella per file temporanei (per non intasare tutto)
mkdir -p tmp

# 1. Convergenza (Ecut, K-points, Smearing)
mkdir -p 1_convergence/ecut
mkdir -p 1_convergence/kpoints
mkdir -p 1_convergence/smearing

# 2. Equazione di Stato (Murnaghan)
mkdir -p 2_eos

# 3. Proprietà Elettroniche
mkdir -p 3_electronic/scf     # Per la densità
mkdir -p 3_electronic/bands   # Per le bande
mkdir -p 3_electronic/dos     # Per la DOS

# Cartella per script Python
mkdir -p scripts

# 3. GESTIONE PSEUDOPOTENZIALE
# Copiamo il file dalla tua installazione QE alla cartella del progetto
SOURCE_PSEUDO="$QE_DIR/pseudo/$PSEUDO_NAME"
DEST_PSEUDO="$BASE_DIR/pseudo/$PSEUDO_NAME"

if [ -f "$SOURCE_PSEUDO" ]; then
    echo -e "${GREEN}Trovato pseudopotenziale in QE. Lo copio nel progetto...${NC}"
    cp "$SOURCE_PSEUDO" "$DEST_PSEUDO"
    echo "Copiato: $PSEUDO_NAME -> ./pseudo/"
else
    echo -e "\033[0;31mATTENZIONE: Non ho trovato $PSEUDO_NAME in $QE_DIR/pseudo/\033[0m"
    echo "Dovrai scaricarlo o copiarlo manualmente nella cartella $BASE_DIR/pseudo/"
fi

# 4. REPORT FINALE
echo -e "${GREEN}--- Setup Completato con Successo ---${NC}"
echo "Struttura creata in: $BASE_DIR"
ls -F

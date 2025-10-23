import pandas as pd
from datetime import datetime
import os

chemin_fichier_csv = os.path.join(os.path.dirname(os.path.abspath(__file__)), "sae_donnees_bancaires.csv")

df = pd.read_csv(chemin_fichier_csv)

def safe_parse_date(date_str):
    try:
        return pd.to_datetime(date_str, format='%Y-%m-%d', errors='raise')
    except:
        return None

colonnes_avec_dates = ['ddn', 'date_rattachement', 'dt_mouvement', 'date_parrainage', 'ddn_agent']
for colonne in colonnes_avec_dates:
    df[colonne] = df[colonne].apply(safe_parse_date)

chemin_final = os.path.join(os.path.dirname(os.path.abspath(__file__)), "sae_donnees_bancaires_nettoyee.csv")
df.to_csv(chemin_final, index=False, encoding='utf-8', na_rep='')

print(f"Fichier nettoyé")
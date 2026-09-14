# Séance 1 — lancement de toutes les applications corrigées
# Placer ce fichier dans le même dossier que modele_audit.R.

source('modele_audit.R')

application1()           # Note commerciale contre audit corrigé
application2()           # Tableau complet des flux Atlas Process
application3()           # Sensibilité univariée aux MWh évités
cas_bfr_terminal()       # Exercice BFR et valeur terminale
cas_bfr_terminal(taux_recuperation=.80)
pont_valeur()            # Décomposition de l’écart de VAN
matrice_sensibilite()    # MWh évités × prix évitable
seuil_gain_mwh()         # Seuil technique de VAN nulle
seuils_decision()        # Seuils volume, prix et maintenance
cas_normalisation_activite() # Économie corrigée du niveau d’activité
cout_report()            # Coût financier d’un report pur d’un an
cas_remplacement()       # Remplacer aujourd’hui contre réparer en année 2
revue_ex_post()          # Dossier autorisé contre données observées
ticket_sortie()          # Contrôle individuel

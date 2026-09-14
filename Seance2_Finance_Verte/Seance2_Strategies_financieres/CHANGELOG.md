# Version initiale — Séance 2

- séance recalibrée sur 210 minutes ;
- prolongement narratif direct de la séance 1 ;
- cinq investissements verts aux classements contradictoires ;
- approfondissement VAN, TRI, taux de croisement et flux différentiels ;
- comparaison de durées différentes par annuité équivalente et remplacement ;
- traitement du délai actualisé, des TRI multiples et du taux ;
- portefeuille sous contrainte budgétaire et dépendance technique ;
- douze applications R avec code complet repliable ;
- exercices, corrigés interprétés et commentaires oraux ;
- synthèse, checklist et transition vers la séance 3 ;
- prévention de l’affichage accidentel du JavaScript.

## Enrichissement théorique et conceptuel

- clarification de l’unité de décision, des ressources rares et des interactions entre projets ;
- ajout des notions de synergie, frontière d’efficience et coût d’opportunité du capital ;
- approfondissement de l’intuition, de l’additivité et des limites de la VAN ;
- distinction détaillée entre acceptation isolée et classement VAN–TRI ;
- exemple numérique intégralement déroulé ;
- développement du taux de croisement et des conflits temporels ;
- approfondissement des flux différentiels et des différences d’échelle ;
- clarification du service économique, de l’annuité et du coût annuel équivalent ;
- approfondissement du payback, des TRI multiples et du TRI modifié ;
- cohérence taux–flux, nominal–réel et double comptage du risque ;
- rationnement faible/fort, contraintes multiples et divisibilité ;
- articulation transparente entre VAN financière, prix interne et cible environnementale.

## Correctif d’exécution WebR

- suppression de la dépendance à `source("modele_comparaison.R")` dans le navigateur ;
- intégration de toutes les fonctions nécessaires dans chacune des treize cellules d’application ;
- cellules exécutables indépendamment et dans n’importe quel ordre ;
- conservation du code complet dans des volets développables et réductibles ;
- maintien du script consolidé dans l’annexe et dans le fichier R séparé.

## Correctif des applications 4 à 6

- arrondi limité aux colonnes numériques des tableaux contenant du texte ;
- correction des applications 4 (`Projet`), 5 (`Strategie`) et 6 (`Critere`) ;
- affichage pédagogique du délai actualisé non atteint au lieu de `Inf` ;
- mise à jour des résultats de référence de l’annuité équivalente.

## Audit final de cohérence

- recalcul croisé de toutes les VAN, TRI, délais, IP, annuités et portefeuilles ;
- correction du grand projet : VAN 388,77 kMAD, TRI 13,54 %, VAN différentielle 247,62 kMAD ;
- correction de l’exemple illustrant les flux ignorés par le payback ;
- ajout des valeurs contrôlées pour les applications 5, 8, 9 et 12 ;
- clarification du stress avec et sans dépendance technique ;
- sécurisation des produits matriciels et de l’affichage de l’application 11 ;
- ajout d’un rapport d’audit final dans le package.

## Correctif de compilation Quarto sous Windows

- vérification explicite de `resources/tinyyaml.lua` et des ressources critiques ;
- réinstallation automatique si l’extension existe mais reste incomplète ;
- contrôle après installation et message d’erreur exploitable ;
- documentation de l’extraction dans un dossier neuf ;
- confirmation que l’extension complète et `tinyyaml.lua` sont inclus dans le ZIP.

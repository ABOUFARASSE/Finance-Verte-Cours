# Guide enseignant — Séance 2 (3 h 30)

## Finalité

Faire passer les participants de l’évaluation isolée à la comparaison et à l’allocation. La séance installe une hiérarchie claire : la VAN mesure la création de valeur ; le TRI, le délai et l’indice de profitabilité apportent des lectures complémentaires ; les conflits se résolvent par les flux différentiels, la comparabilité des horizons et l’optimisation des combinaisons.

La version enrichie suit une progression explicative constante : intuition économique → définition → formule → hypothèses → erreur fréquente → usage décisionnel. Le contenu théorique peut être modulé selon le niveau du groupe, mais l’exemple guidé de la section 3.6 doit être conservé pour stabiliser le vocabulaire commun.

## Déroulé conseillé — 210 minutes

| Temps | Animation | Production | Vigilance |
|---:|---|---|---|
| 0–15 | Histoire et diagnostic | Carte des contradictions | Ne pas corriger avant le vote |
| 15–40 | Relations, interactions et critères | Typologie, synergies et tableau de discipline | Séparer acceptation, classement, allocation |
| 40–75 | VAN, TRI, profils temporels | Taux de croisement interprété | Ne pas confondre croisement et coût du capital |
| 75–100 | Échelle et flux différentiels | Choix petit/grand | Faire verbaliser l’usage du capital additionnel |
| 100–110 | Pause | — | — |
| 110–140 | Durées différentes | AE et chaîne de remplacement | Tester la répétabilité du service |
| 140–165 | Payback, TRI multiples et cohérence du taux | Alertes méthodologiques | Revenir à la VAN lorsque le TRI est ambigu |
| 165–195 | Portefeuille et objectifs environnementaux | Note de comité | Réoptimiser, éviter le double comptage |
| 195–210 | Ticket et synthèse | Décision individuelle | Exiger résultat, mécanisme, condition |

## Résultats numériques de référence

| Élément | Résultat approximatif |
|---|---:|
| VAN Efficacité à 10 % | 150,13 kMAD |
| VAN Solaire à 10 % | 527,52 kMAD |
| VAN Eau à 10 % | 60,24 kMAD |
| VAN Matières à 10 % | 115,94 kMAD |
| VAN Modernisation à 10 % | 94,68 kMAD |
| Taux de croisement A–B | 33,87 % |
| VAN petit projet | 141,15 kMAD |
| VAN grand projet | environ 388,77 kMAD |
| TRI grand projet | environ 13,54 % |
| VAN différentielle grand−petit | environ 247,62 kMAD |
| AE projet court à 9 % | environ 34,45 kMAD/an |
| AE projet long à 9 % | environ 61,96 kMAD/an |
| Chaîne court sur 21 ans | environ 320,12 kMAD |
| Chaîne long sur 21 ans | environ 575,79 kMAD |
| Portefeuille central | Efficacité + Solaire |
| Coût du portefeuille | 4 400 kMAD |
| VAN du portefeuille | environ 677,65 kMAD |
| VAN stressée du solaire | environ 80,22 kMAD |
| VAN stressée Solaire + Efficacité | environ 68,34 kMAD |
| Ticket : VAN A à 11 % | −10,83 kMAD |
| Ticket : VAN B à 11 % | 13,70 kMAD |
| Ticket : VAN différentielle B−A | 24,53 kMAD |

## Questions de relance

- Les projets sont-ils réellement exclusifs ou seulement concurrents pour une ressource ?
- Quel usage supposez-vous pour le capital non investi ?
- Le service économique est-il comparable sur le même horizon ?
- Que mesure ce pourcentage que la VAN ne mesure pas ?
- Le taux de croisement est-il un taux pertinent ou seulement une frontière ?
- Quelle combinaison remplace celle que vous recommandez si le budget baisse ?
- Quel bénéfice environnemental est déjà monétarisé dans les flux ?
- Quelle condition rend l’autorisation réversible ou contrôlable ?

## Notions à faire verbaliser

- La VAN est un montant d’équivalent présent, pas une trésorerie immédiatement disponible.
- Le TRI est un taux implicite des flux, pas le rendement certain du projet.
- Un conflit de classement n’est pas une erreur de calcul : il révèle souvent une différence d’échelle ou de calendrier.
- L’annuité équivalente compare des services répétitifs, pas simplement deux durées.
- Le payback peut constituer une contrainte de liquidité, mais pas une mesure complète de valeur.
- Sous budget limité, la décision porte sur la combinaison et son coût d’opportunité.
- L’effet environnemental doit être un flux démontré, un ajustement séparé ou une contrainte physique.

## Utilisation du code R

Chaque application possède un volet « Code R complet » replié par défaut. Développer le code pour expliquer la fonction, exécuter l’application, puis réduire le volet pour commenter le résultat. L’annexe contient le script consolidé. Le fichier `LANCER_TOUT.R` reproduit l’ensemble des applications dans l’ordre.

Les cellules sont indépendantes : cliquer directement sur « Run » dans n’importe quelle application suffit. Chaque cellule redéfinit ses fonctions auxiliaires avant l’appel final. Cette redondance est volontaire afin d’éviter les erreurs du type `could not find function` lorsque les applications sont exécutées dans un ordre différent pendant la séance.

## Correction de l’atelier

Le portefeuille central est Efficacité + Solaire. La justification ne doit pas se limiter à leur rang : il faut établir la faisabilité sous 5 000 kMAD, l’absence de double comptage, la capacité d’exécution et la robustesse. Un bon groupe conserve les projets non retenus dans une liste d’attente et définit une règle de réoptimisation en cas de baisse du budget ou de VAN.

## Transition

La séance 3 partira de l’enveloppe budgétaire elle-même : financement interne, dette, subventions, contraintes et coût des ressources. Insister sur la distinction entre décision d’investissement et décision de financement, tout en montrant leur coordination dans la stratégie de transition.

# Rapport d’audit final — Séance 2

## Périmètre du contrôle

L’audit couvre le script R consolidé, les treize cellules WebR autonomes, les résultats annoncés dans les corrigés, les interprétations financières, le guide enseignant et le HTML autonome. Les calculs ont été reproduits indépendamment à partir des séries de flux et des taux affichés.

## Résultats de référence validés

### Portefeuille initial — taux de 10 %

| Projet | VAN (kMAD) | TRI | Délai simple | Délai actualisé | IP |
|---|---:|---:|---:|---:|---:|
| Efficacité | 150,13 | 14,17 % | 3,87 | 5,14 | 1,125 |
| Solaire | 527,52 | 12,72 % | 6,67 | 11,54 | 1,165 |
| Eau | 60,24 | 11,47 % | 6,00 | 9,38 | 1,067 |
| Matières | 115,94 | 11,74 % | 4,71 | 6,46 | 1,064 |
| Modernisation | 94,68 | 11,52 % | 3,60 | 5,44 | 1,038 |

### Autres applications

| Application | Résultats contrôlés |
|---|---|
| Profils A–B | VAN à 10 % : 76,03 et 198,35 ; TRI : 15,62 % et 20,42 % ; croisement : 33,87 % |
| Échelle petit–grand | VAN : 141,15 et 388,77 ; TRI : 16,37 % et 13,54 % ; VAN différentielle : 247,62 |
| Durées différentes | VAN : 87,20 et 311,86 ; AE : 34,45 et 61,96 |
| Remplacements sur 21 ans | VAN : 320,12 et 575,79 |
| Payback | délai simple : 4,10 ; délai actualisé non atteint ; VAN : −0,78 ; TRI : 9,98 % |
| Flux non conventionnels | deux TRI : 10 % et 20 % ; VAN à 10 % : 0 |
| Projet eau | VAN de 259,85 à −122,47 lorsque le taux passe de 6 % à 15 % |
| Portefeuille central | Efficacité + Solaire ; coût : 4 400 ; VAN : 677,65 |
| Stress −12 % | solaire seul : 80,22 ; Efficacité + Solaire : 68,34 |
| Ticket de sortie | VAN A : −10,83 ; VAN B : 13,70 ; VAN B−A : 24,53 |

## Corrections apportées

1. L’arrondi est désormais appliqué uniquement aux colonnes numériques des applications 4, 5 et 6.
2. Le délai actualisé infini est affiché comme « Non récupéré sur l’horizon ».
3. Les valeurs commentées de l’application 4 ont été alignées sur le taux de 9 %.
4. Le TRI du grand projet, sa VAN et la VAN différentielle ont été rectifiés.
5. L’exemple pédagogique sur les flux ignorés par le payback a été corrigé.
6. La variable de l’application 7 est renommée `non_conventionnel`.
7. Les produits matriciels de l’optimisation sont convertis explicitement en vecteurs numériques.
8. L’application 11 n’imprime plus le tableau non contraint avant son propre résultat.
9. Les résultats du stress distinguent le cas sans dépendance et le cas où le solaire exige l’efficacité.
10. Les cellules WebR restent autonomes et exécutables dans n’importe quel ordre.

## Cohérence décisionnelle validée

- La VAN est utilisée pour la création de valeur et les choix exclusifs.
- Le TRI et le délai sont interprétés comme indicateurs complémentaires.
- Les différences d’échelle sont traitées par les flux différentiels.
- Les différences de durée sont corrigées par annuité et chaîne de remplacement.
- La contrainte budgétaire porte sur les combinaisons et non sur un simple classement.
- Les résultats environnementaux sont séparés des flux financiers lorsqu’ils ne sont pas monétisés.

# Séance 1 — Stratégies financières et gestion des ressources

Support Quarto Live enrichi au format du module précédent. Le fichier HTML fourni fonctionne immédiatement comme document de cours navigable et comprend un simulateur sans dépendance. Le code R est replié par défaut afin de préserver la lecture ; chaque application développe sa fonction complète et sa commande, tandis qu’une annexe contient le script consolidé intégral. Les sources QMD permettent de reconstruire la version Quarto Live avec cellules R exécutables ; leur première initialisation demande un navigateur moderne et un accès réseau.

Cette version finale approfondit le cadre conceptuel du *capital budgeting*, la construction du scénario de référence, l’additionnalité, la distinction entre résultat, trésorerie et financement, ainsi que les usages respectifs de la sensibilité, des scénarios et des tests de résistance. Les corrigés ne donnent pas seulement les calculs : ils explicitent la logique financière, les limites du résultat et la décision à formuler au comité. La séance se clôt par une synthèse opérationnelle et une transition préparée vers la comparaison des critères de choix de la séance 2.

## Utilisation immédiate

Ouvrir `seance1_live_doc.html` dans un navigateur. Les corrigés se déplient et le simulateur répond immédiatement. Les blocs R y sont accompagnés de leurs résultats de référence dans les corrigés.

## Modifier et reconstruire

1. Installer Quarto : https://quarto.org/docs/get-started/
2. Sous Windows, lancer `00_repair_extension_and_preview.bat` pour la prévisualisation interactive.
3. Modifier `seance1_live_doc.qmd`, `modele_audit.R` ou `styles_live_doc.css`.
4. Exécuter `quarto render seance1_live_doc.qmd`.

## Fichiers

- `seance1_live_doc.html` : support prêt à enseigner ;
- `seance1_live_doc.qmd` et `index.qmd` : sources Quarto Live ;
- `modele_audit.R` : fonctions R consolidées et vérifiées ;
- `LANCER_TOUT.R` : exécution séquentielle de toutes les applications ;
- `Guide_enseignant_seance1.md` : déroulé de 150 minutes, relances et résultats attendus ;
- `styles_live_doc.css`, `toc-collapse.js`, `simulateur.js` : présentation et interaction ;
- `scripts-after-body.html` : charge correctement les scripts dans les rendus Quarto sans afficher leur code dans la page ;
- `code-controls.js` : commandes permettant de développer ou réduire tous les codes R ;
- `assets/` : figures de référence ;
- `_extensions/` : extension locale Quarto Live/WebR.

Les montants et paramètres du cas Atlas Process sont fictifs et pédagogiques.

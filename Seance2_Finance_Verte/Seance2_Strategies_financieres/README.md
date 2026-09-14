# Séance 2 — Comparer et classer les investissements verts

Package pédagogique de 3 h 30 au même format que la séance 1. Le support suit le comité Atlas Process et traite les conflits VAN–TRI, les différences d’échelle et de durée, le délai de récupération, les TRI multiples, le taux d’actualisation et la sélection d’un portefeuille sous contrainte budgétaire.

Cette version approfondie développe l’intuition économique et les hypothèses de chaque critère, l’additivité de la VAN, les interactions entre projets, les flux différentiels, la comparabilité du service, la cohérence nominal/réel et l’intégration transparente des objectifs environnementaux. Un exemple numérique entièrement guidé facilite l’entrée dans les applications avancées.

## Utilisation immédiate

Ouvrir `seance2_live_doc.html` dans un navigateur. Le fichier est autonome. Les corrigés et les codes R sont repliés par défaut ; les commandes globales permettent de développer ou réduire tous les scripts.

## Fichiers principaux

- `seance2_live_doc.html` : support prêt à enseigner ;
- `seance2_live_doc.qmd` et `index.qmd` : sources Quarto Live ;
- `modele_comparaison.R` : modèle R complet ;
- `LANCER_TOUT.R` : exécution séquentielle ;
- `Guide_enseignant_seance2.md` : chronométrage, relances et résultats ;
- `Rapport_audit_final.md` : contrôle croisé des calculs, corrigés et interprétations ;
- `scripts-after-body.html` : chargement correct des scripts sans code visible ;
- `styles_live_doc.css`, `toc-collapse.js`, `code-controls.js` : interface.

## Reconstruction

Installer Quarto, puis lancer `00_repair_extension_and_preview.bat` sous Windows. La première initialisation de WebR nécessite un navigateur moderne et une connexion réseau. Les données sont fictives et pédagogiques.

Le lanceur contrôle désormais les fichiers critiques de l’extension, notamment `_extensions/r-wasm/live/resources/tinyyaml.lua`. Si un dossier d’extension partiel provient d’une ancienne extraction, il est supprimé puis réinstallé automatiquement. Pour éviter qu’un ancien dossier incomplet soit conservé, extraire cette version du ZIP dans un **nouveau dossier vide**.

Si la compilation s’arrête sur `module 'resources/tinyyaml' not found` : fermer Quarto, supprimer l’ancien dossier extrait, décompresser à nouveau le package complet, puis lancer `00_repair_extension_and_preview.bat`. Le fichier `tinyyaml.lua` est déjà inclus dans cette version.

Chaque cellule WebR est autonome : elle contient la fonction exécutée et toutes ses dépendances. Il n’est donc pas nécessaire d’exécuter une cellule d’initialisation ni de charger `modele_comparaison.R` avant une démonstration. Le script reste replié par défaut et peut être développé pour l’explication ou la modification en direct.

Les valeurs de référence figurant dans les corrigés et dans le guide ont été recalculées indépendamment. En particulier, le stress commun est interprété séparément selon que la dépendance entre solaire et efficacité est imposée ou non.

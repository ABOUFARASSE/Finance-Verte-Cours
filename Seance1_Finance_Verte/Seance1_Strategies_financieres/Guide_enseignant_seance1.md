# Guide enseignant — Séance 1

## Finalité

Amener des professionnels à passer d’une proposition d’investissement persuasive à une décision financière traçable. La séance ne cherche pas à multiplier les indicateurs : elle installe la discipline du scénario de référence, des flux incrémentaux, de la preuve et de la recommandation conditionnelle.

## Déroulé conseillé — 150 minutes

| Temps | Animation | Production attendue | Point de vigilance |
|---|---|---|---|
| 0–12 min | Petite histoire, question d’ouverture, diagnostic vrai/faux | Premières questions du comité | Ne pas corriger immédiatement toutes les réponses |
| 12–35 min | Gouvernance du capital, mandat, référence, coûts et normalisation | Grille de classement | Distinguer investissement et financement, attractivité et faisabilité |
| 35–62 min | EBITDA, EBIT, impôt, FCF, BFR et terminal | Flux guidé de l’année 1 | Faire verbaliser résultat, trésorerie et financement |
| 62–105 min | Cas Atlas Process en groupes | Tableau 0–8 et note d’une page | Exiger une preuve pour chaque hypothèse sensible |
| 105–125 min | Pont de valeur, matrice et seuils | Condition contractuelle | Faire interpréter, pas seulement lire les nombres |
| 125–140 min | Un exercice approfondi au choix | Recommandation argumentée | Garder les autres exercices pour l’interséance |
| 140–150 min | Ticket de sortie, synthèse et transition vers la séance 2 | Recommandation individuelle | Vérifier décision, motif, condition et préparation de la comparaison des critères |

## Questions de relance

- Que se passe-t-il réellement si l’entreprise refuse le projet ?
- Quel flux disparaît, et à quelle date ?
- Cette économie est-elle physique, monétaire ou les deux ?
- Quel élément pourrait inverser la décision ?
- Qui peut produire la preuve, avant quelle date ?
- Quelle décision prendriez-vous si le capital était disponible mais pas l’équipe technique ?

## Commentaires oraux

Le support comprend des encadrés « Commentaire à lire aux participants ». Ils servent de transitions entre le calcul et la décision. Ils peuvent être lus littéralement ou reformulés. Ils insistent sur le rôle du comité, la pluralité des décisions, la construction du scénario de référence, la séparation entre cash et résultat environnemental, le pont de valeur, la traduction des sensibilités en conditions et l’apprentissage ex post.

Les développements théoriques peuvent être enseignés comme une chaîne unique : gouvernance de l’investissement → scénario contrefactuel → flux incrémentaux → traduction physique et monétaire → cash-flow → actualisation → robustesse → autorisation → revue ex post. À chaque étape, demander aux participants non seulement « combien ? », mais aussi « comparé à quoi ? », « à quelle date ? », « sur quelle preuve ? » et « quelle décision ce résultat autorise-t-il ? ».

Le code R complet de chaque fonction reste accessible dans son application. Au début d’une démonstration, utiliser « Développer tout le code R » ; après l’interprétation, utiliser « Réduire tout le code R » afin de recentrer l’attention sur la lecture stratégique. L’annexe technique permet de montrer l’intégralité du modèle consolidé.

## Résultats numériques de référence

| Application | Résultat |
|---|---:|
| Note commerciale incomplète | VAN = 1 400,96 kMAD |
| Atlas Process corrigé | VAN = 283,57 kMAD |
| Seuil d’économie physique | 436,72 MWh/an |
| Cas BFR, récupération totale | VAN = −94,53 kMAD |
| Cas BFR, récupération à 80 % | VAN = −105,16 kMAD |
| Remplacement contre réparation | VAN = 264,14 kMAD |
| Ticket de sortie | VAN = −90,21 kMAD |
| Revue ex post d’Atlas Process | VAN = −326,71 kMAD |
| Coût d’un report pur d’un an | 25,78 kMAD |
| Prix évitable minimal | 1,048 MAD/kWh |
| Maintenance annuelle maximale | 135,934 kMAD/an |

## Lecture stratégique attendue

Une VAN positive n’est pas synonyme d’autorisation automatique. Atlas Process doit être poursuivi sous conditions, car la création de valeur dépend d’un seuil physique vérifiable. Le comité doit relier la condition d’engagement au protocole de mesure, au prix réellement évitable, au devis ferme et à la capacité d’exécution. La revue ex post transforme les écarts en apprentissage pour l’allocation future du capital.

Dans les corrigés, faire distinguer quatre niveaux : le résultat numérique, son mécanisme explicatif, sa robustesse et la recommandation. Une réponse n’est complète que si elle passe du calcul à une formulation de comité précisant le montant, la condition de poursuite, la preuve attendue et l’alternative en cas d’échec.

## Clôture et transition

La synthèse finale reconstruit les dix étapes de la décision et applique la checklist au cas Atlas Process. La transition vers la séance 2 doit créer une nouvelle tension pédagogique : les dossiers sont désormais correctement construits, mais la VAN, le TRI et le délai de récupération peuvent les classer différemment. Demander aux participants de conserver cette question : « quelle règle doit primer lorsque des indicateurs financièrement recevables se contredisent ? »

## Critères d’une bonne note de comité

La note doit annoncer l’issue proposée dès la première phrase, préciser le montant autorisé, distinguer valeur financière et contribution environnementale, identifier les hypothèses de basculement et formuler des conditions vérifiables avec responsables et dates.

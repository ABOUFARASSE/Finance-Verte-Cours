# Séance 2 — Comparer et classer des investissements verts
# Unité monétaire : milliers de MAD (kMAD). Données fictives et pédagogiques.
# R de base uniquement.

van <- function(flux, taux) {
  sum(flux / (1 + taux)^(seq_along(flux) - 1))
}

tri <- function(flux, borne_basse = -0.99, borne_haute = 10) {
  f <- function(r) van(flux, r)
  grille <- seq(borne_basse, borne_haute, length.out = 20000)
  valeurs <- vapply(grille, f, numeric(1))
  changements <- which(valeurs[-length(valeurs)] * valeurs[-1] <= 0)
  if (length(changements) == 0) return(NA_real_)
  uniroot(f, c(grille[changements[1]], grille[changements[1] + 1]))$root
}

delai_simple <- function(flux) {
  cumul <- cumsum(flux)
  k <- which(cumul >= 0)[1]
  if (is.na(k)) return(Inf)
  if (k == 1) return(0)
  annee_avant <- k - 2
  reste <- -cumul[k - 1]
  annee_avant + reste / flux[k]
}

delai_actualise <- function(flux, taux) {
  flux_actualises <- flux / (1 + taux)^(seq_along(flux) - 1)
  delai_simple(flux_actualises)
}

annuite_equivalente <- function(van_projet, taux, duree) {
  facteur <- (1 - (1 + taux)^(-duree)) / taux
  van_projet / facteur
}

indice_profitabilite <- function(flux, taux) {
  va_pos <- sum(pmax(flux, 0) / (1 + taux)^(seq_along(flux) - 1))
  va_neg <- -sum(pmin(flux, 0) / (1 + taux)^(seq_along(flux) - 1))
  va_pos / va_neg
}

fmt <- function(x, digits = 2) {
  format(round(x, digits), big.mark = " ", decimal.mark = ",",
         nsmall = digits, scientific = FALSE)
}

portefeuille_transition <- function() {
  list(
    Efficacite = c(-1200, rep(310, 6)),
    Solaire = c(-3200, rep(480, 14), 800),
    Eau = c(-900, rep(150, 9), 250),
    Matieres = c(-1800, 260, 310, 390, 470, 520, 480, 420),
    Modernisation = c(-2500, 800, 750, 650, 500, 400, 300)
  )
}

tableau_criteres <- function(taux = 0.10) {
  projets <- portefeuille_transition()
  sortie <- do.call(rbind, lapply(names(projets), function(nom) {
    f <- projets[[nom]]
    data.frame(
      Projet = nom,
      Investissement = -f[1],
      Duree = length(f) - 1,
      VAN = van(f, taux),
      TRI = tri(f),
      Delai = delai_simple(f),
      Delai_actualise = delai_actualise(f, taux),
      IP = indice_profitabilite(f, taux)
    )
  }))
  row.names(sortie) <- NULL
  sortie
}

application1 <- function(taux = 0.10) {
  tab <- tableau_criteres(taux)
  tab$Rang_VAN <- rank(-tab$VAN, ties.method = "min")
  tab$Rang_TRI <- rank(-tab$TRI, ties.method = "min")
  tab$Rang_Delai <- rank(tab$Delai, ties.method = "min")
  print(transform(tab,
    VAN = round(VAN, 2), TRI = round(100 * TRI, 2),
    Delai = round(Delai, 2), Delai_actualise = round(Delai_actualise, 2),
    IP = round(IP, 3)), row.names = FALSE)
  invisible(tab)
}

application2 <- function() {
  A <- c(-1000, 620, 620)
  B <- c(-1000, 0, 1450)
  taux <- c(0.05, 0.10, 0.15, 0.20, 0.25)
  resultat <- data.frame(
    Taux = taux,
    VAN_A = vapply(taux, function(r) van(A, r), numeric(1)),
    VAN_B = vapply(taux, function(r) van(B, r), numeric(1))
  )
  print(round(resultat, 2), row.names = FALSE)
  cat("TRI A =", fmt(100 * tri(A)), "% ; TRI B =", fmt(100 * tri(B)), "%\n")
  invisible(resultat)
}

taux_croisement <- function(flux_A, flux_B) {
  tri(flux_A - flux_B)
}

application3 <- function() {
  petit <- c(-1000, rep(360, 4))
  grand <- c(-5000, rep(1700, 4))
  r <- 0.10
  incrementaux <- grand - petit
  resultat <- data.frame(
    Projet = c("Petit", "Grand", "Grand moins Petit"),
    VAN = c(van(petit, r), van(grand, r), van(incrementaux, r)),
    TRI = c(tri(petit), tri(grand), tri(incrementaux))
  )
  print(transform(resultat, VAN = round(VAN, 2), TRI = round(100 * TRI, 2)),
        row.names = FALSE)
  invisible(resultat)
}

application4 <- function() {
  court <- c(-900, 390, 390, 390)
  long <- c(-1500, rep(360, 7))
  r <- 0.09
  resultat <- data.frame(
    Projet = c("Court", "Long"),
    Duree = c(3, 7),
    VAN = c(van(court, r), van(long, r)),
    AE = c(annuite_equivalente(van(court, r), r, 3),
           annuite_equivalente(van(long, r), r, 7))
  )
  print(transform(resultat,
                  Duree = round(Duree, 0),
                  VAN = round(VAN, 2),
                  AE = round(AE, 2)),
        row.names = FALSE)
  invisible(resultat)
}

chaine_remplacement <- function(flux, repetitions) {
  n <- length(flux) - 1
  horizon <- n * repetitions
  total <- numeric(horizon + 1)
  for (k in 0:(repetitions - 1)) {
    idx <- k * n + seq_along(flux)
    total[idx] <- total[idx] + flux
  }
  total
}

application5 <- function() {
  A <- c(-900, 390, 390, 390)
  B <- c(-1500, rep(360, 7))
  r <- 0.09
  horizon <- 21
  chaine_A <- chaine_remplacement(A, horizon / 3)
  chaine_B <- chaine_remplacement(B, horizon / 7)
  resultat <- data.frame(
    Strategie = c("A répété sur 21 ans", "B répété sur 21 ans"),
    VAN = c(van(chaine_A, r), van(chaine_B, r))
  )
  print(transform(resultat, VAN = round(VAN, 2)), row.names = FALSE)
  invisible(resultat)
}

application6 <- function() {
  projet <- c(-1200, 150, 240, 330, 430, 520)
  r <- 0.10
  resultat <- data.frame(
    Critere = c("Délai simple", "Délai actualisé", "VAN", "TRI"),
    Valeur = c(delai_simple(projet), delai_actualise(projet, r),
               van(projet, r), 100 * tri(projet)),
    Unite = c("années", "années", "kMAD", "%")
  )
  affichage <- resultat
  affichage$Valeur <- ifelse(
    is.finite(resultat$Valeur),
    format(round(resultat$Valeur, 2), decimal.mark = ",", nsmall = 2),
    "Non récupéré sur l'horizon"
  )
  print(affichage, row.names = FALSE)
  invisible(resultat)
}

application7 <- function() {
  non_conventionnel <- c(-100, 230, -132)
  grille <- seq(-0.5, 1.5, by = 0.01)
  valeurs <- vapply(grille, function(r) van(non_conventionnel, r), numeric(1))
  changements <- which(valeurs[-length(valeurs)] * valeurs[-1] <= 0)
  racines <- vapply(changements, function(i) {
    uniroot(function(r) van(non_conventionnel, r), c(grille[i], grille[i + 1]))$root
  }, numeric(1))
  cat("TRI multiples :", paste(fmt(100 * unique(round(racines, 8))), collapse = "% et "), "%\n")
  cat("VAN à 10 % =", fmt(van(non_conventionnel, 0.10)), "\n")
  invisible(racines)
}

application8 <- function() {
  f <- portefeuille_transition()$Eau
  taux <- c(0.06, 0.08, 0.10, 0.12, 0.15)
  resultat <- data.frame(Taux = taux,
    VAN = vapply(taux, function(r) van(f, r), numeric(1)))
  print(transform(resultat, Taux = 100 * Taux, VAN = round(VAN, 2)), row.names = FALSE)
  invisible(resultat)
}

application9 <- function() {
  tab <- tableau_criteres(0.10)
  resultat <- tab[, c("Projet", "Investissement", "VAN", "IP")]
  resultat$Valeur_par_1000_investis <- 1000 * resultat$VAN / resultat$Investissement
  print(transform(resultat, VAN = round(VAN, 2), IP = round(IP, 3),
                  Valeur_par_1000_investis = round(Valeur_par_1000_investis, 2)),
        row.names = FALSE)
  invisible(resultat)
}

application10 <- function(budget = 5000, taux = 0.10, afficher = TRUE) {
  projets <- portefeuille_transition()
  noms <- names(projets)
  cout <- vapply(projets, function(x) -x[1], numeric(1))
  valeur <- vapply(projets, function(x) van(x, taux), numeric(1))
  combinaisons <- expand.grid(rep(list(c(0, 1)), length(projets)))
  names(combinaisons) <- noms
  combinaisons$Cout <- as.vector(as.matrix(combinaisons[, noms]) %*% cout)
  combinaisons$VAN <- as.vector(as.matrix(combinaisons[, noms]) %*% valeur)
  faisables <- combinaisons[combinaisons$Cout <= budget, ]
  faisables <- faisables[order(-faisables$VAN), ]
  if (afficher) {
    print(head(transform(faisables, Cout = round(Cout, 0), VAN = round(VAN, 2)), 8),
          row.names = FALSE)
  }
  invisible(faisables)
}

application11 <- function() {
  # Le solaire n'est recevable que si l'efficacité énergétique est sélectionnée.
  tab <- application10(5000, 0.10, afficher = FALSE)
  contraint <- tab[!(tab$Solaire == 1 & tab$Efficacite == 0), ]
  cat("Meilleur portefeuille avec dépendance :\n")
  print(head(transform(contraint, Cout = round(Cout, 0), VAN = round(VAN, 2)), 5),
        row.names = FALSE)
  invisible(contraint)
}

application12 <- function() {
  projets <- portefeuille_transition()
  base <- tableau_criteres(0.10)
  # Stress commun : -12 % sur tous les flux positifs.
  stress <- vapply(projets, function(f) {
    g <- f; g[g > 0] <- 0.88 * g[g > 0]; van(g, 0.10)
  }, numeric(1))
  resultat <- data.frame(Projet = base$Projet, VAN_centrale = base$VAN,
                         VAN_stress = stress,
                         Basculement = stress < 0)
  print(transform(resultat, VAN_centrale = round(VAN_centrale, 2),
                  VAN_stress = round(VAN_stress, 2)), row.names = FALSE)
  invisible(resultat)
}

ticket_sortie <- function() {
  A <- c(-1500, rep(480, 4))
  B <- c(-1500, 100, 350, 550, 750)
  r <- 0.11
  incrementaux <- B - A
  resultat <- data.frame(
    Projet = c("A", "B", "B moins A"),
    VAN = c(van(A, r), van(B, r), van(incrementaux, r)),
    TRI = c(tri(A), tri(B), tri(incrementaux))
  )
  print(transform(resultat, VAN = round(VAN, 2), TRI = round(100 * TRI, 2)),
        row.names = FALSE)
  invisible(resultat)
}

verifier <- function() {
  stopifnot(abs(van(c(-100, 110), .10)) < 1e-8)
  stopifnot(delai_simple(c(-100, 60, 60)) > 1)
  tab <- tableau_criteres(0.10)
  stopifnot(nrow(tab) == 5)
  stopifnot(abs(tab$VAN[tab$Projet == "Efficacite"] - 150.1308168) < 1e-5)
  stopifnot(abs(tab$VAN[tab$Projet == "Solaire"] - 527.5236188) < 1e-5)
  stopifnot(abs(tab$TRI[tab$Projet == "Efficacite"] - 0.1416682) < 1e-5)
  stopifnot(is.infinite(delai_actualise(c(-1200, 150, 240, 330, 430, 520), 0.10)))
  portefeuille <- application10(5000, 0.10, afficher = FALSE)
  stopifnot(nrow(portefeuille) > 0)
  stopifnot(abs(portefeuille$VAN[1] - 677.6544357) < 1e-5)
  stopifnot(portefeuille$Efficacite[1] == 1, portefeuille$Solaire[1] == 1)
  # Les fonctions contenant des colonnes textuelles doivent s'exécuter sans erreur.
  stopifnot(length(capture.output(application4())) > 0)
  stopifnot(length(capture.output(application5())) > 0)
  stopifnot(length(capture.output(application6())) > 0)
  TRUE
}

# Appels suggérés :
# application1(); application2(); application3(); application4()
# application5(); application6(); application7(); application8()
# application9(); application10(); application11(); application12()
# ticket_sortie(); verifier()

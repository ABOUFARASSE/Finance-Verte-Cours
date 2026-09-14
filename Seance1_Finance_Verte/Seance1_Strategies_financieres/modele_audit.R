# Séance 1 : audit d'un investissement, cas fictif Atlas Process
# Unité monétaire : milliers de MAD (kMAD). Aucune donnée de marché.
# R de base seulement. Paramètres fiscaux pédagogiques, non droit marocain.
parametres <- function() list(n=8L, taux=.10, impot=.30,
  achat=1800, installation=200, bfr=120, gain_mwh=500,
  prix_kwh=1.20, maintenance=60, opportunite=36, cession=200)
van <- function(flux, taux) sum(flux/(1+taux)^(seq_along(flux)-1))
annuite <- function(taux, n) sum(1/(1+taux)^(1:n))
fmt <- function(x, digits=2) format(round(x,digits),big.mark=' ',decimal.mark=',',
  nsmall=digits,scientific=FALSE)
modele <- function(p=parametres()) {
  stopifnot(p$n>=1, p$n==as.integer(p$n), p$taux> -1,
            p$impot>=0, p$impot<=1, p$bfr>=0)
  an <- 0:p$n
  investissement <- p$achat+p$installation
  # MWh * 1000 kWh/MWh * MAD/kWh / 1000 MAD/kMAD
  economie <- p$gain_mwh*p$prix_kwh
  amort <- investissement/p$n
  ebitda <- economie-p$maintenance-p$opportunite
  ebit <- ebitda-amort
  # Les économies fiscales sont immédiatement utilisables par hypothèse.
  impot <- ebit*p$impot
  exploitation <- ebit-impot+amort
  capex <- c(investissement,rep(0,p$n))
  delta_bfr <- c(p$bfr,rep(0,p$n-1),-p$bfr)
  # Valeur comptable nulle à la fin de la huitième année.
  cession_nette <- c(rep(0,p$n),p$cession*(1-p$impot))
  fcf <- c(0,rep(exploitation,p$n))-capex-delta_bfr+cession_nette
  data.frame(annee=an,economies=c(0,rep(economie,p$n)),
    couts_cash=c(0,rep(p$maintenance+p$opportunite,p$n)),
    amortissement=c(0,rep(amort,p$n)),EBIT=c(0,rep(ebit,p$n)),
    impot=c(0,rep(impot,p$n)),flux_exploitation=c(0,rep(exploitation,p$n)),
    CAPEX=capex,variation_BFR=delta_bfr,cession_nette=cession_nette,
    FCF=fcf,FCF_actualise=fcf/(1+p$taux)^an)
}
# APPLICATION 1 : rapprochement de la proposition et du dossier corrigé
application1 <- function() {
  p <- parametres(); d <- modele(p)
  brut <- c(-p$achat,rep(p$gain_mwh*p$prix_kwh,p$n))
  comparaison <- data.frame(dossier=c('Commercial incomplet','Audit corrige'),
    besoin_initial=c(p$achat,p$achat+p$installation+p$bfr),
    VAN=c(van(brut,p$taux),van(d$FCF,p$taux)))
  print(comparaison,row.names=FALSE)
  barplot(comparaison$VAN,names.arg=comparaison$dossier,
    col=c('#c55a11','#1f4e79'),ylab='VAN (kMAD)',main='Effet de l audit',las=1)
  abline(h=0,col='gray50'); invisible(comparaison)
}
# APPLICATION 2 : chronologie des flux
application2 <- function() {
  p <- parametres(); d <- modele(p)
  print(round(d,2),row.names=FALSE)
  barplot(d$FCF,names.arg=d$annee,col=ifelse(d$FCF<0,'#c55a11','#1f4e79'),
    xlab='Annee',ylab='Flux disponible (kMAD)',main='Investir puis recuperer les flux')
  abline(h=0); invisible(d)
}
# APPLICATION 3 : test de la preuve technique, pas prévision de marché
application3 <- function() {
  gains <- c(375,450,500,550)
  resultats <- data.frame(gain_mwh=gains,economie_kMAD=NA_real_,VAN=NA_real_)
  for(i in seq_along(gains)) {
    p <- parametres(); p$gain_mwh <- gains[i]
    resultats$economie_kMAD[i] <- gains[i]*p$prix_kwh
    resultats$VAN[i] <- van(modele(p)$FCF,p$taux)
  }
  print(round(resultats,2),row.names=FALSE)
  plot(resultats$gain_mwh,resultats$VAN,type='b',pch=19,col='#1f4e79',
    xlab='Economie annuelle (MWh)',ylab='VAN (kMAD)',main='Une hypothese a documenter')
  abline(h=0,lty=2,col='#c55a11'); invisible(resultats)
}
# EXERCICE : BFR et valeur terminale
cas_bfr_terminal <- function(taux=.09,taux_recuperation=1) {
  stopifnot(taux_recuperation>=0,taux_recuperation<=1)
  terminal <- 260 + 75*taux_recuperation + 120
  flux <- c(-1075,260,260,260,terminal)
  d <- data.frame(annee=0:4,flux=flux,
    facteur_actualisation=1/(1+taux)^(0:4),
    valeur_actuelle=flux/(1+taux)^(0:4))
  print(round(d,3),row.names=FALSE)
  cat('VAN :',round(van(flux,taux),2),'kMAD\n')
  barplot(flux,names.arg=0:4,col=ifelse(flux<0,'#c55a11','#1f4e79'),
    xlab='Année',ylab='Flux (kMAD)',main='BFR et valeur terminale')
  abline(h=0,col='gray50')
  invisible(d)
}
# APPLICATION 4 : expliquer la révision de la VAN ligne par ligne
pont_valeur <- function() {
  p <- parametres(); a <- annuite(p$taux,p$n)
  niveau <- c(
    -p$achat + p$gain_mwh*p$prix_kwh*a,
    -(p$achat+p$installation) + p$gain_mwh*p$prix_kwh*a,
    -(p$achat+p$installation) +
      (p$gain_mwh*p$prix_kwh-p$maintenance-p$opportunite)*a,
    -(p$achat+p$installation) + modele(p)$flux_exploitation[2]*a,
    -(p$achat+p$installation+p$bfr) + modele(p)$flux_exploitation[2]*a +
      p$bfr/(1+p$taux)^p$n,
    van(modele(p)$FCF,p$taux))
  libelle <- c('Note commerciale','Installation complète','Coûts cash pertinents',
    'Fiscalité et amortissement','BFR récupéré','Cession nette')
  impact <- c(niveau[1],diff(niveau))
  resultat <- data.frame(etape=libelle,impact_VAN=impact,VAN_apres_etape=niveau)
  print(transform(resultat,impact_VAN=round(impact_VAN,2),
    VAN_apres_etape=round(VAN_apres_etape,2)),row.names=FALSE)
  barplot(impact,names.arg=seq_along(impact),
    col=ifelse(impact<0,'#c55a11','#1f4e79'),
    xlab='Étape du pont',ylab='Impact sur la VAN (kMAD)',
    main='De la promesse commerciale au cash audité')
  abline(h=0,col='gray50')
  invisible(resultat)
}

# APPLICATION 5 : sensibilité croisée et seuil technique
matrice_sensibilite <- function(gains=c(375,450,500,550),
                                prix=c(.90,1.20,1.50)) {
  z <- matrix(NA_real_,nrow=length(gains),ncol=length(prix),
    dimnames=list(paste0(gains,' MWh'),paste0(prix,' MAD/kWh')))
  for(i in seq_along(gains)) for(j in seq_along(prix)) {
    p <- parametres(); p$gain_mwh <- gains[i]; p$prix_kwh <- prix[j]
    z[i,j] <- van(modele(p)$FCF,p$taux)
  }
  print(round(z,2))
  matplot(gains,z,type='b',pch=19,lty=1,lwd=2,
    col=c('#c55a11','#1f4e79','#2f6f44'),
    xlab='Énergie évitée (MWh/an)',ylab='VAN (kMAD)',
    main='Sensibilité croisée : performance et prix')
  abline(h=0,lty=2,col='gray40')
  legend('topleft',legend=colnames(z),col=c('#c55a11','#1f4e79','#2f6f44'),
    lty=1,pch=19,bty='n')
  invisible(z)
}

seuil_gain_mwh <- function(p=parametres(),intervalle=c(100,900),afficher=TRUE) {
  f <- function(g) {q <- p; q$gain_mwh <- g; van(modele(q)$FCF,q$taux)}
  seuil <- uniroot(f,interval=intervalle)$root
  if(afficher) cat('Seuil de VAN nulle :',round(seuil,2),'MWh/an\n')
  invisible(seuil)
}

# APPLICATION 6 : plusieurs seuils utiles pour négocier les conditions
seuils_decision <- function(p=parametres(),afficher=TRUE) {
  f_gain <- function(x) {q<-p;q$gain_mwh<-x;van(modele(q)$FCF,q$taux)}
  f_prix <- function(x) {q<-p;q$prix_kwh<-x;van(modele(q)$FCF,q$taux)}
  f_maint <- function(x) {q<-p;q$maintenance<-x;van(modele(q)$FCF,q$taux)}
  r <- data.frame(
    variable=c('Énergie évitée minimale','Prix évitable minimal',
      'Maintenance annuelle maximale'),
    seuil=c(uniroot(f_gain,c(100,900))$root,
      uniroot(f_prix,c(.10,3))$root,
      uniroot(f_maint,c(0,500))$root),
    unite=c('MWh/an','MAD/kWh','kMAD/an'))
  if(afficher) print(transform(r,seuil=round(seuil,3)),row.names=FALSE)
  invisible(r)
}

# APPLICATION 7 : normaliser l'activité avant de valoriser l'économie
cas_normalisation_activite <- function(production_avant=10000,
    production_apres=12000,intensite_avant=200,intensite_apres=160,
    prix_kwh=1.20) {
  conso_avant <- production_avant*intensite_avant/1000
  conso_apres <- production_apres*intensite_apres/1000
  reference_ajustee <- production_apres*intensite_avant/1000
  economie_naive <- conso_avant-conso_apres
  economie_ajustee <- reference_ajustee-conso_apres
  r <- data.frame(indicateur=c('Consommation avant','Consommation après',
      'Référence à activité comparable','Économie observée naïve',
      'Économie ajustée de l’activité','Valeur ajustée'),
    valeur=c(conso_avant,conso_apres,reference_ajustee,economie_naive,
      economie_ajustee,economie_ajustee*prix_kwh),
    unite=c(rep('MWh/an',5),'kMAD/an'))
  print(transform(r,valeur=round(valeur,2)),row.names=FALSE)
  barplot(c(economie_naive,economie_ajustee),
    names.arg=c('Comparaison naïve','Activité comparable'),
    col=c('#c55a11','#1f4e79'),ylab='Économie (MWh/an)',
    main='Le scénario de référence change la mesure')
  invisible(r)
}

# APPLICATION 8 : coût financier d'un report pur d'une année
cout_report <- function(p=parametres(),afficher=TRUE) {
  maintenant <- van(modele(p)$FCF,p$taux)
  dans_un_an <- van(c(0,modele(p)$FCF),p$taux)
  r <- data.frame(decision=c('Démarrage immédiat','Projet identique décalé d’un an'),
    VAN=c(maintenant,dans_un_an))
  if(afficher) {
    print(transform(r,VAN=round(VAN,2)),row.names=FALSE)
    cat('Coût du report :',round(maintenant-dans_un_an,2),'kMAD\n')
    barplot(r$VAN,names.arg=c('Maintenant','Dans un an'),
      col=c('#1f4e79','#c55a11'),ylab='VAN aujourd’hui (kMAD)',
      main='Le temps consomme de la valeur')
  }
  invisible(r)
}

# APPLICATION 9 : le scénario sans projet peut contenir une dépense future
cas_remplacement <- function(taux=.10) {
  # Projet : 900 à t0, économie nette de 200/an pendant 6 ans,
  # réparation de 300 évitée à t2 et cession de 80 à t6. Cas avant impôt.
  flux <- c(-900,200,500,200,200,200,280)
  d <- data.frame(annee=0:6,flux_incremental=flux,
    valeur_actuelle=flux/(1+taux)^(0:6))
  print(round(d,2),row.names=FALSE)
  cat('VAN du remplacement :',round(van(flux,taux),2),'kMAD\n')
  barplot(flux,names.arg=0:6,col=ifelse(flux<0,'#c55a11','#1f4e79'),
    xlab='Année',ylab='Flux incrémental (kMAD)',
    main='Remplacer maintenant contre réparer plus tard')
  abline(h=0,col='gray50')
  invisible(d)
}

# APPLICATION 10 : revue ex post, avec données pédagogiques observées
revue_ex_post <- function() {
  prevu <- parametres()
  observe <- parametres(); observe$achat <- 1900; observe$gain_mwh <- 430
  observe$prix_kwh <- 1.10; observe$maintenance <- 75
  vp <- van(modele(prevu)$FCF,prevu$taux)
  vo <- van(modele(observe)$FCF,observe$taux)
  r <- data.frame(indicateur=c('CAPEX équipement','Énergie évitée','Prix évitable',
      'Maintenance','Flux exploitation','VAN'),
    unite=c('kMAD','MWh/an','MAD/kWh','kMAD/an','kMAD/an','kMAD'),
    dossier=c(prevu$achat,prevu$gain_mwh,prevu$prix_kwh,prevu$maintenance,
      modele(prevu)$flux_exploitation[2],vp),
    observation=c(observe$achat,observe$gain_mwh,observe$prix_kwh,
      observe$maintenance,modele(observe)$flux_exploitation[2],vo))
  r$ecart <- r$observation-r$dossier
  print(transform(r,dossier=round(dossier,2),observation=round(observation,2),
    ecart=round(ecart,2)),row.names=FALSE)
  barplot(c(vp,vo),names.arg=c('Dossier','Observation'),
    col=c('#1f4e79','#c55a11'),ylab='VAN reconstituée (kMAD)',
    main='Revue ex post de la création de valeur')
  abline(h=0,col='gray50')
  invisible(r)
}
# CONTROLE DES ACQUIS : cas indépendant à cinq ans
ticket_sortie <- function() {
  flux <- c(-1050,rep(245,4),295)
  resultat <- data.frame(annee=0:5,flux_kMAD=flux,
    flux_actualise=flux/(1.10)^(0:5))
  print(round(resultat,2),row.names=FALSE)
  cat('VAN =',round(van(flux,.10),2),'kMAD\n')
  invisible(resultat)
}
# Vérifications de référence : elles s'exécutent lors du lancement du script.
verifier <- function() {
  d <- modele(); p <- parametres()
  stopifnot(abs(d$FCF[1]+2120)<1e-8, abs(d$FCF[2]-427.8)<1e-8,
            abs(tail(d$FCF,1)-687.8)<1e-8,
            abs(sum(d$variation_BFR))<1e-8,
            abs(van(d$FCF,p$taux)-283.57334631729)<1e-6,
            abs(van(c(-1050,rep(245,4),295),.10)+90.21117534197)<1e-6,
            abs(seuil_gain_mwh(afficher=FALSE)-436.7212770109)<1e-6,
            abs(van(c(-900,200,500,200,200,200,280),.10)-264.1439385943)<1e-6,
            abs(van(c(-1075,260,260,260,455),.09)+94.5299158084)<1e-6)
  s <- seuils_decision(afficher=FALSE)
  stopifnot(abs(s$seuil[2]-1.0481310648)<1e-6,
            abs(s$seuil[3]-135.9344675869)<1e-6,
            abs(cout_report(afficher=FALSE)$VAN[2]-257.7939511975)<1e-6,
            abs((12000*200/1000-12000*160/1000)-480)<1e-8)
  p$gain_mwh <- 375
  stopifnot(abs(van(modele(p)$FCF,p$taux)+276.59390446249)<1e-6)
  message('Verifications de reference reussies.')
}
verifier()
# Décommenter ces lignes pour exécuter toutes les applications dans R :
# application1(); application2(); application3(); pont_valeur()
# cas_bfr_terminal(); matrice_sensibilite(); seuil_gain_mwh()
# seuils_decision(); cas_normalisation_activite(); cout_report()
# cas_remplacement(); revue_ex_post()

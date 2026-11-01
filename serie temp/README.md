# MCE : relation entre les prix de l'or et de l'argent

Modélisation de la relation d'équilibre de long terme entre l'or et l'argent (données mensuelles, nov. 1993 – janv. 2013, 231 observations) avec la procédure d'Engle-Granger, sous R.

## Méthode
1. Tests de stationnarité (ADF, PP, KPSS)
2. Régression de long terme et test de cointégration sur les résidus
3. Estimation du MCE (or et argent, 1 retard)
4. Validation : Breusch-Godfrey, Breusch-Pagan, Jarque-Bera

## Résultats
- Or et argent sont I(1) et cointégrés (résultat borderline, significatif à 10 %).
- Relation de long terme : `log(Or) = 4.41 + 0.859 · log(Argent)`.
- L'or est exogène. L'argent s'ajuste (α = −0.078, p = 0.067), en environ 13 mois.
- Pas d'autocorrélation ni d'hétéroscédasticité significative. La normalité est rejetée (crise de 2008).

## Outils
R (`urca`, `dynlm`, `lmtest`, `tseries`, `ggplot2`), LaTeX, Beamer.


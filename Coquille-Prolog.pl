% Coquille de SBC à base de règles

/* Création des opérateurs */

:- op( 800, fx, si ),
   op( 700, xfx, alors ),
   op( 300, xfy, ou ),
   op( 200, xfy, et ).

/* Chainage arriere */

ch_arriere(X):- est_vrai(X).

est_vrai(X):- fait(X).
est_vrai(X):- si COND alors X, est_vrai(COND).
est_vrai( C1 et C2 ):- est_vrai(C1), est_vrai(C2).
est_vrai( C1 ou C2 ):- est_vrai(C1) ; est_vrai(C2).

/* Chainage avant */

ch_avant:- si COND alors X,
           not(fait(X)),
           condition_vraie(COND),
           !,
           write('nouveau fait : '), write(X),nl,
           asserta(fait(X)),
           ch_avant.
ch_avant:- write(' La BC est saturée'), nl.

/* condition_vraie/1 : même chose que le prédicat est_vrai/1, mais sans remonter dans les règles à partir des buts */
condition_vraie(C):- fait(C).
condition_vraie(C1 et C2):- condition_vraie(C1), condition_vraie(C2).
condition_vraie(C1 ou C2):- condition_vraie(C1) ; condition_vraie(C2).

/* diagnostic automobile
assert(fait( essence(réservoir) )).
assert(fait( essence(carburateur) )).
assert(fait( tourne(moteur) )).
*/

si essence(moteur) et tourne(moteur) alors problème(bougies).
si not(tourne(moteur)) et not(éclaire(phares)) alors problème(batterie_ou_câbles).
si not(tourne(moteur)) et éclaire(phares) alors problème(démarreur).
si essence(réservoir) et essence(carburateur) alors essence(moteur).

/* exemple simple
assert(fait(p(a))).
assert(fait(r(a))).
*/
si p(X) et q(X) ou p(X) et r(X) alors s(X).

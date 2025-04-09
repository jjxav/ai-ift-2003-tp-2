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

/* exemple simple
assert(fait(p(a))).
assert(fait(r(a))).
*/
% si p(X) et q(X) ou p(X) et r(X) alors s(X).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Ici commence notre implemenation de notre coquille  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


si saison(hiver) alors neige().
si not(saison(hiver)) ou saison(printemps) ou saison(ete) ou saison(automne) alors not(neige()).

si neige() et type(sport) et prix(payant) alors activite(ski).
si neige() et prix(gratuit) et lieu(quebec) alors activite(carnaval).
si saison(ete) et prix(payant) alors activite(parc_aquatique).
si saison(automne) et public(enfant) alors activite(halloween).
si type(recreatif) et prix(payant) alors activite(musee).
si type(recreatif) et lieu(quebec) ou prix(gratuit) alors activite(marche_vieux_quebec).
si type(recreatif) et prix(payant) alors activite(aquarium).
si not(neige()) et lieu(hors_quebec) alors activite(camping).
si not(neige()) et type(sport) alors activite(velo).
si public(enfant) alors activite(recreofun).

/*
assert(fait(saison(ete))).

assert(fait(saison(hiver))).
assert(fait(type(sport))).
assert(fait(prix(payant))).
*/

def_activite(ski, hiver, "Mnt. Ste-Anne").
def_activite(carnaval, hiver, quebec).
def_activite(parc_aquatique, ete, quebec).
def_activite(halloween, automne, quebec).
def_activite(musee, hiver, quebec).
def_activite(musee, printemps, quebec).
def_activite(musee, ete, quebec).
def_activite(musee, automne, quebec).
def_activite(marche_vieux_quebec, hiver, quebec).
def_activite(marche_vieux_quebec, printemps, quebec).
def_activite(marche_vieux_quebec, ete, quebec).
def_activite(marche_vieux_quebec, automne, quebec).
def_activite(aquarium, hiver, quebec).
def_activite(aquarium, printemps, quebec).
def_activite(aquarium, ete, quebec).
def_activite(aquarium, automne, quebec).
def_activite(camping, printemps, hors_quebec).
def_activite(camping, ete, hors_quebec).
def_activite(camping, automne, hors_quebec).

plan() :-
	ch_avant,
	fait(activite(N)),
	def_activite(N, S, L),
	write("Activité : "),
	write(N), nl(),
	write("Saison : "),
	write(S), nl(),
	write("Lieu : "),
	write(L), nl()
. 

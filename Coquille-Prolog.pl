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
% si p(X) et q(X) ou p(X) et r(X) alors s(X).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Ici commence notre implemenation de notre coquille  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% si nbr(X) et (X > 1) alors type_group(GROUP).
% si nbr(1) alors type_group(seule).
% si not(type_group(seule)) alors type_group(group).
%

% si tomate() alors activiter(carnaval).
% si not(tomate()) alors activiter(bob).

%
%
%

si saison(hiver) alors neige().
si not(saison(hiver)) ou saison(printemps) ou saison(ete) ou saison(automne) alors not(neige()).

si neige() et type(sport) et prix(payant) alors activiter(ski).
si neige() et prix(gratuit) et lieu(quebec) alors activiter(carnaval).
si saison(ete) et prix(payant) alors activiter(parc_aquatique).
si saison(automne) et public(enfant) alors activiter(halloween).
si type(recreatif) et prix(payant) alors activiter(musee).
si type(recreatif) et lieu(quebec) ou prix(gratuit) alors activiter(marcher_vieux_quebec).
si type(recreatif) et prix(payant) alors activiter(aquarium).
si not(neige()) et lieu(hors_quebec) alors activiter(camping).
si not(neige()) et type(sport) alors activiter(velo).
si public(enfant) alors activiter(recreofun).







/*
assert(fait(saison(ete))).

assert(fait(saison(hiver))).
assert(fait(type(sport))).
assert(fait(prix(payant))).
*/

def_activiter(ski, hiver, "Mnt. Ste-Anne").
def_activiter(carnaval, hiver, quebec).
def_activiter(parc_aquatique, ete, quebec).
def_activiter(halloween, automne, quebec).
def_activiter(musee, hiver, quebec).
def_activiter(musee, printemps, quebec).
def_activiter(musee, ete, quebec).
def_activiter(musee, automne, quebec).
def_activiter(marcher_vieux_quebec, hiver, quebec).
def_activiter(marcher_vieux_quebec, printemps, quebec).
def_activiter(marcher_vieux_quebec, ete, quebec).
def_activiter(marcher_vieux_quebec, automne, quebec).
def_activiter(aquarium, hiver, quebec).
def_activiter(aquarium, printemps, quebec).
def_activiter(aquarium, ete, quebec).
def_activiter(aquarium, automne, quebec).
def_activiter(camping, printemps, hors_quebec).
def_activiter(camping, ete, hors_quebec).
def_activiter(camping, automne, hors_quebec).

plan() :-
	ch_avant,
	fait(activiter(N)),
	def_activiter(N, S, L),
	write("Nom : "),
	write(N), nl(),
	write("Saison : "),
	write(S), nl(),
	write("Lieu : "),
	write(L), nl()
.


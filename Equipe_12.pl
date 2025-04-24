


p(R) -->  groupe_verbe(), groupe_nominal(N), { R = [N] }.
p(R) -->  groupe_adjectif(A), groupe_nominal(N), { R = [A, N] }.

groupe_nominal(R) --> nom(R).
groupe_nominal(R) --> determinant(), adjectif(A), nom(N), { R = [A, N] }.
groupe_nominal(R) --> preposition(), determinant(), nom(R).
groupe_verbe() --> pronom(), verbe().
groupe_adjectif(R) --> adverbe(), adjectif(R).
groupe_adjectif(R) --> adjectif(R).
nom(sujet('carte graphique')) --> ['carte graphique'].
nom(sujet(achat)) --> [achat].
pronom() --> [ceci].
verbe() --> [est].
adjectif(niveau(superbe)) --> [superbe].
adjectif(niveau(satisfait)) --> [satisfait].
adjectif(niveau(bon)) --> [bon].
adverbe() --> [très].
determinant() --> [mon].
determinant() --> [un].
preposition() --> [de].


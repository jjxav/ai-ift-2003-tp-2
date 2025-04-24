


##################################################
#					Equipe 12					 #
##################################################






##################################################
# Predicat pour savoir le niveau de satisfaction #
# d'un sujet selon la phrase.                    #
##################################################
p(R) -->  groupe_verbe(), groupe_nominal(N), { R = [N] }.
p(R) -->  groupe_adjectif(A), groupe_nominal(N), { R = [A, N] }.

##################################################
# Groupe nomninale de la phrase                  #
##################################################
groupe_nominal(R) --> nom(R).
groupe_nominal(R) --> determinant(), adjectif(A), nom(N), { R = [A, N] }.
groupe_nominal(R) --> nom(R), adjectif(_).
groupe_nominal(R) --> preposition(), determinant(), nom(R).

##################################################
# Groupe vervable de la phrase                   #
##################################################
groupe_verbe() --> pronom(), verbe().

##################################################
# Groupe d'adjective de la phrase                #
##################################################
groupe_adjectif(R) --> adverbe(), adjectif(R).
groupe_adjectif(R) --> adjectif(R).

##################################################
# Base de connaissance grammaticale              #
##################################################
nom(sujet(carte)) --> [carte].
nom(sujet(achat)) --> [achat].

pronom() --> [ceci].

verbe() --> [est].

adjectif(niveau(superbe)) --> [superbe].
adjectif(niveau(satisfait)) --> [satisfait].
adjectif(niveau(bon)) --> [bon].
adjectif(niveau()) --> [graphique].

adverbe() --> [très].

determinant() --> [mon].
determinant() --> [un].
preposition() --> [de].


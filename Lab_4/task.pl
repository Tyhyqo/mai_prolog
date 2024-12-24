sentence(Result) --> noun_phrase(NP), verb_phrase(NP, Result).

noun_phrase(object(Noun, Attributes)) -->
    determiner,
    adjectives(Attributes),
    noun(Noun).

verb_phrase(NP, s(NP, location(NP, PrepPhrase))) -->
    verb,
    preposition_phrase(PrepPhrase).
verb_phrase(NP, s(NP, Attribute)) -->
    verb,
    adjective(Attribute).

preposition_phrase(PrepPhrase) -->
    preposition(Prep),
    noun_phrase_simple(Noun),
    { PrepPhrase =.. [Prep, Noun] }.

noun_phrase_simple(Noun) -->
    determiner,
    noun(Noun).

adjectives([Adj|Rest]) -->
    adjective(Adj),
    adjectives(Rest).
adjectives([]) --> [].

determiner --> ["The"]; ["the"].

verb --> ["is"]; ["Is"].

noun(book) --> ["book"].
noun(pen) --> ["pen"].
noun(table) --> ["table"].

adjective(size(big)) --> ["big"].
adjective(size(little)) --> ["little"].

adjective(color(red)) --> ["red"].
adjective(color(green)) --> ["green"].
adjective(color(blue)) --> ["blue"].

preposition(under) --> ["under"].
preposition(on) --> ["on"].
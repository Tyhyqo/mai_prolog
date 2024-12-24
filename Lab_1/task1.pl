%Реализация lenght
list_length([], 0).
list_length([_|Tail], N) :- 
    list_length(Tail, Result), 
    N is Result + 1.
 
%Реализация member
list_member(X, [X|_]).
list_member(E, [_|Tail]) :- list_member(E, Tail).

%Реализация append
list_append([], List, List).
list_append([Head|Tail], List, [Head|ResultTail]) :- 
    list_append(Tail, List, ResultTail).

%Реализация remove
list_remove(_, [], []).
list_remove(X, [X|Tail], Tail).
list_remove(X, [Head|Tail], [Head|ResultTail]) :-
     list_remove(X, Tail, ResultTail).

%Реализация permutes
list_permute([], []).
list_permute(List, [X|Perm]) :- 
    list_remove(X, List, Rest), 
    list_permute(Rest, Perm).

%Реализация sublist
list_sublist(SubList, List) :- 
    append(_, Rest, List), 
    append(SubList, _, Rest).

%Удаление всех элементов списка по значению без использования сторонних предикатов
remove_all(_, [], []).
remove_all(X, [X|Tail], Result) :- 
    remove_all(X, Tail, Result).
remove_all(X, [Head|Tail], [Head|ResultTail]) :- 
    remove_all(X, Tail, ResultTail).

%Удаление всех элементов списка по значению с использованием сторонних предикатов
delete_all(_, [], []).
delete_all(X, List, Result) :-
    list_member(X, List),
    list_remove(X, List, TempList),
    delete_all(X, TempList, Result).
delete_all(_, List, List).


%Слияние двух упорядоченных списков без использования сторонних предикатов
merge([], List, List).
merge(List, [], List).
merge([Head1|Tail1], [Head2|Tail2], [Head1|ResultTail]) :-
    Head1 =< Head2,
    merge(Tail1, [Head2|Tail2], ResultTail).
merge([Head1|Tail1], [Head2|Tail2], [Head2|ResultTail]) :-
    Head1 > Head2,
    merge([Head1|Tail1], Tail2, ResultTail).

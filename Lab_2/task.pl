solve :-
    % Цвета
    Colors = [white, green, blue],
    % Платья
    member(AnyaDress, Colors),
    member(ValyaDress, Colors),
    member(NatashaDress, Colors),
    all_different([AnyaDress, ValyaDress, NatashaDress]),
    % Туфли
    member(AnyaShoes, Colors),
    member(ValyaShoes, Colors),
    member(NatashaShoes, Colors),
    all_different([AnyaShoes, ValyaShoes, NatashaShoes]),
    % Условия
    % Только у Ани цвет платья и туфель мог совпадать
    AnyaDress = AnyaShoes,
    ValyaDress \= ValyaShoes,
    NatashaDress \= NatashaShoes,
    % Ни туфли, ни платье Вали не были белыми
    ValyaDress \= white,
    ValyaShoes \= white,
    % Наташа была в зеленых туфлях
    NatashaShoes = green,
    % Ни у одной девушки не было сочетания зеленого и белого
    \+ (AnyaDress = green, AnyaShoes = white),
    \+ (AnyaDress = white, AnyaShoes = green),
    \+ (ValyaDress = green, ValyaShoes = white),
    \+ (ValyaDress = white, ValyaShoes = green),
    \+ (NatashaDress = green, NatashaShoes = white),
    \+ (NatashaDress = white, NatashaShoes = green),
    % Вывод результата
    write('Anya: Dress - '), write(AnyaDress), write(', Shoes - '), write(AnyaShoes), nl,
    write('Valya: Dress - '), write(ValyaDress), write(', Shoes - '), write(ValyaShoes), nl,
    write('Natasha: Dress - '), write(NatashaDress), write(', Shoes - '), write(NatashaShoes), nl.

% Предикат для проверки, что все элементы списка различны
all_different([]).
all_different([H|T]) :-
    \+ member(H, T),
    all_different(T).
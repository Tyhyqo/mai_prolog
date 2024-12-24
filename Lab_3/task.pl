start_state([w, w, w, e, b, b, b]).
end_state([b, b, b, e, w, w, w]).

move([e, X | Rest], [X, e | Rest]).
move([X, e | Rest], [e, X | Rest]).
move([X, Y, e | Rest], [e, Y, X | Rest]).
move([e, Y, X | Rest], [X, Y, e | Rest]).
move([H | T], [H | T1]) :- move(T, T1).


dfs(State, Path, Path) :- 
    start_state(State), !.

dfs(State, Path, Solution) :-
    move(State, NextState),
    \+ member(NextState, Path),
    dfs(NextState, [NextState | Path], Solution).


bfs([[State | Path] | _], [State | Path]) :- 
    start_state(State), !.

bfs([Path | Paths], Solution) :-
    extend(Path, NewPaths),
    append(Paths, NewPaths, Paths1),
    bfs(Paths1, Solution).

extend([State | Path], NewPaths) :-
    findall([NewState, State | Path],
            (move(State, NewState), \+ member(NewState, [State | Path])),
            NewPaths).

iddfs(State, Solution) :- 
    between(1, inf, Depth),
    iddfs(State, [State], Solution, Depth).

iddfs(State, Path, Path, _) :- 
    start_state(State).

iddfs(State, Path, Solution, Depth) :-
    Depth > 0,
    move(State, NextState),
    \+ member(NextState, Path),
    Depth1 is Depth - 1,
    iddfs(NextState, [NextState | Path], Solution, Depth1).


print_solution([]).
print_solution([State | Rest]) :-
    write(State), nl,
    print_solution(Rest).


measure_time(Goal) :-
    statistics(runtime, [Start|_]),
    call(Goal),
    statistics(runtime, [End|_]),
    Time is End - Start,
    format('Time: ~d ms~n', [Time]).

solve_dfs :-
    end_state(State),
    measure_time(dfs(State, [State], Solution)),
    print_solution(Solution).

solve_bfs :-
    end_state(State),
    measure_time(bfs([[State]], Solution)),
    print_solution(Solution).

solve_iddfs :-
    end_state(State),
    measure_time(iddfs(State, Solution)),
    print_solution(Solution).

solve_all :-
    solve_dfs,
    solve_bfs,
    solve_iddfs.
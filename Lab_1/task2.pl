:- encoding(utf8).
:- consult('four.pl').

% Задача 1: Для каждого студента найти средний балл и сдал ли он экзамены

% Список всех студентов
all_students(Students) :-
    findall(Student, (subject(_, Grades), member(grade(Student, _), Grades)), List),
    sort(List, Students).

% Оценки студента
student_grades(Student, Grades) :-
    findall(Grade, (subject(_, SubGrades), member(grade(Student, Grade), SubGrades)), Grades).

% Средний балл студента
student_average(Student, Average) :-
    student_grades(Student, Grades),
    sum_list(Grades, Sum),
    length(Grades, Count),
    Count > 0,
    Average is Sum / Count.

% Проверка, сдал ли студент все экзамены
student_passed(Student) :-
    student_grades(Student, Grades),
    \+ (member(Grade, Grades), Grade < 3).

% Предикат для вывода среднего балла и информации о сдаче экзаменов для каждого студента
print_student_averages :-
    all_students(Students),
    forall(member(Student, Students),
           (
               student_average(Student, Average),
               (student_passed(Student) -> Status = 'Сдал'; Status = 'Не сдал'),
               format('Студент: ~w, Средний балл: ~2f, ~w~n', [Student, Average, Status])
           )).

% Задача 2: Для каждого предмета найти количество не сдавших студентов

% Список не сдавших студентов по предмету
subject_failed_students(Subject, FailedStudents) :-
    subject(Subject, Grades),
    findall(Student, (member(grade(Student, Grade), Grades), Grade < 3), FailedStudents).

% Количество не сдавших студентов по предмету
subject_failed_count(Subject, Count) :-
    subject_failed_students(Subject, FailedStudents),
    length(FailedStudents, Count).

% Предикат, который выводит количество несдавших студентов по каждому предмету
print_subject_failed_counts :-
    findall(Subject, subject(Subject, _), Subjects),
    forall(member(Subject, Subjects),
           (
               subject(Subject, Grades),
               findall(Student, (member(grade(Student, Grade), Grades), Grade < 3), FailedStudents),
               length(FailedStudents, Count),
               format('Предмет: ~w, Количество несдавших студентов: ~d~n', [Subject, Count])
           )).

% Задача 3: Для каждой группы найти студентов с максимальным средним баллом

% Студенты группы
group_students(Group, Students) :-
    group(Group, Students).

% Средний балл студентов группы
group_student_averages(Group, Averages) :-
    group_students(Group, Students),
    findall((Student, Average), (member(Student, Students), student_average(Student, Average)), Averages).

% Максимальный средний балл в группе
group_max_average(Group, MaxAverage) :-
    group_student_averages(Group, Averages),
    findall(Avg, member((_, Avg), Averages), AvgList),
    max_list(AvgList, MaxAverage).

% Студенты с максимальным средним баллом в группе
group_top_students(Group, TopStudents) :-
    group_max_average(Group, MaxAverage),
    group_student_averages(Group, Averages),
    findall(Student, member((Student, MaxAverage), Averages), TopStudents).

% Предикат, который для каждой группы находит студентов с максимальным средним баллом
print_group_top_students :-
    findall(Group, group(Group, _), Groups),
    forall(member(Group, Groups),
           (
               group_top_students(Group, TopStudents),
               format('Группа: ~w, Студенты с максимальным средним баллом: ~w~n', [Group, TopStudents])
           )).
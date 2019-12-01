CREATE
OR REPLACE
VIEW average_evaluation AS select
    CONCAT(CONCAT(students.First_Name, ' '), students.Last_Name )   AS `Студент`,
    students.idstudents AS `№ на студент`,
    avg(`courses`.`evaluation`) AS `Среден успех`
from
    scores
join `students` on
    (students.idstudents = sco. .`idstudents`)
group by
    `students`.`First_Name`;

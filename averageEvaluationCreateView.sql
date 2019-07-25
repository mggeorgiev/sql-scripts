CREATE
OR REPLACE
VIEW `average_evaluation` AS select
    concat(concat(`students`.`First_Name`, ' '), `students`.`Last_Name`) AS `Студент`,
    `students`.`idstudents` AS `№ на студент`,
    round(avg(`scores`.`evaluation`), 2) AS `Среден успех`,
    ROUND(STDDEV_POP(`scores`.`evaluation`),2) AS `Стандартно отклонение`
from
    (`scores`
join `students` on
    ((`students`.`idstudents` = `scores`.`idstudents`)))
group by
    `scores`.`idstudents`;

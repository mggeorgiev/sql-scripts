update scores
set temp = (select course_name from university.courses where idcourse = scores.idcourse)
WHERE temp is NULL
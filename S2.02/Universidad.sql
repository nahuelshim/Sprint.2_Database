#1. Retorna un llistat amb el primer cognom, segon cognom i el nom de tots els/les alumnes. El llistat haurà d'estar ordenat alfabèticament de menor a major pel primer cognom, segon cognom i nom.
select apellido1, apellido2, nombre from persona order by apellido1;
#2. Esbrina el nom i els dos cognoms dels alumnes que no han donat d'alta el seu número de telèfon en la base de dades.
select nombre, apellido1, apellido2 from persona where persona.tipo like "alumno" and telefono is null;
#3. Retorna el llistat dels alumnes que van néixer en 1999.
select* from persona where persona.tipo like "alumno" and year (fecha_nacimiento) = 1999; 
#4. Retorna el llistat de professors/es que no han donat d'alta el seu número de telèfon en la base de dades i a més el seu NIF acaba en K.
select* from persona where persona.tipo like "profesor" and telefono is null and nif like "%k";
#5. Retorna el llistat de les assignatures que s'imparteixen en el primer quadrimestre, en el tercer curs del grau que té l'identificador 7.
select* from asignatura where cuatrimestre = 1 and curso = 3 and id_grado = 7;
#6. Retorna un llistat dels professors/es juntament amb el nom del departament al qual estan vinculats. El llistat ha de retornar quatre columnes, primer cognom, segon cognom, nom i nom del departament. El resultat estarà ordenat alfabèticament de menor a major pels cognoms i el nom.
select persona.apellido1, persona.apellido2, persona.nombre, departamento.nombre as 'departamento' from persona inner join profesor on persona.id = profesor.id_profesor inner join departamento on profesor.id_departamento = departamento.id order by apellido1;
#7. Retorna un llistat amb el nom de les assignatures, any d'inici i any de fi del curs escolar de l'alumne/a amb NIF 26902806M.
select per.apellido1, per.apellido2, per.nombre, asignatura.nombre, anyo_inicio, anyo_fin from persona per 
inner join alumno_se_matricula_asignatura on alumno_se_matricula_asignatura.id_alumno = per.id
inner join asignatura on asignatura.id = alumno_se_matricula_asignatura.id_asignatura
inner join curso_escolar on curso_escolar.id = alumno_se_matricula_asignatura.id_curso_escolar
where NIF = "26902806M" and per.tipo = "alumno";
#8. Retorna un llistat amb el nom de tots els departaments que tenen professors/es que imparteixen alguna assignatura en el Grau en Enginyeria Informàtica (Pla 2015).
select departamento.nombre as departamento, asignatura.nombre as asignatura, grado.nombre as grado from departamento 
inner join profesor on profesor.id_departamento = departamento.id
inner join asignatura on asignatura.id_profesor = profesor.id_profesor 
inner join grado on asignatura.id_grado = grado.id
where grado.nombre = 'Grado en Ingeniería Informática (Plan 2015)' ;
#9. Retorna un llistat amb tots els alumnes que s'han matriculat en alguna assignatura durant el curs escolar 2018/2019.
select distinct per.apellido1, per.apellido2, per.nombre, per.nif from persona per 
inner join alumno_se_matricula_asignatura on alumno_se_matricula_asignatura.id_alumno = per.id
inner join curso_escolar on alumno_se_matricula_asignatura.id_curso_escolar = curso_escolar.id
where curso_escolar.anyo_inicio = 2018 order by per.apellido1;

#1. Retorna un llistat amb els noms de tots els professors/es i els departaments que tenen vinculats. El llistat també ha de mostrar aquells professors/es que no tenen cap departament associat. El llistat ha de retornar quatre columnes, nom del departament, primer cognom, segon cognom i nom del professor/a. El resultat estarà ordenat alfabèticament de menor a major pel nom del departament, cognoms i el nom.
select departamento.nombre, per.apellido1, per.apellido2, per.nombre from persona per
left join profesor on profesor.id_profesor = per.id
left join departamento on profesor.id_departamento = departamento.id
where per.tipo = "profesor" order by departamento.nombre, per.apellido1, per.apellido2, per.nombre;
#2. Retorna un llistat amb els professors/es que no estan associats a un departament.
select  persona.nombre, persona.apellido1, persona.apellido2 from persona
left join profesor on profesor.id_profesor = persona.id
left join departamento on departamento.id = profesor.id_departamento
where persona.tipo = "profesor" and departamento.nombre is null;
#3. Retorna un llistat amb els departaments que no tenen professors/es associats.
select departamento.nombre from departamento 
left join profesor on profesor.id_departamento = departamento.id
where profesor.id_departamento is null;
#4. Retorna un llistat amb els professors/es que no imparteixen cap assignatura.
select per.apellido1 as "Primer apellido", per.apellido2 as "Segundo apellido", per.nombre as Nombre, asignatura.nombre as Asignatura from profesor
left join persona per on profesor.id_profesor = per.id
left join asignatura on asignatura.id_profesor = profesor.id_profesor
where asignatura.id_profesor is null order by per.apellido1 ;
#5. Retorna un llistat amb les assignatures que no tenen un professor/a assignat.
select nombre as asignatura from asignatura where id_profesor is null order by nombre;
#6. Retorna un llistat amb tots els departaments que no han impartit assignatures en cap curs escolar.
select distinct d.id, d.nombre from departamento d 
left join profesor pr on d.id = pr.id_departamento
left join asignatura a on pr.id_profesor = a.id_profesor
left join curso_escolar ce on a.curso = ce.id where ce.id is null order by d.nombre;

#1.Retorna el nombre total d'alumnes que hi ha.
select count(persona.tipo) from persona where persona.tipo = "alumno";
#2. Calcula quants alumnes van néixer en 1999.
select count(fecha_nacimiento) FROM persona where year (fecha_nacimiento) = 1999;
#3. Calcula quants professors/es hi ha en cada departament. El resultat només ha de mostrar dues columnes, una amb el nom del departament i una altra amb el nombre de professors/es que hi ha en aquest departament. El resultat només ha d'incloure els departaments que tenen professors/es associats i haurà d'estar ordenat de major a menor pel nombre de professors/es.
select d.nombre as Dpartamento, p.nombre as Profesor from profesor pr 
join departamento d on (pr.id_departamento = d.id) 
join persona p on (pr.id_profesor = p.id) order by p.nombre;
#4. Retorna un llistat amb tots els departaments i el nombre de professors/es que hi ha en cadascun d'ells. Tingui en compte que poden existir departaments que no tenen professors/es associats. Aquests departaments també han d'aparèixer en el llistat.
select d.nombre as Departamento, d.id as ID, p.nombre as Profesor from departamento d 
left join profesor pr on (d.id = pr.id_departamento) 
left join persona p on (pr.id_profesor = p.id);
#5. Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun. Tingues en compte que poden existir graus que no tenen assignatures associades. Aquests graus també han d'aparèixer en el llistat. El resultat haurà d'estar ordenat de major a menor pel nombre d'assignatures.
select g.nombre as Grado, COUNT(a.id) as Asignaturas from grado g 
left join asignatura a on (g.id = a.id_grado) group by g.id order by Asignaturas DESC;
#6. Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun, dels graus que tinguin més de 40 assignatures associades.
select g.nombre, COUNT(a.id) as cantidad from grado g join asignatura a on (g.id = a.id_grado) group by g.id having cantidad > 40 ;








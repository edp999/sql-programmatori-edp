/* 1. Calcolare il codice dei programmatori che sono stati autori di almeno
 un programma scritto in Java dopo il 2000. */
select a.codice
from autore a ,programma pa
where a.id=pa.id and pa.linguaggio='Java' and pa.anno>2000
/* 2. Calcolare il nome e la categoria dei programmatori che 
sono stati autori di almeno un programma scritto in un linguaggio diverso
 da Python, ordinando il risultato rispetto al nome dei programmatori. */
select pe.nome, pe.categoria
from autore a ,programma pa, programmatore pe
where a.id=pa.id and pe.codice = a.codice and pa.linguaggio<>'Python'
order by pe.nome
/* 3. Per ogni programmatore di categoria 10, calcolare il suo codice e
l'anno in cui ha scritto il primo programma in un linguaggio diverso da Java. */
select pe.codice, min(pa.anno)
from programmatore pe, programma pa, autore a
where a.id=pa.id and pe.codice = a.codice 
    and pe.categoria=10 and pa.linguaggio<>'java'
group by pe.codice

/* 4. Calcolare le coppie dei codici di programmatori che sono stati
 coautori di almeno un programma scritto in Python. */
select distinct a1.codice, a2.codice
from autore a1, autore a2, programma pa
where a1.id = a2.id and a1.codice<a2.codice and pa.id = a1.id and pa.linguaggio='Python'
/* 5. Calcolare il codice ed il nome dei programmatori 
che hanno scritto solo programmi Java. */
select pe.nome, pe.codice
from programmatore pe
where pe.codice not in (select a.codice from autore a join programma pa on a.id=pa.id where pa.linguaggio<>'Java')
/* 6. Per ogni programmatore e per ogni anno calcolare il 
numero di programmi scritti da quel programmatore in quell’anno, 
mostrando codice del programmatore, anno e numero di programmi scritti. */
select codice, anno, count(*) as numeroprogrammi

/* 7. Per ogni linguaggio calcolare quanti sono in media gli autori
 dei programmi scritti in quel linguaggio.

*/
select pa.linguaggio, round(avg(n.conto),2)
from programma pa left join (select a.id, count(a.codice) as conto from autore a group by a.id) as n on n.id = pa.id
group by pa.linguaggio
/* se non consideriamo i programmi senza autore*/

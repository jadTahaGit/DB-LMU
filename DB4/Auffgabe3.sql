-- a)
-- T1 x T2
SELECT * 
FROM T1 CROSS JOIN T2;


-- b)
-- T1 ⨝ T2
SELECT *
FROM T1 NATURAL JOIN T2;

-- c)
--  T1        ⋉        T2
--     "T1.id= T2.id"

SELECT *
FROM T1 RIGHT JOIN  T2 ON T1.id = T2.id;


-- d) 
-- T1 ⋊ T2
--     "T1.id= T2.id"
SELECT * 
FROM T1 LEFT JOIN T2 ON T1.id = T2.id;

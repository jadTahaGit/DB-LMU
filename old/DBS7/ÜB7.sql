7)1)
a) 
SELECT pnr, pname, COUNT(DISTINCT lnr)
FROM P NATURAL JOIN LTP
GROUP BY pnr, pname

b)

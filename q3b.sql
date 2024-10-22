WITH FINAL_RANK_OUTPUT (zip_code, normalized_mme, rank, population, mme) AS (
SELECT dn.BUYER_ZIP,
       SUM(dn.MME) / CAST(vz.ZPOP AS DOUBLE),
       RANK() OVER ( ORDER BY SUM(dn.MME) / CAST(vz.ZPOP AS DOUBLE) DESC ),
       vz.ZPOP,
       SUM(dn.MME)
FROM CSE532.DEA_NY dn INNER JOIN CSE532.ZIPPOP vz
ON dn.BUYER_ZIP = vz.ZIP
GROUP BY dn.BUYER_ZIP, vz.ZPOP
HAVING vz.ZPOP > 0
)
SELECT * FROM FINAL_RANK_OUTPUT f
WHERE f.rank <= 5;
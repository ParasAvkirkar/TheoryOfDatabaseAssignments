WITH VALID_ZIP_POP (zip_code, population) AS (
    SELECT z.ZIP, MAX(z.ZPOP)
    FROM CSE532.ZIPPOP z
    GROUP BY z.ZIP
)
SELECT dn.BUYER_ZIP, RANK() OVER (ORDER BY CAST(dn.MME AS double) / CAST(v.population AS double))
FROM CSE532.DEA_NY dn INNER JOIN VALID_ZIP_POP v
ON dn.BUYER_ZIP = v.zip_code AND v.population > 0;
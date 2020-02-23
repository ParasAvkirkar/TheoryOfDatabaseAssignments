WITH MONTHLY_COUNT (month_time, count, year, month) AS (
    SELECT YEAR (dn.TRANSACTION_DATE) ||
           CASE
               WHEN ( CAST(MONTH(dn.TRANSACTION_DATE) AS INT) < 10) THEN '0' || MONTH (dn.TRANSACTION_DATE)
                ELSE CAST(MONTH(dn.TRANSACTION_DATE) AS CHAR(2))
            END,
        SUM(dn.DOSAGE_UNIT),
        YEAR (dn.TRANSACTION_DATE),
        MONTH (dn.TRANSACTION_DATE)
FROM CSE532.DEA_NY dn
GROUP BY YEAR (dn.TRANSACTION_DATE), MONTH (dn.TRANSACTION_DATE)
)
SELECT m.month_time, m.count AS normal_count, AVG(CAST(m.count AS DOUBLE)) OVER ( ORDER BY m.year, m.month ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING ) AS smooth_count
    FROM MONTHLY_COUNT m;

    
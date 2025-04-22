-- Query: Clusterização Salarial Automática
SELECT 
    Level,
    Salary,
    NTILE(3) OVER (ORDER BY Salary) AS salary_cluster,
    CASE 
        WHEN Salary < PERCENTILE_CONT(0.33) WITHIN GROUP (ORDER BY Salary) OVER () THEN 'Baixo'
        WHEN Salary < PERCENTILE_CONT(0.66) WITHIN GROUP (ORDER BY Salary) OVER () THEN 'Médio'
        ELSE 'Alto' 
    END AS salary_category
FROM main_table;
-- Classificação dinâmica em tercis para análise comparativa
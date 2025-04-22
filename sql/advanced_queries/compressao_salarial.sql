-- Query: Análise de Compressão Salarial
SELECT 
    Level,
    Salary,
    Salary - LAG(Salary, 1) OVER (ORDER BY Level) AS absolute_growth,
    (Salary - LAG(Salary, 1) OVER (ORDER BY Level)) * 100.0 / 
    LAG(Salary, 1) OVER (ORDER BY Level) AS percentage_growth,
    CASE 
        WHEN (Salary - LAG(Salary, 1) OVER (ORDER BY Level)) < 
             (LAG(Salary, 1) OVER (ORDER BY Level) - LAG(Salary, 2) OVER (ORDER BY Level)) 
        THEN 'Decrescente' ELSE 'Estável/Crescente' 
    END AS growth_trend
FROM main_table;
-- Identifica padrões não-lineares na progressão salarial entre níveis

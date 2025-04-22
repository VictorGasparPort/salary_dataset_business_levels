-- Query: Distribuição Salarial por Nível
/* Propósito: Análise inicial de equidade interna */
SELECT 
    Level,
    COUNT(*) AS employees,
    ROUND(AVG(Salary), 2) AS average_salary,
    ROUND(STDDEV(Salary), 2) AS salary_deviation
FROM main_table
GROUP BY Level
ORDER BY Level;
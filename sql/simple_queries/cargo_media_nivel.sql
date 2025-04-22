
-- Query 2: Comparação Cargo vs Média de Nível
/* Propósito: Identificar cargos desalinhados com a faixa salarial */
SELECT 
    Position,
    Level,
    Salary,
    (SELECT ROUND(AVG(Salary), 2) FROM main_table m2 WHERE m2.Level = m1.Level) AS level_avg,
    Salary - (SELECT AVG(Salary) FROM main_table m2 WHERE m2.Level = m1.Level) AS diff_from_avg
FROM main_table m1
ORDER BY ABS(diff_from_avg) DESC;
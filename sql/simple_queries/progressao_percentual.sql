-- Query: Progressão Percentual entre Níveis
/* Propósito: Calcular taxa de crescimento salarial por promoção */
SELECT 
    current.Level,
    current.Salary AS current_salary,
    next.Salary AS next_level_salary,
    ROUND((next.Salary - current.Salary) * 100.0 / current.Salary, 2) AS increase_percent
FROM main_table current
JOIN main_table next ON current.Level = next.Level - 1;
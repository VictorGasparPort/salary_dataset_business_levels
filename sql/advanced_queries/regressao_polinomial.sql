-- Query: Análise de Regressão Polinomial (Cálculo In-Database)
WITH Aggregates AS (
    SELECT 
        Level,
        Salary,
        COUNT(*) OVER () AS n,
        SUM(Level) OVER () AS sum_x,
        SUM(Level*Level) OVER () AS sum_x2,
        SUM(Level*Level*Level) OVER () AS sum_x3,
        SUM(Salary) OVER () AS sum_y,
        SUM(Level*Salary) OVER () AS sum_xy,
        SUM(Level*Level*Salary) OVER () AS sum_x2y
    FROM main_table
)
SELECT 
    ((sum_y * sum_x2 * sum_x3) - (sum_xy * sum_x * sum_x3) + (sum_x2y * sum_x * sum_x)) /
    ((n * sum_x2 * sum_x3) - (sum_x * sum_x * sum_x3) + (sum_x2 * sum_x * sum_x)) AS a,
    ((n * sum_xy * sum_x3) - (sum_y * sum_x * sum_x3) + (sum_x2y * sum_x2 * sum_x)) /
    ((n * sum_x2 * sum_x3) - (sum_x * sum_x * sum_x3) + (sum_x2 * sum_x * sum_x)) AS b,
    ((n * sum_x2 * sum_x2y) - (sum_x * sum_x * sum_x2y) + (sum_y * sum_x2 * sum_x)) /
    ((n * sum_x2 * sum_x3) - (sum_x * sum_x * sum_x3) + (sum_x2 * sum_x * sum_x)) AS c
FROM Aggregates
LIMIT 1;
-- Calcula coeficientes (a, b, c) para modelo quadrático Salary = a + b*x + c*x²

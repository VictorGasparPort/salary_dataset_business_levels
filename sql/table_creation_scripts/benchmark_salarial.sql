-- Tabela: Benchmark Salarial por Nível (Suporte à Análise de Equidade)
CREATE TABLE salary_benchmarks AS
/* Propósito: Armazenar estatísticas salariais de referência para cada nível hierárquico */
SELECT 
    Level,
    MIN(Salary) AS min_salary,
    ROUND(AVG(Salary), 2) AS avg_salary,
    MAX(Salary) AS max_salary,
    MAX(Salary) - MIN(Salary) AS salary_range
FROM main_table
GROUP BY Level;
-- Explicação: Permite comparações internas e identificação de outliers salariais

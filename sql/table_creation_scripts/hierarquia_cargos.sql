-- Tabela: Hierarquia de Cargos (Mapeamento Estrutural)
CREATE TABLE position_hierarchy (
    position VARCHAR(50) PRIMARY KEY,
    level INT,
    expected_salary_min NUMERIC,
    expected_salary_max NUMERIC
);
/* Propósito: Definir faixas salariais referenciais para cada cargo */
INSERT INTO position_hierarchy
SELECT 
    Position,
    Level,
    ROUND(AVG(Salary) * 0.8, 2) AS expected_min,  -- 80% da média como piso
    ROUND(AVG(Salary) * 1.2, 2) AS expected_max   -- 120% da média como teto
FROM main_table
GROUP BY Position, Level;
-- Essas faixas servem como base para políticas de promoção e contratação

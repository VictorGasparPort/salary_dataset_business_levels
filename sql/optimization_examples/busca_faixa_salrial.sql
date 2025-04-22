-- Índice: Busca Rápida por Faixa Salarial
CREATE INDEX idx_salary_range ON main_table (Level, Salary)
WHERE Salary BETWEEN 5000 AND 20000;
/* Motivo: Acelera consultas de auditoria salarial em faixas críticas */

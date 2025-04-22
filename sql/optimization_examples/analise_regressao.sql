-- Índice: Otimização para Análise de Regressão
CREATE INDEX idx_regression_analysis ON main_table 
    (Level, Position)
INCLUDE (Salary);
/* Motivo: Agiliza acesso aos dados para modelos preditivos que usam Level como variável independente */
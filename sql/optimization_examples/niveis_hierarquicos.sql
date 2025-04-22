-- Particionamento: Segmentação por Níveis Hierárquicos
CREATE TABLE main_table_partitioned PARTITION BY RANGE (Level) (
    PARTITION entry_level VALUES LESS THAN (3),
    PARTITION mid_level VALUES LESS THAN (6),
    PARTITION senior_level VALUES LESS THAN (MAXVALUE)
);
/* Motivo: Isola dados de diferentes níveis para análise departamental e estratégias de retenção diferenciadas */

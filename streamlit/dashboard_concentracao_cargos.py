import streamlit as st
import pandas as pd
import plotly.express as px

# Configuração da página
st.set_page_config(
    page_title="Relatório de Distribuição de Cargos por Nível",
    layout="wide",
    page_icon="📊"
)

# Cabeçalho estilizado
st.markdown("""
<div style="background-color: #2c2c2c; padding: 2rem; border-radius: 8px; text-align: center; margin-bottom: 2rem;">
    <h1 style="color: #ffffff; font-size: 3rem;">📊 Relatório: Distribuição de Cargos por Nível</h1>
    <p style="color: #a9a9a9; font-size: 1.5rem;">Análise detalhada da distribuição de cargos organizacionais</p>
</div>
""", unsafe_allow_html=True)

# Função de análise
def analisar_distribuicao_cargos_por_nivel(dados):
    if 'Position' not in dados.columns or 'Level' not in dados.columns:
        raise ValueError("Erro: O DataFrame deve conter as colunas 'Position' e 'Level'.")
    
    # Contar a quantidade de cargos por nível
    distribuicao_cargos = dados.groupby('Level')['Position'].count().reset_index()
    distribuicao_cargos.columns = ['Level', 'Quantidade de Cargos']
    
    # Identificar os níveis com maior e menor concentração de cargos
    nivel_mais_cargos = distribuicao_cargos.loc[distribuicao_cargos['Quantidade de Cargos'].idxmax()]
    nivel_menos_cargos = distribuicao_cargos.loc[distribuicao_cargos['Quantidade de Cargos'].idxmin()]
    
    # Gráfico de barras horizontal com tons escuros
    bar_chart = px.bar(
        distribuicao_cargos, x='Quantidade de Cargos', y='Level',
        title="Distribuição de Cargos por Nível",
        text='Quantidade de Cargos', orientation='h', color='Level',
        color_discrete_sequence=px.colors.sequential.Darkmint  # Paleta escura
    )
    bar_chart.update_traces(texttemplate='%{text:.2f}', textposition='outside')
    bar_chart.update_layout(
        xaxis_title="Quantidade de Cargos", 
        yaxis_title="Nível", 
        plot_bgcolor="#1c1c1c",
        paper_bgcolor="#1c1c1c",
        font=dict(color="#ffffff"),
        title_font=dict(color="#ffffff")
    )
    
    # Construção de insights
    insights = {
        "Resumo": "A análise destaca os níveis organizacionais com maior e menor concentração de cargos.",
        "Observações": [
            f"O nível com maior concentração de cargos é '{nivel_mais_cargos['Level']}' com {nivel_mais_cargos['Quantidade de Cargos']} cargos.",
            f"O nível com menor concentração de cargos é '{nivel_menos_cargos['Level']}' com {nivel_menos_cargos['Quantidade de Cargos']} cargos."
        ],
        "Recomendações": [
            "Avalie se os níveis com maior concentração de cargos estão sobrecarregados e redistribua recursos se necessário.",
            "Considere reforçar os níveis com menor concentração de cargos por meio de novas contratações ou reestruturação.",
            "Implemente estratégias de treinamento para preparar funcionários para transições entre níveis."
        ]
    }
    
    return bar_chart, insights

# Entrada de dados
CAMINHO_DADOS = '../data/processed/salary_atualizado.csv'

try:
    dados = pd.read_csv(CAMINHO_DADOS)
    
    with st.spinner("Carregando os dados e gerando análise..."):
        bar_chart, insights = analisar_distribuicao_cargos_por_nivel(dados)
    
    # Exibição do gráfico
    st.plotly_chart(bar_chart, use_container_width=True)
    
    # Layout inovador e clean para exibição dos blocos de informações
    st.markdown(f"""
    <div style="background-color: #3a3a3a; padding: 2rem; border-radius: 8px; margin-bottom: 2rem;">
        <h2 style="color: #ffffff; font-size: 2rem;">Resumo</h2>
        <p style="color: #d3d3d3; font-size: 1.3rem; line-height: 1.8;">
            {insights["Resumo"]}
        </p>
    </div>

    <div style="background-color: #3a3a3a; padding: 2rem; border-radius: 8px; margin-bottom: 2rem;">
        <h2 style="color: #ffffff; font-size: 2rem;">Observações</h2>
        <p style="color: #d3d3d3; font-size: 1.3rem; line-height: 1.8;">
            - {insights["Observações"][0]}<br>
            - {insights["Observações"][1]}
        </p>
    </div>

    <div style="background-color: #3a3a3a; padding: 2rem; border-radius: 8px; margin-bottom: 2rem;">
        <h2 style="color: #ffffff; font-size: 2rem;">Recomendações</h2>
        <p style="color: #d3d3d3; font-size: 1.3rem; line-height: 1.8;">
            - {insights["Recomendações"][0]}<br>
            - {insights["Recomendações"][1]}<br>
            - {insights["Recomendações"][2]}
        </p>
    </div>
    """, unsafe_allow_html=True)

except FileNotFoundError:
    st.error("Erro: Arquivo de dados não encontrado!")
except Exception as e:
    st.error(f"Erro ao realizar a análise: {e}")
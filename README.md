# IRS Toolkit
Ferramentas úteis para facilitar a entrega do IRS, nomeadamente o grupo J e G.

## 9.2 Incrementos Patrimoniais de Opção de Englobamento
- **irs_j_9_2.sh** - Script para gerar em XML a tabela de incrementos patrimoniais de Opção de Englobamento a partir de um ficheiro de input com a declaração de investimentos.
    - `Usage: irs_j_9_2.sh <input_file> [output_file:-./output.xml] [field_separator:-' '] [start_line:-951]`
    - Estrutura de cada linha:
        - País Fonte (620 equivale a Portugal, mais info: https://en.wikipedia.org/wiki/ISO_3166-1_numeric)
        - Código (G01, G02, G03, G04, G05, G06, G10, G20, G34, G90)
        - Ano Realização
        - Mês Realização
        - Dia Realização
        - Valor Realização
        - Ano Aquisição
        - Mês Aquisição
        - Dia Aquisição
        - Valor Aquisição
        - Despesas e Encargos
        - Imposto pago no Estrangeiro 
        - País da Contraporte (620 equivale a Portugal, mais info: https://en.wikipedia.org/wiki/ISO_3166-1_numeric)

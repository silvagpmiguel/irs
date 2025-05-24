#/bin/bash

INPUT="$1"
OUTPUT=${2:-"./output.xml"}
FIELD_SEPARATOR="${3:- }"
START_LINE="${4:-951}"
REALIZATION=0
ACQUISITION=0
EXPENSES=0
TAX=0
append_irs_j_9_2_row() {
    local IFS="$FIELD_SEPARATOR"
    local arr=($@)
    local realization="${arr[7]}"
    local acquisition="${arr[11]}"
    local expenses="${arr[12]}"
    local tax="${arr[13]}"
    REALIZATION=`bc -l <<< "$REALIZATION + $realization"`
    ACQUISITION=`bc -l <<< "$ACQUISITION + $acquisition"`
    EXPENSES=`bc -l <<< "$EXPENSES + $expenses"`
    TAX=`bc -l <<< "$TAX + $tax"`
    printf """  <AnexoJq092AT01-Linha numero=\"${arr[0]}\">
        <NLinha>${arr[1]}</NLinha>
        <CodPais>${arr[2]}</CodPais>
        <Codigo>${arr[3]}</Codigo>
        <AnoRealizacao>${arr[4]}</AnoRealizacao>
        <MesRealizacao>${arr[5]}</MesRealizacao>
        <DiaRealizacao>${arr[6]}</DiaRealizacao>
        <ValorRealizacao>$realization</ValorRealizacao>
        <AnoAquisicao>${arr[8]}</AnoAquisicao>
        <MesAquisicao>${arr[9]}</MesAquisicao>
        <DiaAquisicao>${arr[10]}</DiaAquisicao>
        <ValorAquisicao>$acquisition</ValorAquisicao>
        <DespesasEncargos>$expenses</DespesasEncargos>
        <ImpostoPagoNoEstrangeiro>$tax</ImpostoPagoNoEstrangeiro>
        <CodPaisContraparte>${arr[14]}</CodPaisContraparte>
    </AnexoJq092AT01-Linha>
""" >> $OUTPUT
}

if [[ -z "$1" ]]; then
    echo "Usage: irs_j_9_2.sh <input_file> [output_file:-./output.xml] [field_separator:-' '] [start_line:-951]"
    exit 1
elif [[ ! -f "$1" ]]; then
    echo "Error: '$1' is not a valid file"
    echo "Usage: irs_j_9_2.sh <input_file> [output_file:-./output.xml] [field_separator:-' ' [start_line:-951]"
    exit 1
fi

truncate -s 0 $OUTPUT
IFS=$'\n';
DATA=(`cat $INPUT`)
echo "<AnexoJq092AT01>" >> $OUTPUT
for i in "${!DATA[@]}"; do
    append_irs_j_9_2_row $((i+1)) $(($START_LINE+1)) "${DATA[i]}"
done
echo "</AnexoJq092AT01>" >> $OUTPUT
echo "<AnexoJq092AT01SomaC01>$REALIZATION</AnexoJq092AT01SomaC01>" >> $OUTPUT
echo "<AnexoJq092AT01SomaC02>$ACQUISITION</AnexoJq092AT01SomaC02>" >> $OUTPUT
echo "<AnexoJq092AT01SomaC03>$EXPENSES</AnexoJq092AT01SomaC03>" >> $OUTPUT
echo "<AnexoJq092AT01SomaC04>$TAX</AnexoJq092AT01SomaC04>" >> $OUTPUT
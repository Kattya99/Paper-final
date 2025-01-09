cd "C:\Users\User\Documents\arti\BDD_ENDI_R2_dta"
use "BDD_ENDI_R2_f1_personas.dta", clear

*Borrar variables que no sirven 
drop id_upm id_viv id_hogar id_per id_mef fecha_anio fecha_mes fecha_dia fexp estrato 

drop parr_pri persona altitud edaddias 
drop grupo_edad_nin f1_s1_4_3 f1_s1_1 f1_s1_4_1 f1_s1_4_2 f1_s1_5 f1_s1_6 f1_s1_6_2
drop f1_s1_18

*Datos: 13913
*Desnutrición crónica infantil de niños entre 2 y 5 años
fre dcronica2_5
drop if dcronica2_5 == . 
label define desnutricion 0 "Sin desnutrición" 1 "Con desnutrición"
label values dcronica2_5 desnutricion


*variables de interés
*etnia
fre etnia

*pobreza nbi
rename nbi_1 pobreza_nbi
fre pobreza_nbi
fre pobreza_nbi, nolab

*Instrucción niños
rename f1_s1_15_1 instruccion_niño
fre instruccion_niño

*discapacidad niños
rename f1_s1_8 discapacidad_niño
fre discapacidad_niño
*sexo niños
rename f1_s1_2 sexo_niño
fre sexo_niño

*Provincia 
fre prov
*Región
fre region 

*Edad niños menores de 5 años (ESTA VARIABLE NO IRÍA)
fre grupo_edad_nin
label variable grupo_edad_nin "Edad niños"
label define edad_niños 3 "12-23 meses", add
lab def edad_niños 4 "24-35 meses", add
lab def edad_niños 5 "36-47 meses", add
lab def edad_niños 6 "48-59 meses", add
lab values grupo_edad_nin edad_niños 
fre grupo_edad_nin
tab grupo_edad_nin


*Pobreza
fre pobreza
drop if pobreza == .

*Agregue area (nueve de enero) rural y urbana 
fre area
*Cambié la variable edad en meses por años cumplidos de los niños
rename f1_s1_3_1 añoscumplidosni
fre añoscumplidosni

*Agregar variables de otras bases

*analisis
sum dcronica2_5, detail
tab dcronica2_5
tabulate pobreza
table (grupo_edad_nin pobreza region prov sexo_niño discapacidad_niño instruccion_niño pobreza_nbi etnia), ///
    statistic(frequency) statistic(percent)

	
tabulate grupo_edad_nin dcronica2_5, row
tabulate pobreza dcronica2_5, row
tabulate region dcronica2_5, row
tabulate prov dcronica2_5, row
tabulate sexo_niño dcronica2_5, row
tabulate discapacidad_niño dcronica2_5, row
tabulate instruccion_niño dcronica2_5, row 
tabulate pobreza_nbi dcronica2_5, row 
tabulate etnia dcronica2_5, row

tabulate dcronica2_5 etnia, chi2
tabulate dcronica2_5 pobreza, chi2
tabulate dcronica2_5 region, chi2

*Chi cuadrado

tabulate dcronica2_5 etnia, chi2 row
tabulate dcronica2_5 pobreza_nbi, chi2
tabulate dcronica2_5 pobreza, chi2
tabulate dcronica2_5 prov, chi2
tabulate dcronica2_5 discapacidad_niño, chi2
tabulate dcronica2_5 instruccion_niño, chi2
tabulate dcronica2_5 sexo_niño, chi2
tabulate dcronica2_5 grupo_edad_nin, chi2
tabulate dcronica2_5 region, chi2

*Tabla
clonevar dcronica2_52 = dcronica2_5
dtable i.dcronica2_52 ib3.etnia i.pobreza i.pobreza_nbi i.prov i.discapacidad_niño i.instruccion_niño i.sexo_niño i.sexo_niño i.grupo_edad_nin i.region, by (dcronica2_5, tests) export(Descriptive Table.docx) replace




*regresión lineal (esto solo se hizo como ejemplo)
logit dcronica2_5 etnia pobreza_nbi pobreza prov discapacidad_niño instruccion_niño sexo_niño grupo_edad_nin region


*Gráfico
fre dcronica2_5
graph pie, over(dcronica2_5) plabel(_all percent) title("Tasa de desnutrición crónica de niños de entre 2 y 5 años")

graph pie, over(dcronica2_5, label(angle(0))) ///
plabel(_all percent) ///
sliceopts(color(green yellow)) ///
title("Tasa de desnutrición crónica de niños de entre 2 y 5 años")


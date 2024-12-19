/* 
Analysis Objetive:

El análisis de esta investigación se centra en explorar la relación entre la desnutrición infantil y la etnia, además se identificará que variables sociodemográficas están relacionadas con la desnutrición infantil en Ecuador
*/ 

*Base de datos
cd "C:\Users\User\Documents\YRF\trabajo final\Base de datos limpieza"
use "BDD_ENDI_R2_f1_personas.dta", clear
describe
browse 

**** Inspect variables of interest 
/**************************************************************
**                        OUTCOME VARIABLE                   **
**************************************************************/
*Desnutrición crónica en menores de 5 años; nombre de la variable: (dcronica)
fre dcronica
rename dcronica des_cronica5
fre des_cronica5
tab des_cronica5, nolab

***Identificación de variables y etiquetar 
codebook des_cronica5

label variable des_cronica5 "Desnutrición crónica en menores de 5 años"

label define dcronica5 0 "No tiene desnutrición crónica" 
lab def dcronica5 1 "Tiene desnutrición crónica", add

lab values des_cronica5  dcronica5

tab des_cronica5
fre des_cronica5
drop if des_cronica5 == .
*Hay un total de 22331 niños, de los cuales 18338 no tienen desnutrición crónica y 3993 la tienen.  

/**************************************************************
**                        PREDICTOR VARIABLE                 **
**************************************************************/
*Etnia 
fre etnia 
tab etnia, nolab
drop if etnia == .

*Hay un total de 22331 participantes

**************************************************************
**                       CONTROL VARIABLES                    **
**************************************************************/
/*
Control Variables:
Control variables are variables that are included in a statistical model to account for potential confounding factors.

  These variables are not of primary interest in the analysis but are included to control for their effects on the relationship between the independent and dependent variables. By including control variables, we aim to isolate the 
specific impact of the main independent variable on the outcome variable, ensuring that the observed relationship is 
not influenced by these other factors.
*/
*Sexo niños
rename f1_s1_2 sexo_niño
fre sexo_niño
drop if sexo_niño == .
*hay 22331

*Provincia 
fre prov
tab prov, nolab
drop if prov == .
*hay 22331

*Región
fre region
tab region, nolab
drop if region == .
*hay 22331

*Edad niños menores de 5 años
fre grupo_edad_nin
drop if grupo_edad_nin == .
*hay 22331

*Años cumplidos del niños
rename f1_s1_3_1 años_cu
fre años_cu

label variable años_cu "Años cumplidos de los niños"

label define añoscumplidos 0 "Primeros meses" 
lab def añoscumplidos 1 "Un año", add
lab def añoscumplidos 2 "Dos años", add
lab def añoscumplidos 3 "Tres años", add
lab def añoscumplidos 4 "Cuatro años", add
lab values años_cu añoscumplidos  

tab años_cu
fre años_cu
drop if años_cu == . 
*hay 22331

*Discapacidad del niño
rename f1_s1_8 discapacidad
fre discapacidad
drop if discapacidad == .
*Hay 35 niños que tienen discapacidad, mientras que 22296 no la tienen.


*Porcentaje de discapacidad del niños
rename f1_s1_9 porcentaje_dis
fre porcentaje_dis

label variable porcentaje_dis "Porcentaje de discapacidad de los niños"
recode porcentaje_dis (9= 0) (30 33 35 36 38 39 41 42 43 44= 1) (53 54 55 60 64 65 70 78 80 81 86 88 94 95 97 99 100= 2), generate(por_disc)
fre por_disc

label define por_discapacidad 0 "Porcentaje de discapacidad leve"
lab def por_discapacidad 1 "Porcentaje de discapacidad moderada", add
lab def por_discapacidad 2 "Porcentaje de discapacidad grave", add


lab values por_disc por_discapacidad

tab por_disc
fre por_disc

*Pobreza
fre pobreza
drop if pobreza == .
*Hay 22201

rename nbi_1 pobreza_nbi
fre pobreza_nbi
drop if pobreza_nbi == .

*Mantener las variables de interés
keep des_cronica5 etnia sexo_niño prov region grupo_edad_nin años_cu discapacidad por_disc pobreza pobreza_nbi dcronica_2 dglobal_2 daguda_2 dglobal daguda dcronica2_5 dglobal2_5 daguda2_5 ane6_59 ane6_59_new ane6_23 ane6_23_new 

describe

/**************************************************************
**                          ANALYSES                          **
**************************************************************/
***Descriptive Table
dtable i.des_cronica5 ib3.etnia i.sexo_niño i.prov i.region i.grupo_edad_nin años_cu i.discapacidad i.por_disc i.pobreza  i.pobreza_nbi,  by(des_cronica5) export(Descriptive Table.xlsx)   //Error
clonevar des_cronica52 = des_cronica5
dtable i.des_cronica5 ib3.etnia i.sexo_niño i.prov i.region i.grupo_edad_nin i.años_cu i.discapacidad i.por_disc i.pobreza  i.pobreza_nbi, export(Descriptive Table.docx) replace

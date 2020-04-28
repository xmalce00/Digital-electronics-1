# Ultrazvukový merač vzdialenosti HC-SR4

### Utrazvukový merač
Funguje na princípe odrazu vysielaného ultrazku od okolitých objektov. Modul HC-SR4 obsahuje vysielač a prijímač, ďalej obsahuje štyri piny, dva slúžia na napájanie, tretí slúži na zahájenie merania (trigger) a posledný slúži ako výstupný pin (echo). Vlastné meranie prebieha tak, že na trigger sa privedie spúšťací inpulz vysokej úrovne v dĺžke trvania 10 µs, vysielač vyšle 8 meraných impulzov, tie vyhodnotí a na echo pin privedie signál vysokej úrovne odpovedajúcej dĺžky, ktorý sa následne spracuváva procesorom.

#### Obsah

1. [Zadanie](#Zadanie)
2. [Bloky kódu](#Bloky-kódu)
3. [Simulácia](#Simulácia)
4. [Schéma](#Schéma)
5. [Zdroje](#Zdroje)


## Zadanie

Ultrazvukový měřič vzdálenosti HC-SR04. Výstup na 7segmentovém displeji.


## Bloky kódu

Kód ultrazvukovéhu merača odsahuje päť hlavných blokov kódu, ktoré sú následne spojené do vrchného top modulu.
- sonar
- driver
- driver_7seg
- clock_enable
- hex_to_7seg

###Sonar
Tento blok je vstupný blok celého zariadenia. Jeho úlohou je vyslať pulz na začatie merania v určitej dĺžke a následne načítač dĺžku odrazeného pulzu echo. Toto číslo je potom vynásovené konštantov vdialenosti a dáta sú potom posielané do ďalšieho bloku dirver.

###Driver
Po prijatí dát od vstupného bloku je potrebné tieto dáta upraviť tak aby ich bolo možné zobraziť na sedemsegmentovom displayi ako jednotlivé čísla. Na tento účel slúži blok driver. Vstupný signál data_i je prevedený na typ premennej Integer, aby mohli byť jednoduchšie vykonávané matematické operácie. Pre určenie jednotiek daného čísla je použitá funkcia modulo 10, ktoré vráti hodnotu celočíselného zvyšku po delení 10. Pre získanie desiatok je číslo vydelené číslom 10 a potom je opäť použitá funkcia modulo 10. Pre stovky a tisíce sa postupoje obdobne. 

###

###

###


## Simulácia

TBD


## Schéma

TBD


## Zdroje

TBD

package com.mycompany.ejercicio2compi1;

%%

%class Lexer
%public
%line
%column
%int

%state PALABRA
 
espacio=[\s,\t,\r,\n]+

%{
    private StringBuffer bufferPalabra = new StringBuffer();

    private String[] palabrasSinVocal = new String[0];
    private String[] palabrasUnaVocal = new String[0];
    private String[] palabrasDosVocales = new String[0];
    private String[] palabrasTresVocales = new String[0];
    private String[] palabrasCuatroVocales = new String[0];
    private String[] palabrasCincoVocales = new String[0];
    private String[] palabrasMasVocales = new String[0];
    
    private int[][] posicionesDigitos = new int[0][2];

    private int countVocalesPalabra =  0;
    
    private void iniciarPalabra(){
        yybegin(PALABRA);
        bufferPalabra.append(yytext());
    }
    
    private void terminarPalabra(){
        agregarPalabra();
        limpiarBuffer();
    }
    
    private void limpiarBuffer(){
        bufferPalabra.delete(0, bufferPalabra.length());
    }
    
    private void agregarPalabra(){
        switch(countVocalesPalabra){
            case 0:
                palabrasSinVocal = agregarPalabra(bufferPalabra.toString(), palabrasSinVocal);
            break;
            case 1:
                palabrasUnaVocal = agregarPalabra(bufferPalabra.toString(), palabrasUnaVocal);
            break;
            case 2:
                palabrasDosVocales = agregarPalabra(bufferPalabra.toString(), palabrasDosVocales);
            break;
            case 3:
                palabrasTresVocales = agregarPalabra(bufferPalabra.toString(), palabrasTresVocales);
            break;
            case 4:
                palabrasCuatroVocales = agregarPalabra(bufferPalabra.toString(), palabrasCuatroVocales);
            break;
            case 5:
                palabrasCincoVocales = agregarPalabra(bufferPalabra.toString(), palabrasCincoVocales);
            break;
            default:
                palabrasMasVocales = agregarPalabra(bufferPalabra.toString(), palabrasMasVocales);
            break;
        }
        countVocalesPalabra = 0;
    }
    
    private String[] agregarPalabra(String palabra, String[] arreglo){
        String[] temp = new String[arreglo.length+1];
        for(int i=0; i<arreglo.length; i++){
            temp[i] = arreglo[i];
        }
        temp[temp.length-1] = palabra;
        return temp;
    }
    
    private void agregarPosicionDigito(int linea, int columna){
        int[][] temp = new int[posicionesDigitos.length+1][2];
        for(int i=0; i<posicionesDigitos.length; i++){
            temp[i][0] = posicionesDigitos[i][0];
            temp[i][1] = posicionesDigitos[i][1];
        }
        temp[temp.length-1][0] = linea;
        temp[temp.length-1][1] = columna;
        posicionesDigitos = temp;
    }

    public String[] getSinVocal(){
        return palabrasSinVocal;
    }

    public String[] getUnaVocal(){
        return palabrasUnaVocal;
    }

    public String[] getDosVocales(){
        return palabrasDosVocales;
    }

    public String[] getTresVocales(){
        return palabrasTresVocales;
    }

    public String[] getCuatroVocales(){
        return palabrasCuatroVocales;
    }

    public String[] getCincoVocales(){
        return palabrasCincoVocales;
    }

    public String[] getMasVocales(){
        return palabrasMasVocales;
    }
    
    public int[][] getPosicionesDigitos(){
        return posicionesDigitos;
    }
%}
 
%eof{
    terminarPalabra();
%eof}
 
%%


<YYINITIAL> {
    /*
    */
    (a|e|i|o|u|A|E|I|O|U) {iniciarPalabra();countVocalesPalabra++;}
    [0-9] {iniciarPalabra();agregarPosicionDigito(yyline+1, yycolumn+1);}
    ([a-zA-Z]|[0-9]) {iniciarPalabra();}
    {espacio} {agregarPalabra();}
    [^] {/*Ignorar*/}
}
 
<PALABRA> {
    (a|e|i|o|u|A|E|I|O|U) {bufferPalabra.append(yytext());countVocalesPalabra++;}
    [0-9] {bufferPalabra.append(yytext());agregarPosicionDigito(yyline+1, yycolumn+1);}
    ([a-zA-Z]|[0-9]) {bufferPalabra.append(yytext());}
    espacio|[^] {yybegin(YYINITIAL);terminarPalabra();}
    /*
    [^] {bufferPalabra.append(yytext());}
    */
}


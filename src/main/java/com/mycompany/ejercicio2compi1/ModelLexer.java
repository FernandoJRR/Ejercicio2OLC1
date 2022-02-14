package com.mycompany.ejercicio2compi1;

import java.io.IOException;
import java.io.Reader;
import java.io.StringReader;

public class ModelLexer {
    public static String getOutputLexer(String inputLexer){
        Reader reader = new StringReader(inputLexer);
        Lexer lexer = new Lexer(reader);
        try {
            int output = lexer.yylex();
            while (output != Lexer.YYEOF) {
                lexer.yylex();
            }
            int[][] posicionesDigitos = lexer.getPosicionesDigitos();
            String textoPosicionesDigitos = "";
            for (int i = 0; i < posicionesDigitos.length; i++) {
                textoPosicionesDigitos += posicionesDigitos[i][0]+"\t"+posicionesDigitos[i][1]+"\n";
            }
            String outputString =
                "Palabras con una vocal:\t\t"+lexer.getUnaVocal().length+"\n"+
                getPalabrasVocales(lexer.getUnaVocal())+
                "Palabras con dos vocales:\t\t"+lexer.getDosVocales().length+"\n"+
                getPalabrasVocales(lexer.getDosVocales())+
                "Palabras con tres vocales:\t\t"+lexer.getTresVocales().length+"\n"+
                getPalabrasVocales(lexer.getTresVocales())+
                "Palabras con cuatro vocales:\t\t"+lexer.getCuatroVocales().length+"\n"+
                getPalabrasVocales(lexer.getCuatroVocales())+
                "Palabras con cinco vocales:\t\t"+lexer.getCincoVocales().length+"\n"+
                getPalabrasVocales(lexer.getCincoVocales())+
                "Palabras con mas de cinco vocales:\t"+lexer.getMasVocales().length+"\n"+
                getPalabrasVocales(lexer.getMasVocales())+
                "Posiciones de Digitos:\n"+
                "Linea\tColumna\n"+
                textoPosicionesDigitos
            ;
            return outputString;
        } catch (IOException e) {
            e.printStackTrace();
            return "Ha ocurrido un error";
        }
    }
    
    private static String getPalabrasVocales(String[] arregloPalabras){
        String palabras = "";
        for (String palabra : arregloPalabras) {
            palabras += "->  "+palabra+"\n";
        }
        return palabras;
    }
}

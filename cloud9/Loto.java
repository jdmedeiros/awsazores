import java.util.Arrays;
import java.util.Random;
import java.util.Scanner;

public class Loto {

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        System.out.print("Quantos números? ");
        int n = sc.nextInt();
        System.out.print("Os números são de 1 até? ");
        int maxn = sc.nextInt();
        System.out.print("Quantas estrelas? ");
        int e = sc.nextInt();
        System.out.print("As estrelas são de 1 até? ");
        int maxe = sc.nextInt();
        GerarNumeros gn = new GerarNumeros(n, e, maxn, maxe);
        System.out.println(Arrays.toString(gn.getNumeros()) + " - " + Arrays.toString(gn.getEstrelas()));
        System.out.println("Boa sorte!");
    }

    private static class GerarNumeros {

        private int[] numeros;
        private int[] estrelas;

        private GerarNumeros(int nums, int ests, int maxn, int maxe) {
            this.numeros = new int[nums];
            this.estrelas = new int[ests];
            numeros = gerar(numeros, maxn);
            estrelas = gerar(estrelas, maxe);

        }

        private int[] gerar(int[] valores, int max) {
            Random r = new Random();
            for (int x = 0; x < valores.length; x++) {
                boolean duplicado = false;
                int randNum = r.nextInt(max) + 1;
                for (int numero : valores) {
                    if (numero == randNum) {
                        x--;
                        duplicado = true;
                        break;
                    }
                }
                if (!duplicado) {
                    valores[x] = randNum;

                }
            }

            boolean troquei;
            do {
                troquei = false;
                for (int x = 0; x < valores.length - 1; x++) {
                    if (valores[x] > valores[x + 1]) {
                        int temp = valores[x];
                        valores[x] = valores[x + 1];
                        valores[x + 1] = temp;
                        troquei = true;
                    }
                }
            } while (troquei);
            return valores;
        }

        private int[] getNumeros() {
            return numeros;
        }

        private int[] getEstrelas() {
            return estrelas;
        }
    }
}
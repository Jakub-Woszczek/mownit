#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <gsl/gsl_blas.h>

void naive_multiplication(double** A, double** B, double** C, int n);
void better_multiplication(double** A, double** B, double** C, int n);
void BLAS_multiplication(double** A, double** B, double** C, int n);

#define RUNS 11

int main() {
    int sizes[] = {50, 100, 150, 200, 250, 300};
    int num_sizes = sizeof(sizes) / sizeof(sizes[0]);

    FILE *f_naive = fopen("naive.csv", "w");
    FILE *f_better = fopen("better.csv", "w");
    FILE *f_blas  = fopen("blas.csv", "w");

    if (!f_naive || !f_better || !f_blas) {
        perror("Nie udało się otworzyć plików CSV");
        return 1;
    }

    for (int s = 0; s < num_sizes; s++) {
        int n = sizes[s];
        // Alokacja pamięci na tablice tablic (2D)
        double **A = malloc(n * sizeof(double*));
        double **B = malloc(n * sizeof(double*));
        double **C = malloc(n * sizeof(double*));
        double times_naive[RUNS], times_better[RUNS], times_blas[RUNS];
        for (int i = 0; i < n; i++) {
            A[i] = malloc(n * sizeof(double));
            B[i] = malloc(n * sizeof(double));
            C[i] = malloc(n * sizeof(double));
        }

        // Inicjalizacja losowymi wartościami
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                A[i][j] = rand() % 10 + 1;
                B[i][j] = rand() % 10 + 1;
                C[i][j] = 0;
            }
        }

        // Naive
        for (int r = 0; r < RUNS; r++) {
            clock_t start = clock();
            naive_multiplication(A, B, C, n);
            clock_t end = clock();
            times_naive[r] = ((double)(end - start)) / CLOCKS_PER_SEC;
        }

        // Better
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                C[i][j] = 0;
            }
        }
        for (int r = 0; r < RUNS; r++) {
            clock_t start = clock();
            better_multiplication(A, B, C, n);
            clock_t end = clock();
            times_better[r] = ((double)(end - start)) / CLOCKS_PER_SEC;
        }

        // BLAS
        for (int r = 0; r < RUNS; r++) {
            clock_t start = clock();
            BLAS_multiplication(A, B, C, n);
            clock_t end = clock();
            times_blas[r] = ((double)(end - start)) / CLOCKS_PER_SEC;
        }

        // Zapisz wyniki bez pierwszego pomiaru
        for (int r = 1; r < RUNS; r++) {
            fprintf(f_naive, "%d,%.6f\n", n, times_naive[r]);
            fprintf(f_better, "%d,%.6f\n", n, times_better[r]);
            fprintf(f_blas, "%d,%.6f\n", n, times_blas[r]);
        }

        free(A);
        free(B);
        free(C);
    }

    fclose(f_naive);
    fclose(f_better);
    fclose(f_blas);

    printf("Pomiary zakończone i zapisane do plików CSV.\n");
    return 0;
}

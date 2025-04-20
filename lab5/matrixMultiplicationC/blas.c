#include <gsl/gsl_blas.h>
#include <gsl/gsl_matrix.h>

void flatten_matrix(double **src, double *dest, int n) {
    for (int i = 0; i < n; i++)
        for (int j = 0; j < n; j++)
            dest[i * n + j] = src[i][j];
}

void BLAS_multiplication(double** A, double** B, double** C, int n) {
    double *A_flat = malloc(n * n * sizeof(double));
    double *B_flat = malloc(n * n * sizeof(double));
    double *C_flat = malloc(n * n * sizeof(double));

    flatten_matrix(A, A_flat, n);
    flatten_matrix(B, B_flat, n);

    gsl_matrix_view Am = gsl_matrix_view_array(A_flat, n, n);
    gsl_matrix_view Bm = gsl_matrix_view_array(B_flat, n, n);
    gsl_matrix_view Cm = gsl_matrix_view_array(C_flat, n, n);

    gsl_blas_dgemm(CblasNoTrans, CblasNoTrans,
                   1.0, &Am.matrix, &Bm.matrix,
                   0.0, &Cm.matrix);

    for (int i = 0; i < n; i++)
        for (int j = 0; j < n; j++)
            C[i][j] = C_flat[i * n + j];

    free(A_flat);
    free(B_flat);
    free(C_flat);
}

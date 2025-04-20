void better_multiplication(double** A, double** B, double** C, int n) {
    for (int i = 0; i < n; i++) {  // iterujemy po wierszach A i C
        for (int j = 0; j < n; j++) {  // iterujemy po kolumnach B i C
            C[i][j] = 0;  // Zerujemy element C[i][j]
            for (int k = 0; k < n; k++) {  // iterujemy po kolumnach A i wierszach B
                C[i][j] += A[i][k] * B[k][j];
            }
        }
    }
}

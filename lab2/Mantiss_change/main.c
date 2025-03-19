#include <stdio.h>
#include <gsl/gsl_ieee_utils.h>

int main() {
    double x = 1.0;
    FILE *file = fopen("wyniki.txt", "w");
    if (file == NULL) {
        perror("Nie można otworzyć pliku");
        return 1;
    }

    printf("Analiza reprezentacji IEEE 754 dla malejących liczb zmiennoprzecinkowych:\n");
    fprintf(file, "Analiza reprezentacji IEEE 754 dla malejących liczb zmiennoprzecinkowych:\n");

    for (int i = 0; i < 100; i++) {
        printf("\nx = %e\n", x);
        fprintf(file, "\nx = %e\n", x);

        printf("Reprezentacja IEEE 754: ");
        fprintf(file, "Reprezentacja IEEE 754: ");

        gsl_ieee_printf_double(&x);
        printf("\n");

        gsl_ieee_fprintf_double(file, &x);
        fprintf(file, "\n");

        x /= 2.0; // Zmniejszamy liczbę o połowę
    }

    fclose(file);
    return 0;
}

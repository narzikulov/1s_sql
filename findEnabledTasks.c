#include <stdio.h>
#include <string.h>
#include <locale.h>
#define STR_LENGTH 1024
#define RESULT_FILE_NAME "result.txt"

// void resultFileSort();

int main (int argc, char *argv[]) {
    int error = 0;
    setlocale(LC_ALL, "ru_RU.UTF-8");

    if (argc < 1) {
        error = 1;
        printf("There is no path to file 1CV8Clsto.lst\n");
    }

    char fileName[] = "";
    strcat(fileName, argv[1]);
    printf("Opening file %s ... \n", fileName);

    FILE *file = fopen(fileName, "r");
    if (file) {
        char resFile[] = RESULT_FILE_NAME;
        FILE *outFile = fopen(resFile, "w");
        char bufferPrev[STR_LENGTH] = "";
        char bufferCur[STR_LENGTH] = "";
        while (fgets(bufferPrev, STR_LENGTH, file) != NULL) {
            if (fgets(bufferCur, STR_LENGTH, file) == NULL) 
                break; 

            if (bufferCur[0] == '{' && bufferCur[1] == '0' && bufferCur[2] == ',' && bufferCur[45] == '0' ) {
                // fprintf(outFile, "%s \n", bufferPrev);
                int firstSymbolOfBaseName = 39;
                while (bufferPrev[firstSymbolOfBaseName] != 34) {
                    fprintf(outFile, "%c", bufferPrev[firstSymbolOfBaseName]);
                    firstSymbolOfBaseName++;
                }
                fprintf(outFile, "\t");
                firstSymbolOfBaseName += 3;
                while (bufferPrev[firstSymbolOfBaseName] != 34) {
                    fprintf(outFile, "%c", bufferPrev[firstSymbolOfBaseName]);
                    firstSymbolOfBaseName++;
                }                
                fprintf(outFile, "\n");
            }
        }
        fclose(outFile);
    } else {
        error = 1;
        printf("Incorrect file name %s\n", fileName);
    }

    if (error) {
        printf("Error");
    }

    fclose(file);

    // resultFileSort();

    return 0;
}

// void resultFileSort() {
//     FILE *file = fopen("res_sorted.txt", "w");
//     FILE *fileSorted = fopen(RESULT_FILE_NAME, "r");
//     char buffer[100] = "";
//     char resArray[100][1000];
//     int index = 0;
//     while (fgets(buffer, STR_LENGTH, file) != NULL) {
        
//         resArray[index] = buffer
//     }

// }
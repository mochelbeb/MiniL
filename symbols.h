#include <stdbool.h>
#include <string.h>
#include <stdio.h>

#define MAX_SYMBOLS 100
#define Max_array_length 20

typedef struct {
    int int_val;
    float float_val;
    char str_val[128];
    int type;
    struct {
        int size;
        int values[Max_array_length];
    } int_array;
    struct {
        int size;
        float values[Max_array_length];
    } float_array;
    struct {
        int size;
        char values[Max_array_length][128];
    } string_array;
} value;

typedef struct {
    char name[32];
    int type;
    value value;
} symbol_t;

symbol_t symbols[MAX_SYMBOLS];
int num_symbols = 0;

bool symbol_exists(char* name) {
    for (int i = 0; i < num_symbols; i++) {
        if (strcmp(symbols[i].name, name) == 0) {
            return true;
        }
    }
    return false;
}

void add_symbol(char* name, int type, int value1, float value2, char value3[128]) {
    if (num_symbols >= MAX_SYMBOLS) {
        // Symbol table is full
        return;
    }   
    strcpy(symbols[num_symbols].name, name);
    switch (type)
    {
    case 1:
        symbols[num_symbols].value.int_val = value1;
        break;
    case 2:
        symbols[num_symbols].value.float_val = value2;
        break;
    case 3:
        for (size_t i = 0; i < 128; i++)
        {
            symbols[num_symbols].value.str_val[i] = value3[i];
        }
        break;
    default:
        break;
    }
    symbols[num_symbols].type = type;
    num_symbols++;
}
symbol_t* get_symbol(char* name) {
    for (int i = 0; i < num_symbols; i++) {
        if (strcmp(symbols[i].name, name) == 0) {
            return &symbols[i];
        }
    }
    return NULL;
}
void print_symbol(char* name) {
    symbol_t* symbol = get_symbol(name);
    if (symbol == NULL) {
        printf("%s is not defined\n", name);
        return;
    }
    switch (symbol->type) {
        case 1:
            printf("%s = %d\n", name, symbol->value.int_val);
            break;
        case 2:
            printf("%s = %f\n", name, symbol->value.float_val);
            break;
        case 3:
            printf("%s = %s\n", name, symbol->value.str_val);
            break;
    }
}
void input_symbol(char* nom) {
    symbol_t* symbol = get_symbol(nom);
    if (symbol == NULL) {
        printf("Error : %s is not defined",symbol->name);
        return;
  }
  switch (symbol->type) {
    case 1:
      printf("%s = ", symbol->name);
      while(scanf("%d", symbol->value.int_val)!=1){};
      printf("\n");
      break;
    case 2:
      printf("%s = ", symbol->name);
      while(scanf("%f", symbol->value.float_val)!=1){};
      printf("\n");
      break;
    case 3:
      printf("%s = ", symbol->name);
      while(scanf("%s", symbol->value.str_val)!=1){};
      printf("\n");
      break;
    default:
      printf("Error: unknown symbol type\n");
      break;
  }
}
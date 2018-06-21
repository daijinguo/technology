#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>

int  base  [] = { 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 };
char values[] = { '1', '0', 'x', '9', '8', '7', '6', '5', '4', '3', '2' };

int function(const char* card){
    if(NULL == card) {
        return -1;
    }
    size_t n      = strlen(card);
    size_t m      = sizeof(base) / sizeof( base[0] );
    int    result = 0;

    if( n < 17 ) {
        return -2;
    }

    for(int i = 0; i < m; ++i){
        char p = card[i];
        int yes = isdigit( p );
        if( yes != 0 ) {
            int data = atoi( &p );

            result += data * base[i];
        }
        else{
            printf("string %s has a not digit[%c]\n", card, p);
            return -3;
        }
    }

    return result;
}

char value( int sum ) {
    return values[sum % 11];
}

int main( int argc, char* argv[] ) {

    int result = -10;

    if(argc >= 2) {
        printf("Your IDCard: %s\n", argv[1]);

        result = function( argv[1] );

        printf("Your ID card last numer is: %c \n", value(result) );
    }

    return 0;
}

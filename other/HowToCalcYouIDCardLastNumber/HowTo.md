中华人民共和国居民身份证最后一位生成方式

| 身份证前 17 位 |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |
|-----------|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|
| 每个数字对应系数  | 7   | 9   | 10  | 5   | 8   | 4   | 2   | 1   | 6   | 3   | 7   | 9   | 10  | 5   | 8   | 4   | 2   |

将前 17 位数字与对应的系数相乘，其结果相加，其和除以 11， 余数只可能是如下 11 个数字，一定为：

| 余数顺序   | 0   | 1   | 2   | 3   | 4   | 5   | 6   | 7   | 8   | 9   | 10  |
|--------|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|
| 余数对应数字 | 1   | 0   | X   | 9   | 8   | 7   | 6   | 5   | 4   | 3   | 2   |

其中 X 表示罗马数字 10。

可以使用如下的程序进行计算得到相关的最后一位: idcard.c

```c
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
```

    gcc -o idcard idcard.c
    ./idcard 01234567891234567



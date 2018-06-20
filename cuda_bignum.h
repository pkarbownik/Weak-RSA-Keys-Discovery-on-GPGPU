/** @file cuda_bignum.h
 *  @brief Unit tests
 *
 *  Functions used in GCD algorithm and in main
 *
 *  @author Przemysław Karbownik (pkarbownik)
 */

#ifndef CUDA_BIGNUM_H
#define CUDA_BIGNUM_H

#include <stdio.h>
#include <openssl/rsa.h>
#include <openssl/pem.h>
#include <openssl/bn.h>
#include <string.h>
#include <time.h>
#include <assert.h>
#include <ctype.h>
#include "cuda_runtime.h"

#define DEBUG 0

#if defined(DEBUG) && DEBUG > 0
 #define DEBUG_PRINT(fmt, args...) fprintf(stderr, "DEBUG: %s:%d:%s(): " fmt, \
    __FILE__, __LINE__, __func__, ##args)
#else
 #define DEBUG_PRINT(fmt, args...) /* Don't do anything in release builds */
#endif

struct   __U_BN__{
    unsigned* d;       
    int     top;    
};

typedef struct __U_BN__     U_BN;

#define debug(fmt, ...) printf("%s:%d: " fmt, __FILE__, __LINE__, __VA_ARGS__);


# define cu_bn_correct_top(a) \
        { \
        unsigned *ftl; \
        int tmp_top = (a)->top; \
        if (tmp_top > 0) \
                { \
                for (ftl= &((a)->d[tmp_top-1]); tmp_top > 0; tmp_top--) \
                        if (*(ftl--)) break; \
                (a)->top = tmp_top; \
                } \
        }

/************************64bit version*********************/
//# define CU_BN_MASK2        (0xffffffffffffffffL)
//# define CU_BN_DEC_NUM      19
//# define CU_BN_DEC_CONV     (10000000000000000000UL)
//# define CU_BN_MASK2l       (0xffffffffL)

/************************32bit version*********************/
#define cu_bn_zero(a)      (cu_bn_set_word((a),0))
#define cu_bn_is_odd(a)        (((a)->top > 0) && ((a)->d[0] & 1))
#define cu_bn_is_zero(a)       (a->top==1 && a->d[0]==0)
#define cu_bn_is_initialized() 
#define CU_BN_BITS2        32
#define CU_BN_BITS4        16
#define CU_BN_BYTES        8
#define CU_BN_MASK2        (0xffffffffL)
#define CU_BN_MASK2l       (0xffff)
#define CU_BN_MASK2h1      (0xffff8000L)
#define CU_BN_MASK2h       (0xffff0000L)
#define CU_BN_DEC_CONV     (1000000000L)
#define CU_BN_DEC_NUM      9
#define CU_BN_DEC_FMT1     "%u"
#define CU_BN_DEC_FMT2      "%09u"
#define CU_BN_TBIT         (0x80000000L)

#define Lw(t)    (((unsigned)t))
#define Hw(t)    ((unsigned)((t)>>CU_BN_BITS2))


/** @brief Function reverses a given string
 *
 *	Function reverses a given string
 *
 *  @param[in] str - input string 
 *  @return reversed input string
 */
char *strrev(char *str);

/** @brief Allocates and initializes a U_BN structure
 *
 *	Allocates and initializes a U_BN structure
 *
 *  @param Void
 *  @return initialized U_BN
 */
U_BN *cu_bn_new();

/** @brief Allocates and initializes a U_BN structure
 *
 *	Frees the components of the U_BN, and if it was created by cu_bn_new()
 *
 *  @param[in] a U_BN strunture that need to be free
 *  @return Void
 */
void cu_bn_free(U_BN *a);

/** @brief Set a to the unsigned integer w value
 *
 *	Set a to the unsigned integer w value
 *
 *  @param[in] a U_BN structure
 *  @param[in] w unsigned integer word
 *  @return 1 on success
 */
int cu_bn_set_word(U_BN *a, unsigned w);

/** @brief Perform multiplication operation on U_BN with unsigned integer
 *
 *	Perform multiplication operation on U_BN with unsigned integer
 *
 *  @param[in] a U_BN structure
 *  @param[in] w unsigned integer word
 *  @return 1 on success
 */
int cu_bn_mul_word(U_BN *a, unsigned w);

/** @brief Perform addition operation on U_BN with unsigned integer
 *
 *	Perform addition operation on U_BN with unsigned integer
 *
 *  @param[in] a U_BN structure
 *  @param[in] w unsigned integer word
 *  @return 1 on success
 */
int cu_bn_add_word(U_BN *a, unsigned w);


/** @brief Converts the string a containing a decimal number to a U_BN
 *
 *	Converts the string a containing a decimal number to a U_BN
 *
 *  @param[in, out] ret U_BN structure for number stored in string
 *  @param[in] a input string
 *  @return 1 on success
 */
int cu_bn_dec2bn(U_BN * ret, const char *a);


/** @brief Multilication unsigned integer array with single unsigned integer value
 *
 *	Multilication unsigned integer array with single unsigned integer value
 *
 *  @param[out] rp unsigned integer array procduct
 *  @param[out] ap unsigned integer array multiplicand
 *  @param num size of unsigned integer array multiplicand
 *  @param w unsigned integer word multiplicator
 *  @return last unsigned integer carry of multiplication
 */
unsigned  cu_bn_mul_words(unsigned  *rp, const unsigned  *ap, int num, unsigned  w);


/** @brief Converts U_BN to string with a hexadecimal number
 *
 *	Converts U_BN to string with a hexadecimal number
 *
 *  @param[in, out] a U_BN structure
 *  @return string with a hexadecimal number from input U_BN structure
 */
char *cu_bn_bn2hex(const U_BN *a);


/** @brief Compares the numbers a and b
 *
 *	Compares the numbers a and b
 *
 *  @param[in] a U_BN structure
 *  @param[in] b U_BN structure
 *  @return -1 if a < b, 0 if a == b and 1 if a > b
 */
int cu_bn_ucmp(const U_BN *a, const U_BN *b);


/** @brief Absolute value of a long integer
 *
 *	Absolute value of a long integer
 *
 *  @param[in] number long integer
 *  @return absolute long integer of input number
 */
long cu_long_abs(long number);


/** @brief Subtracts b from a and places the result in c
 *
 *	Subtracts b from a and places the result in c
 *
 *  @param[in] a U_BN structure minuend
 *  @param[in] b U_BN structure subtrahend
 *  @param[out] c U_BN structure difference
 *  @return 1 on success
 */
int cu_bn_usub(const U_BN *a, const U_BN *b, U_BN *c);


/** @brief Calculate number of bits in input long integer
 *
 *	Calculate number of bits in input long integer
 *
 *  @param[in] l unsigned integer word
 *  @return number of bits of input l
 */
int cu_bn_num_bits_word(long l);


/** @brief Calculate number of bits in input U_BN strunture
 *
 *	Calculate number of bits in input U_BN strunture
 *
 *  @param[in] a U_BN structure
 *  @return number of bits of input a
 */
int cu_bn_num_bits(const U_BN *a);


/** @brief Calculate number of digits in input long integer
 *
 *	Calculate number of digits in input long integer
 *
 *  @param[in] l unsigned integer word
 *  @return number of digits of input a
 */
unsigned number_of_digits(long number);


/** @brief Converts the long integer to string
 *
 *	Converts the long integer to string
 *
 *  @param[in] number input long integer
 *  @return return string with number stored in number
 */
char *long2string(long number);


/** @brief Perform addition operation on numbers stored in strings
 *
 *	Perform addition operation on numbers stored in strings
 *
 *  @param[in] a first string addend
 *  @param[in] a first string addend
 *  @return sum as string
 */
char *string_num_add(const char *a, const char *b);


/** @brief Perform addition operation on number stored in string and long integer
 *
 *	Perform addition operation on number stored in string and long integer
 *
 *  @param[in] a string addend
 *  @param[in] b long integer addend
 *  @return sum as string
 */
char *string_num_add_long(const char *a, long b);

/** @brief Copies value from b to a
 *
 *	Copies value from b to a
 *
 *  @param[in] a U_BN structure
 *  @param[in] a U_BN structure
 *  @return 1 on success
 */
int cu_bn_copy(U_BN *a, const  U_BN *b);


/** @brief Shifts a right by one and returns the result (a/2)
 *
 *	Shifts a right by one and returns the result (a/2)
 *
 *  @param[in] a U_BN structure
 *  @return 1 on success
 */
int cu_bn_rshift1(U_BN *a);


/** @brief Shifts a left by input n and returns the result (a*2^n)
 *
 *	Shifts a left by n bits and returns the result (r=a*2^n)
 *
 *  @param[in,out] a U_BN struct
 *  @param[in] n number of bits to left
 *  @return 1 on success
 */
int cu_bn_lshift(U_BN *a, unsigned n);

/** @brief Binary Euclidean algorithm
 *
 *	computes the greatest common divisor of a and b using 
 *	binary Euclidean algorithm and return the result in r. 
 *	r may be the same BIGNUM as a or b.
 *
 *  @param[in,out] a U_BN struct
 *  @param[in,out] b U_BN struct
 *  @return r U_BN result of GCD
 */
U_BN *cu_binary_gcd(U_BN *a, U_BN *b);

/** @brief Converts BIGNUM OpenSSL to U_BN
 *
 *	Converts BIGNUM OpenSSL to U_BN
 *
 *  @param[in] a BIGNUM structure
 *  @param[in] w U_BN structure
 *  @return 1 on success
 */
int bignum2u_bn(BIGNUM* bignum, U_BN *u_bn);

/** @brief Fast binary Euclidean
 *
 *	computes the greatest common divisor of a and b using 
 *	fast binary Euclidean algorithm and return the result in r. 
 *	r may be the same BIGNUM as a or b.
 *
 *  @param[in,out] a U_BN struct
 *  @param[in,out] b U_BN struct
 *  @return r U_BN result of GCD
 */
U_BN *cu_fast_binary_euclid(U_BN *a, U_BN *b);

/** @brief Euclidean algorithm
 *
 *	computes the greatest common divisor of a and b using 
 *	Euclidean algorithm and return the result in r. 
 *	r may be the same BIGNUM as a or b.
 *
 *  @param[in,out] a U_BN struct
 *  @param[in,out] b U_BN struct
 *  @return r U_BN result of GCD
 */
U_BN *cu_classic_euclid(U_BN *a, U_BN *b);

/** @brief Copies value from b to a
 *
 *	Copies value from b to a
 *
 *  @param[in] a U_BN structure
 *  @param[in] a U_BN structure
 *  @return 1 on success
 */
int cu_ubn_copy(U_BN *a, const U_BN *b);

/** @brief Perform addition operation on U_BN with unsigned integer
 *
 *	Perform addition operation on U_BN with unsigned integer
 *
 *  @param[in] a U_BN structure
 *  @param[in] w unsigned integer word
 *  @return 1 on success
 */
unsigned cu_ubn_add_words(unsigned *r, const unsigned *a, const unsigned *b, int n);


/** @brief Adds a and b and places the result in r ("r=a+b")
 *
 *	Adds a and b and places the result in r ("r=a+b")
 *
 *  @param[in] a U_BN structure addend
 *  @param[in] a U_BN structure addend
 *  @param[in] r sum as U_BN
 *  @return 1 on success
 */
int cu_ubn_uadd(const U_BN *a, const U_BN *b, U_BN *r);

/*TO DO*/

U_BN *q_algorithm_PM(U_BN *a, U_BN *b);

/*TO DO*/

U_BN *algorithm_PM(U_BN *a, U_BN *b, unsigned keysize);

/*TO DO*/

int cu_bn_usub_optimized(const U_BN *a, const U_BN *b, U_BN *r);

#endif /* CUDA_BIGNUM_H */

/** @file test.h
 *  @brief Unit tests
 *
 *	Functions for testing U_BN data operations
 *
 *  @author Przemysław Karbownik (pkarbownik)
 */

#ifndef TEST_H
#define TEST_H

#include "cuda_bignum.h"
#include "files_manager.h"
#include <assert.h>
#include <time.h>

#define TRACE 1

#if defined(TRACE) && TRACE > 0
 #define INFO(fmt, args...) fprintf(stderr, "INFO: %s:%d:%s(): " fmt, \
    __FILE__, __LINE__, __func__, ##args)
#else
 #define INFO(fmt, args...) /* Don't do anything in release builds */
#endif

/** @brief Main tests functions that runs all tests
 *
 *	Function involving all tests and can be called.
 *	in main function to perform all tests.
 *
 *  @param Void
 *  @return Void
 */

void unit_test(void);

/** @brief Test U_BN initialization of data
 *
 *	Allocates and frees a U_BN structure 100 times.
 *
 *  @param Void
 *  @return Void
 */
void cu_bn_new_test(void);

/** @brief Test Hw macro
 *
 *	Test if Hw returns correct 32-bit MSB value of 64-bit number.
 *
 *  @param Void
 *  @return Void
 */
void Hw_test();

/** @brief Test Lw macro
 *
 *	Test if Lw returns correct 32-bit LSB value of 64-bit number.
 *
 *  @param Void
 *  @return Void
 */
void Lw_test();

/** @brief Test cu_bn_mul_words
 *
 *	Test if cu_bn_mul_words returns correct multilication result
 *	unsigned array with single unsigned value.
 *
 *  @param Void
 *  @return Void
 */
void cu_bn_mul_words_test(void);

/** @brief Test cu_bn_mul_word
 *
 *	Test if cu_bn_mul_word returns correct result of multiplication
 *	U_BN number by unsigned array.
 *
 *  @param Void
 *  @return Void
 */
void cu_bn_mul_word_test(void);

/** @brief Test cu_bn_set_word
 *
 *	Test if cu_bn_set_word set U_BN as word value.	
 *
 *  @param Void
 *  @return Void
 */
void cu_bn_set_word_test(void);

/** @brief Test cu_bn_mul_word
 *
 *	Test if U_BN after performing cu_bn_add_word is 
 *	result of an addditon U_BN and word . 
 *
 *  @param Void
 *  @return Void
 */
void cu_bn_add_word_test(void);

/** @brief Test cu_bn_dec2bn
 *
 *	Test if U_BN is equal to string decimal value after 
 *	performing cu_bn_dec2bn.
 *
 *  @param Void
 *  @return Void
 */
void cu_bn_dec2bn_test(void);

/** @brief Test cu_bn_bn2hex
 *
 *	Test if U_BN is equal to string hexadecimal value after 
 *	performing cu_bn_bn2hex.
 *
 *  @param Void
 *  @return Void
 */
void cu_bn_bn2hex_test(void);

/** @brief Test cu_bn_ucmp
 *
 *	Test if cu_bn_ucmp returns correct result of comparision 
 *	two U_BN.
 *
 *  @param Void
 *  @return Void
 */
void cu_bn_ucmp_test(void);

/** @brief Test cu_long_abs
 *
 *	Test if cu_long_abs returns absolute value of a long 
 *	integer.
 *
 *  @param Void
 *  @return Void
 */
void cu_long_abs_test(void);

/** @brief Test cu_bn_usub
 *
 *	Test if cu_bn_usub return correct value of subraction two U_BN
 *	integer.
 *
 *  @param Void
 *  @return Void
 */
void cu_bn_usub_test(void);

/** @brief Test cu_bn_usub_optimized
 *
 *	Test if cu_bn_usub_optimized return correct value of 
 *	subraction two U_BN integer.
 *
 *  @param Void
 *  @return Void
 */
void cu_bn_usub_optimized_test(void);

/** @brief Test cu_bn_num_bits_word
 *
 *	Test if cu_bn_num_bits_word returns correct number of bits 
 *	in a long integer.
 *
 *  @param Void
 *  @return Void
 */
void cu_bn_num_bits_word_test(void);

/** @brief Test cu_bn_num_bits_word
 *
 *	Test if cu_bn_num_bits_word returns correct number of bits 
 *	in a U_BN.
 *
 *  @param Void
 *  @return Void
 */
void cu_bn_num_bits_test(void);

/** @brief Test string_num_add
 *
 *	Test if string_num_add returns correct result of a adding 
 *	two numbers saved as string.
 *
 *  @param Void
 *  @return Void
 */
void string_num_add_test(void);

/** @brief Test number_of_digits
 *
 *	Test if number_of_digits returns correct number of digits of 
 *	long integer number.
 *
 *  @param Void
 *  @return Void
 */
void number_of_digits_test(void);

/** @brief Test long2string
 *
 *	Test if long2string returns proper string after conversion 
 *	from long integer.
 *
 *  @param Void
 *  @return Void
 */
void long2string_test(void);

/** @brief Test string_num_add_long
 *
 *	Test if string_num_add_long returns proper result of a 
 *	addition string and long integer.
 *
 *  @param Void
 *  @return Void
 */
void string_num_add_long_test(void);

/** @brief Test cu_bn_rshift1
 *
 *	Test if cu_bn_rshift1 result is divided by 2 
 *	(the same operation like U_BN>>1).
 *
 *  @param Void
 *  @return Void
 */
void cu_bn_rshift1_test(void);

/** @brief Test cu_bn_lshift
 *
 *	Test if cu_bn_lshift result is left shifted 
 *	by input number.
 *
 *  @param Void
 *  @return Void
 */
void cu_bn_lshift_test(void);

/** @brief Test cu_binary_gcd
 *
 *	Test if cu_binary_gcd result using binary Euclidean algorithm 
 *	is greatest common divisor of two U_BN.
 *
 *  @param Void
 *  @return Void
 */
void cu_binary_gcd_test(void);

/** @brief Test cu_binary_gcd
 *
 *	Test if bignum2u_bn result of conversion BIGNUM to U_BN 
 *	returns correct value.
 *
 *  @param Void
 *  @return Void
 */
void bignum2u_bn_test(void);

/** @brief Test get_u_bn_from_mod_PEM
 *
 *	Test if get_u_bn_from_mod_PEM is done correctly, but correctness 
 *	of result is not checked.
 *
 *  @param Void
 *  @return Void
 */
void get_u_bn_from_mod_PEM_test(void);

/** @brief Test cu_binary_gcd
 *
 *	Test if cu_binary_gcd result using fast binary Euclidean 
 *	algorithm is greatest common divisor of two U_BN.
 *
 *  @param Void
 *  @return Void
 */
void cu_fast_binary_euclid_test(void);

/** @brief Test cu_binary_gcd
 *
 *	Test if cu_binary_gcd result using Euclidean 
 *	algorithm is greatest common divisor of two U_BN.
 *
 *  @param Void
 *  @return Void
 */
void cu_classic_euclid_test(void);

/** @brief Test cu_ubn_copy
 *
 *	Test if cu_ubn_copy clone U_BN.
 *
 *  @param Void
 *  @return Void
 */
void cu_ubn_copy_test(void);

/** @brief Test cu_ubn_uadd
 *
 *	Test if cu_ubn_uadd returns addition result of 
 *	two U_BN.
 *
 *  @param Void
 *  @return Void
 */
void cu_ubn_uadd_test(void);

/** @brief Test cu_ubn_add_words
 *
 *	Test if cu_ubn_add_words returns correct result of 
 *	adding two unsigned arrays.
 *
 *  @param Void
 *  @return Void
 */
void cu_ubn_add_words_test(void);

/** @brief Test q_algorithm_PM
 *
 *	Test if q_algorithm_PM result using Approximate Euclidean 
 *	algorithm is greatest common divisor of two U_BN.
 *
 *  @param Void
 *  @return Void
 *	@bug not completed tests
 */
void q_algorithm_PM_test(void);

/** @brief Test algorithm_PM
 *
 *	Test if algorithm_PM result using Approximate Euclidean 
 *	algorithm is greatest common divisor of two U_BN.
 *
 *  @param Void
 *  @return Void
 *	@bug not completed tests
 */
void algorithm_PM_test(void);
#endif /* TEST_H */


/** @file device_cuda_bignum.h
 *  @brief Unit tests
 *
 *	Functions used in GCD algorithm and in main
 *
 *  @author Przemysław Karbownik (pkarbownik)
 */

#ifndef _DEVICE_CUDA_BIGNUM_H_
#define _DEVICE_CUDA_BIGNUM_H_

#include "test.h"
#include "cuda_bignum.h"
#include "files_manager.h"
#include <time.h>



/** @brief cu_dev_bn_ucmp
 *
 *	compares the numbers a and b.
 *
 *  @param[in] a first U_BN value for comparision
 *  @param[in] b second U_BN value for comparision
 *  @return -1 if a < b, 0 if a == b and 1 if a > b
 */
__host__ __device__ int cu_dev_bn_ucmp(const U_BN *a, const U_BN *b);


/** @brief cu_dev_long_abs
 *
 *	cu_dev_long_abs returns absolute value of a long 
 *	integer.
 *
 *  @param[in] number 
 *  @return absolute value of number 
 */
__host__ __device__ long cu_dev_long_abs(long number);

/** @brief cu_dev_bn_usub
 *
 *	subtracts b from a.
 *
 *  @param[in,out] a U_BN number
 *  @param[in,out] b U_BN number
 *  @param[in,out] r result
 *  @return 1 on success
 */
__host__ __device__ int cu_dev_bn_usub(const U_BN *a, const U_BN *b, U_BN *r);

/** @brief cu_dev_bn_rshift1
 *
 *	shifts a right by one and returns the result (a/2)
 *
 *  @param[in,out] a U_BN number
 *  @return 1 on success
 */
__host__ __device__ int cu_dev_bn_rshift1(U_BN *a);

/** @brief cu_dev_bn_lshift
 *
 *	shifts a left by n bits and returns the result (r=a*2^n)
 *
 *  @param[in,out] a U_BN number
 *  @param[in,out] n number of bits to left
 *  @return 1 on success
 */
__host__ __device__ int cu_dev_bn_lshift(U_BN *a, unsigned n);

/** @brief cu_dev_binary_gcd
 *
 *	computes the greatest common divisor of a and b using 
 *	binary Euclidean algorithm and return the result in r. 
 *	r may be the same BIGNUM as a or b.
 *
 *  @param[in,out] a U_BN number
 *  @param[in,out] b U_BN number
 *  @return r U_BN result of GCD
 */
__host__ __device__ U_BN *cu_dev_binary_gcd(U_BN *a, U_BN *b);

/** @brief cu_dev_fast_binary_euclid
 *
 *	computes the greatest common divisor of a and b using 
 *	fast binary Euclidean algorithm and return the result in r. 
 *	r may be the same BIGNUM as a or b.
 *
 *  @param[in,out] a U_BN number
 *  @param[in,out] b U_BN number
 *  @return r U_BN result of GCD
 */
__host__ __device__ U_BN *cu_dev_fast_binary_euclid(U_BN *a, U_BN *b);

/** @brief cu_dev_classic_euclid
 *
 *	computes the greatest common divisor of a and b using 
 *	Euclidean algorithm and return the result in r. 
 *	r may be the same BIGNUM as a or b.
 *
 *  @param[in,out] a U_BN number
 *  @param[in,out] b U_BN number
 *  @return r U_BN result of GCD
 */
__host__ __device__ U_BN *cu_dev_classic_euclid(U_BN *a, U_BN *b);

/** @brief OpenSSL_GCD
 *
 *	computes the greatest common divisor using OpenSSL
 *
 *  @param[in] number_of_keys 
 *  @param[in] key_size
 *  @param[in] keys_directory name of directory containg public keys
 *  @return r U_BN result of GCD
 */
void OpenSSL_GCD(unsigned number_of_keys, unsigned key_size, char *keys_directory);

/** @brief orgEuclideanKernel
 *
 *	computes the greatest common divisor of a and b using 
 *	Euclidean algorithm and return the result in r. 
 *	r may be the same BIGNUM as a or b.
 *
 *  @param[in,out] A U_BN array
 *  @param[in,out] B U_BN array
 *  @param[in,out] C U_BN array
 *  @param[in,out] n A, B, C size 
 *  @return Void
 */
__global__ void orgEuclideanKernel(U_BN *A, U_BN *B, U_BN *C, unsigned n);

/** @brief binEuclideanKernel
 *
 *	computes the greatest common divisor of a and b using 
 *	binary Euclidean algorithm and return the result in r. 
 *	r may be the same BIGNUM as a or b.
 *
 *  @param[in,out] A U_BN array
 *  @param[in,out] B U_BN array
 *  @param[in,out] C U_BN array
 *  @param[in,out] n A, B, C size 
 *  @return Void
 */
__global__ void binEuclideanKernel(U_BN *A, U_BN *B, U_BN *C, unsigned n);

/** @brief orgEuclideanKernel
 *
 *	computes the greatest common divisor of a and b using 
 *	fast binary Euclidean algorithm and return the result in r. 
 *	r may be the same BIGNUM as a or b.
 *
 *  @param[in,out] A U_BN array
 *  @param[in,out] B U_BN array
 *  @param[in,out] C U_BN array
 *  @param[in,out] n A, B, C size 
 *  @return Void
 */
__global__ void fastBinaryKernel(U_BN *A, U_BN *B, U_BN *C, unsigned n);

/* TO DO*/
__global__ void orgEuclideanKernel_with_selection(U_BN *A, U_BN *B, U_BN *R, unsigned number_of_comutations, unsigned number_of_keys);
/* TO DO*/
__global__ void binEuclideanKernel_with_selection(U_BN *A, U_BN *B, U_BN *R, unsigned number_of_comutations, unsigned number_of_keys);
/* TO DO*/
__global__ void fastBinaryKernel_with_selection(U_BN *A, U_BN *B, U_BN *R, unsigned number_of_comutations, unsigned number_of_keys);

#endif // #ifndef _DEVICE_CUDA_BIGNUM_H_
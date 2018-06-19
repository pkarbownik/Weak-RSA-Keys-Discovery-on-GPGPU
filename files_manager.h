/** @file files_manager.h
 *  @brief Function that interract with files.
 *
 *	Functions allows working with public keys 
 *	in as pem files.
 *
 *  @author Przemysław Karbownik (pkarbownik)
 */

#ifndef FILES_MANAGER_H
#define FILES_MANAGER_H

#include <openssl/rsa.h>
#include <openssl/pem.h>
#include <openssl/bn.h>
#include "cuda_bignum.h"

/** @brief Print out modulus based on file path  
 *
 *	Print into console modulus from PEM file.
 *
 *  @param Void
 *  @return Void
 */
void print_mod_from_pem_file(char * filePath);

/** @brief Save modulus in U_BN 
 *	
 *	Save modulus from PEM file key in U_BN.
 *
 *  @param Void
 *  @return Void
 */
int get_u_bn_from_mod_PEM(char * filePath, U_BN* bignum);

#endif /* CUDA_BIGNUM_H */
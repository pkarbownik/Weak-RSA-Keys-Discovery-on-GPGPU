/** @file test.cu
 *  @brief Unit tests
 *
 *	Functions for testing U_BN data operations
 *
 *  @author Przemysław Karbownik (pkarbownik)
 */


#include "test.h"

void unit_test(void){
	INFO("tests start...\n");
	cu_bn_new_test();
	Hw_test();
	Lw_test();
	cu_bn_mul_words_test();
	cu_bn_mul_word_test();
	cu_bn_set_word_test();
	cu_bn_add_word_test();
	cu_bn_dec2bn_test();
	cu_bn_bn2hex_test();
	cu_bn_ucmp_test();
	cu_long_abs_test();
	cu_bn_usub_test();
	cu_bn_usub_optimized_test();
	cu_bn_num_bits_word_test();
	cu_bn_num_bits_test();
	//string_num_add_test();
	number_of_digits_test();
	//long2string_test();
	//string_num_add_long_test();
	//cu_bn_rshift1_test();
	//cu_bn_lshift_test();
	cu_binary_gcd_test();
	//bignum2u_bn_test();
	get_u_bn_from_mod_PEM_test();
	cu_fast_binary_euclid_test();
	cu_classic_euclid_test();
	cu_ubn_copy_test();
	cu_ubn_uadd_test();
	cu_ubn_add_words_test();
	//algorithm_PM_test();
	//q_algorithm_PM_test();
	INFO("tests completed\n");
}

void cu_bn_new_test(void){
	U_BN *bn = NULL;
	unsigned i;
	for (i=0; i<100; i++){
		bn = cu_bn_new();
		cu_bn_free(bn);
	}
}

void Hw_test(void){
	assert(10 == Hw(42949672988));
	INFO("Test passed\n");
}

void Lw_test(void){
	assert(28 == Lw(42949672988));
	INFO("Test passed\n");
}

void cu_bn_mul_words_test(void){
	unsigned w = 4294967295;
	unsigned *ap = ((unsigned*)malloc(100*sizeof(unsigned)));
	unsigned *rp = ((unsigned*)malloc(101*sizeof(unsigned)));
	unsigned i;
	for(i=0; i<100; i++){
		ap[i]=4294967295;
	}
	rp[100]=cu_bn_mul_words(rp, ap, 100, w);
	assert(4294967294 == rp[100]);
	assert(1 == rp[0]);
	for(i=1; i<100; i++){
		assert(4294967295 == rp[i]);
	}
	free(ap);
	free(rp);	
	INFO("Test passed\n");
}

void cu_bn_mul_word_test(void){
	unsigned i;
	U_BN   *A = NULL;
	A = cu_bn_new();
	unsigned w = 4294967295;
	A->top=100;
	A->d = ((unsigned*)malloc(A->top * sizeof(unsigned)));
	for(i=0; i<A->top; i++){
		A->d[i] = 4294967295;
	}
	assert(1==cu_bn_mul_word(A, w));
	assert(1 == A->d[0]);
	assert(101 == A->top);
	assert(4294967294 == A->d[100]);
	cu_bn_free(A);
	INFO("Test passed\n");
}

void cu_bn_set_word_test(void){
	U_BN   *A = NULL;
	A = cu_bn_new();
	unsigned w = 0;
	A->top=2;
	A->d = ((unsigned*)malloc(A->top*sizeof(unsigned)));
	A->d[0] = 1;
	A->d[1] = 1;
	assert(1==cu_bn_set_word(A, w));
	assert(w == A->d[0]);
	assert(1 == A->top);
	cu_bn_free(A);
	INFO("Test passed\n");
}
void cu_bn_add_word_test(void){
	unsigned i;
	U_BN   *A = NULL;
	A = cu_bn_new();
	A->top=100;
	A->d = ((unsigned*)malloc(A->top*sizeof(unsigned)));
	unsigned w = 4294967295;
	for(i=0; i<A->top; i++){
		A->d[i] = 4294967295;
	}
	assert(1==cu_bn_add_word(A, w));
	assert(4294967294 == A->d[0]);
	for(i=1; i<100; i++){
		assert(0 == A->d[i]);
	}
	assert(1 == A->d[100]);
	cu_bn_free(A);
	INFO("Test passed\n");
}


void cu_bn_dec2bn_test(void){
	U_BN   *A = NULL;
	unsigned i;
	A = cu_bn_new();
	assert(1==cu_bn_dec2bn(A, "32317006071311007300714876688669951960"\
		"4441026697154840321303454275246551388678908931972014115229134"\
		"6368871796092189801949411955915049092109508815238644828312063"\
		"0877367300996091750197750389652106796057638384067568276792218"\
		"6426197561618380943384761704705816458520363050428875758915410"\
		"6580860755239912393038552191433338966834242068497478656456949"\
		"4856176035326322058077805659331026192708460314150258592864177"\
		"1167259436037184618573575983511523016459044036976132332872312"\
		"2712568471082020972515710172693132346967854258065669793504599"\
		"7268352998638215525166389437335543602135433229604645318478604"\
		"952148193555853611059596230656")); //2^2048
	for(i=0; i<64; i++){
		assert(0 ==A->d[i]);
	}
	assert(1 ==A->d[64]);
	cu_bn_free(A);
	INFO("Test passed\n");
}

void cu_bn_bn2hex_test(void){ 
	U_BN   *A = NULL;
	A = cu_bn_new();
	assert(1==cu_bn_dec2bn(A, "127443773749521740448985064835572871821497258320008925264518297348975527574330581823678917711811966132450236776705531598591537821175218567383336289986769851757919421857153566027389171722437841965806707802420698885993409903878055377635362821711101383838163609674216891593551006179966415573764558448444491910741"));
	assert(!strcmp("B57C67BE98C25867E0439BBE80836E5B5DC041A40064199A674299D24E8704B82432A79FE534D545745D1096235150B9F1A0AFA90FC54406AC51FB3918B187FD886CD43F33842D6BDB1602097543E2C65683DFFD58EBE7920DF7C23AC0A827503FF0310B31B8D075B168C5FAA3F4055153771D47401AB8BE0EF613F3D0DF4E55", cu_bn_bn2hex(A)));
	cu_bn_free(A);
	INFO("Test passed\n");
}

void cu_bn_ucmp_test(void){
	U_BN   *A = NULL, *B = NULL;
	A = cu_bn_new();
	B = cu_bn_new();
	assert(1 == cu_bn_dec2bn(A, "1848764767645778788"));
	assert(1 == cu_bn_dec2bn(B, "1848764767645778788"));
	assert(0 == cu_bn_ucmp(A, B));
	cu_bn_free(A);
	cu_bn_free(B);
	INFO("Test passed\n");
}

void cu_long_abs_test(void){
	assert(2147483649999L == cu_long_abs(-2147483649999L));
	assert(2147483649999L == cu_long_abs(2147483649999L));
	INFO("Test passed\n");
}



void cu_bn_usub_test(void){
	U_BN   *A = NULL, *B = NULL;
	U_BN   *C = NULL;
	int i=0;
	A = cu_bn_new();
	B = cu_bn_new();
	C = cu_bn_new();
	cu_bn_dec2bn(A, "136269636317215868658126726142543242028128679787201513621377420299644359247151157885793577216543689892988935986714087409150506883630386841292060595217129497897100280678153687017820663980404875865314501020301179267627899307057160787226214936662085381326053730017478234531591680965138499420169342895677786825703");
	cu_bn_dec2bn(B, "136269636317215868658126726142543242028128679787201513621377420299644359247151157885793577216543689892988935986714087409150506883630386841292060595217129497897100280678153687017820663980404875865314501020301179267627899307057160787226214936662085381326053730017478234531591680965138499420169342895677786825702");
	cu_bn_dec2bn(C, "136269636317215868658126726142543242028128679787201513621377420299644359247151157885793577216543689892988935986714087409150506883630386841292060595217129497897100280678153687017820663980404875865314501020301179267627899307057160787226214936662085381326053730017478234531591680965138499420169342895677786825702");
	clock_t start = clock();
	assert(1 == cu_bn_usub(A, B, C));
	clock_t stop = clock();
    double elapsed = (double)(stop - start) * 1000.0 / CLOCKS_PER_SEC;
    INFO("[CPU - usub] Time elapsed in ms: %f\n", elapsed);
	assert(!strcmp("1", cu_bn_bn2hex(C)));
	cu_bn_free(A);
	cu_bn_free(B);
	cu_bn_free(C);
	INFO("Test passed\n");
} 

void cu_bn_usub_optimized_test(void){
	U_BN   *A = NULL, *B = NULL;
	U_BN   *C = NULL;
	A = cu_bn_new();
	B = cu_bn_new();
	C = cu_bn_new();
	cu_bn_dec2bn(A, "136269636317215868658126726142543242028128679787201513621377420299644359247151157885793577216543689892988935986714087409150506883630386841292060595217129497897100280678153687017820663980404875865314501020301179267627899307057160787226214936662085381326053730017478234531591680965138499420169342895677786825703");
	cu_bn_dec2bn(B, "136269636317215868658126726142543242028128679787201513621377420299644359247151157885793577216543689892988935986714087409150506883630386841292060595217129497897100280678153687017820663980404875865314501020301179267627899307057160787226214936662085381326053730017478234531591680965138499420169342895677786825702");
	cu_bn_dec2bn(C, "136269636317215868658126726142543242028128679787201513621377420299644359247151157885793577216543689892988935986714087409150506883630386841292060595217129497897100280678153687017820663980404875865314501020301179267627899307057160787226214936662085381326053730017478234531591680965138499420169342895677786825702");
	clock_t start = clock();
	assert(1 == cu_bn_usub_optimized(A, B, C));
	clock_t stop = clock();
    double elapsed = (double)(stop - start) * 1000.0 / CLOCKS_PER_SEC;
    INFO("[CPU - usub] Time elapsed in ms: %f\n", elapsed);
	assert(!strcmp("1", cu_bn_bn2hex(C)));
	cu_bn_free(A);
	cu_bn_free(B);
	cu_bn_free(C);
	INFO("Test passed\n");
}

void cu_bn_num_bits_word_test(void){
	assert(16 == cu_bn_num_bits_word(0b1111000011110000));
	INFO("Test passed\n");
} 

void cu_bn_num_bits_test(void){
	U_BN   *A = NULL;
	A = cu_bn_new();
	assert(1 == cu_bn_dec2bn(A, "1848764763497967886363755645778788"));
	assert(111 == cu_bn_num_bits(A));
	cu_bn_free(A);
	INFO("Test passed\n");
} 

void string_num_add_test(void){
	assert(!strcmp("37558289099012189180223099189280269177576", \
	string_num_add("37556443534534534534577453543634634638788", "1845564477654645645645645645634538788")));
	INFO("Test passed\n");
}

void number_of_digits_test(void){
	assert(9 == number_of_digits(123456789));
	INFO("Test passed\n");
} 

void long2string_test(void){
	assert(!strcmp("123456789", long2string(123456789)));
	INFO("Test passed\n");
}

void string_num_add_long_test(void)
{
	assert(!strcmp("37556443534534534534577455389199112293433", \
	string_num_add_long("37556443534534534534577453543634634638788", 1845564477654645)));
	INFO("Test passed\n");
}

void cu_bn_rshift1_test(void){
	U_BN   *W = NULL;
	BIGNUM* ref = NULL;
	W = cu_bn_new();
	ref = BN_new();
	assert(1 == cu_bn_dec2bn(W, "1362696363172158686581267261425432420281286797872015136213774202996443592471511578857935772165436898929889359867140"));
	assert(1 < BN_dec2bn(&ref, "1362696363172158686581267261425432420281286797872015136213774202996443592471511578857935772165436898929889359867140"));
	assert(1 == cu_bn_rshift1(W));
	assert(1 == BN_rshift1(ref, ref));
	INFO("rshift_BIGNUM: %s\n", BN_bn2hex(ref));
	INFO("rshift_U_BN: %s\n", cu_bn_bn2hex(W));
	assert(!strcmp(BN_bn2hex(ref), cu_bn_bn2hex(W)));
	cu_bn_free(W);
	BN_free(ref);
	INFO("Test passed\n");
}

void cu_bn_lshift_test(void){
	U_BN   *W = NULL;
	BIGNUM* ref = NULL;
	W = cu_bn_new();
	ref = BN_new();
	assert(1 == cu_bn_dec2bn(W, "136269636317215868658126726142543242028128679787201513621377420299644359247151157885793577216543689892988935986714087409150506883630386841292060595217129497897100280678153687017820663980404875865314501020301179267627899307057160787226214936662085381326053730017478234531591680965138499420169342895677786825703"));
	assert(1 < BN_dec2bn(&ref, "136269636317215868658126726142543242028128679787201513621377420299644359247151157885793577216543689892988935986714087409150506883630386841292060595217129497897100280678153687017820663980404875865314501020301179267627899307057160787226214936662085381326053730017478234531591680965138499420169342895677786825703"));
	assert(1 == cu_bn_lshift(W, 10));
	assert(1 == BN_lshift(ref, ref, 10));
	INFO("lshift_BIGNUM: %s\n", BN_bn2hex(ref));
	INFO("lshift_U_BN: %s\n", cu_bn_bn2hex(W));
	assert(!strcmp(BN_bn2hex(ref), cu_bn_bn2hex(W)));
	cu_bn_free(W);
	BN_free(ref);
	INFO("Test passed\n");
}

void cu_binary_gcd_test(void){
	U_BN   *A = NULL, *B = NULL;
	BIGNUM *A_bn = NULL, *B_bn = NULL;
	unsigned L=5, N=1; 

	A = cu_bn_new();
	B = cu_bn_new();
	A_bn = BN_new();
	B_bn = BN_new();

    assert(1 == cu_bn_dec2bn(A, "139646679005515842574936981204093845234015477199448080618173487964307244013023085128583197111630542490544238833330384988922749579827248789672128374708926982083208967144764090761687656412100792950654957926632851725398402843385546657630803564543021143148692573369062732915509019257416230830566196883330075238963"));
    assert(1 == cu_bn_dec2bn(B, "146162993582921807381683018088111565603506954189468271998863032884583087668828227517021359570023475466312440293312149400604293079119484342586683406361798758744709100580799775832717040923452131314993043044025196060906900080741305825223288577054565664034331863477512214203449815958698517366890485107227899018643"));
    assert(1 < BN_dec2bn(&A_bn, "139646679005515842574936981204093845234015477199448080618173487964307244013023085128583197111630542490544238833330384988922749579827248789672128374708926982083208967144764090761687656412100792950654957926632851725398402843385546657630803564543021143148692573369062732915509019257416230830566196883330075238963"));
    assert(1 < BN_dec2bn(&B_bn, "146162993582921807381683018088111565603506954189468271998863032884583087668828227517021359570023475466312440293312149400604293079119484342586683406361798758744709100580799775832717040923452131314993043044025196060906900080741305825223288577054565664034331863477512214203449815958698517366890485107227899018643"));

    BN_CTX *ctx;
    ctx = BN_CTX_new();
    BIGNUM *r;
    r=BN_new();
    BN_gcd(r, A_bn, B_bn, ctx);
    BN_CTX_free(ctx);


    clock_t start = clock();
    A = cu_binary_gcd(A, B);
    clock_t stop = clock();
    double elapsed = (double)(stop - start) * 1000.0 / CLOCKS_PER_SEC;
    INFO("[CPU] Time elapsed in ms: %f\n", elapsed);
	assert(!strcmp(BN_bn2hex(r), cu_bn_bn2hex(A)));
	BN_free(A_bn);
	BN_free(B_bn);
    BN_free(r);
    INFO("Test passed\n");
}

void cu_fast_binary_euclid_test(void){
	U_BN   *A = NULL, *B = NULL;
	BIGNUM *A_bn = NULL, *B_bn = NULL;

	A = cu_bn_new();
	B = cu_bn_new();
	A_bn = BN_new();
	B_bn = BN_new();

    assert(1 == cu_bn_dec2bn(A, "139646679005515842574936981204093845234015477199448080618173487964307244013023085128583197111630542490544238833330384988922749579827248789672128374708926982083208967144764090761687656412100792950654957926632851725398402843385546657630803564543021143148692573369062732915509019257416230830566196883330075238963"));
    assert(1 == cu_bn_dec2bn(B, "146162993582921807381683018088111565603506954189468271998863032884583087668828227517021359570023475466312440293312149400604293079119484342586683406361798758744709100580799775832717040923452131314993043044025196060906900080741305825223288577054565664034331863477512214203449815958698517366890485107227899018643"));
    assert(1 < BN_dec2bn(&A_bn, "139646679005515842574936981204093845234015477199448080618173487964307244013023085128583197111630542490544238833330384988922749579827248789672128374708926982083208967144764090761687656412100792950654957926632851725398402843385546657630803564543021143148692573369062732915509019257416230830566196883330075238963"));
    assert(1 < BN_dec2bn(&B_bn, "146162993582921807381683018088111565603506954189468271998863032884583087668828227517021359570023475466312440293312149400604293079119484342586683406361798758744709100580799775832717040923452131314993043044025196060906900080741305825223288577054565664034331863477512214203449815958698517366890485107227899018643"));

    BN_CTX *ctx;
    ctx = BN_CTX_new();
    BIGNUM *r;
    r=BN_new();
    BN_gcd(r, A_bn, B_bn, ctx);
    BN_CTX_free(ctx);


    clock_t start = clock();
    A = cu_fast_binary_euclid(A, B);
    clock_t stop = clock();
    double elapsed = (double)(stop - start) * 1000.0 / CLOCKS_PER_SEC;
    INFO("[CPU] Time elapsed in ms: %f\n", elapsed);
	assert(!strcmp(BN_bn2hex(r), cu_bn_bn2hex(A)));	
	BN_free(A_bn);
	BN_free(B_bn);
    BN_free(r);
    INFO("Test passed\n");
}

void cu_classic_euclid_test(void){
	U_BN   *A = NULL, *B = NULL;
	BIGNUM *A_bn = NULL, *B_bn = NULL;
	unsigned L=5, N=1; 

	A = cu_bn_new();
	B = cu_bn_new();
	A_bn = BN_new();
	B_bn = BN_new();

    assert(1 == cu_bn_dec2bn(A, "139646679005515842574936981204093845234015477199448080618173487964307244013023085128583197111630542490544238833330384988922749579827248789672128374708926982083208967144764090761687656412100792950654957926632851725398402843385546657630803564543021143148692573369062732915509019257416230830566196883330075238963"));
    assert(1 == cu_bn_dec2bn(B, "146162993582921807381683018088111565603506954189468271998863032884583087668828227517021359570023475466312440293312149400604293079119484342586683406361798758744709100580799775832717040923452131314993043044025196060906900080741305825223288577054565664034331863477512214203449815958698517366890485107227899018643"));
    assert(1 < BN_dec2bn(&A_bn, "139646679005515842574936981204093845234015477199448080618173487964307244013023085128583197111630542490544238833330384988922749579827248789672128374708926982083208967144764090761687656412100792950654957926632851725398402843385546657630803564543021143148692573369062732915509019257416230830566196883330075238963"));
    assert(1 < BN_dec2bn(&B_bn, "146162993582921807381683018088111565603506954189468271998863032884583087668828227517021359570023475466312440293312149400604293079119484342586683406361798758744709100580799775832717040923452131314993043044025196060906900080741305825223288577054565664034331863477512214203449815958698517366890485107227899018643"));

    BN_CTX *ctx;
    ctx = BN_CTX_new();
    BIGNUM *r;
    r=BN_new();
    BN_gcd(r, A_bn, B_bn, ctx);
    BN_CTX_free(ctx);


    clock_t start = clock();
    A = cu_classic_euclid(A, B);
    clock_t stop = clock();
    double elapsed = (double)(stop - start) * 1000.0 / CLOCKS_PER_SEC;
    INFO("[CPU] Time elapsed in ms: %f\n", elapsed);
	//INFO("%s=%s\n", BN_bn2hex(r), cu_bn_bn2hex(A));
	assert(!strcmp(BN_bn2hex(r), cu_bn_bn2hex(A)));	
	BN_free(A_bn);
	BN_free(B_bn);
    BN_free(r);
    INFO("Test passed\n");
}

void bignum2u_bn_test(void){
	BIGNUM *bn;
	U_BN *u_bn;
	bn = BN_new();
	u_bn = cu_bn_new();
	assert( 0 < BN_dec2bn(&bn, "54635484657846634") );
	assert( 1 == bignum2u_bn(bn, u_bn) );
	assert(!strcmp("C21AAF0F29896A", cu_bn_bn2hex(u_bn)));
	cu_bn_free(u_bn);
	BN_free(bn);
	INFO("Test passed\n");

}

void get_u_bn_from_mod_PEM_test(void){

	U_BN *u_bn = NULL;

	u_bn = cu_bn_new();
	assert( 1 == get_u_bn_from_mod_PEM("keys_and_messages/1.pem", u_bn));
	cu_bn_free(u_bn);
	INFO("Test passed\n");
}

void  cu_ubn_copy_test(void){
	U_BN   *A = NULL, *B = NULL;
	A = cu_bn_new();
	B = cu_bn_new();
	cu_bn_dec2bn(A, "136269636317215868658126726142543242028128679787201513621377420299644359247151157885793577216543689892988935986714087409150506883630386841292060595217129497897100280678153687017820663980404875865314501020301179267627899307057160787226214936662085381326053730017478234531591680965138499420169342895677786825703");
	cu_bn_dec2bn(B, "153687017820663980404875865314501020301179267627899307057160787226214936662085381326053730017478234531591680965138499420169342895677786825703136269636317215868658126726142543242028128679787201513621377420299644359247151157885793577216543689892988935986714087409150506883630386841292060595217129497897100280678");
	assert( 1 == cu_ubn_copy(A, B));
	assert(!strcmp(cu_bn_bn2hex(A), cu_bn_bn2hex(B)));
	cu_bn_free(A);
	cu_bn_free(B);
	INFO("Test passed\n");
}

void cu_ubn_uadd_test(void){
	U_BN   *A = NULL, *B = NULL;
	A = cu_bn_new();
	B = cu_bn_new();
	cu_bn_dec2bn(A, "127443773749521740448985064835572871821497258320008925264518297348975527574330581823678917711811966132450236776705531598591537821175218567383336289986769851757919421857153566027389171");
	cu_bn_dec2bn(B, "127443773749521740448985064835572871821497258320008925264518297348975527574330581823678917711811966132450236776705531598591537821175218567383336289986769851757919421857153566027389171");
	assert(1 == cu_ubn_uadd(A, B, B));
	assert(!strcmp("3D6D04ECF36DA4AC1E32786F647ECAC3553E24BD9713EB74E14A38FB1B88430C68FDE7EE21C251B44A66D049EE65BC95C7A9D36E503FB0E3B2062D644A99C613EC5D49174489558F03B331E6", cu_bn_bn2hex(B)));
	cu_bn_free(A);
	cu_bn_free(B);
	INFO("Test passed\n");
}


void cu_ubn_add_words_test(void){
	unsigned *ap = ((unsigned*)malloc(100*sizeof(unsigned)));
	unsigned *bp = ((unsigned*)malloc(100*sizeof(unsigned)));
	unsigned *rp = ((unsigned*)malloc(101*sizeof(unsigned)));
	unsigned i;
	for(i=0; i<100; i++){
		ap[i]=4294967295;
		bp[i]=4294967295;
	}
	rp[100]=cu_ubn_add_words(rp, ap, bp, 100);
	assert(1 == rp[100]);
	assert(4294967294 == rp[0]);
	for(i=1; i<100; i++){
		assert(4294967295 == rp[i]);
	}
	free(ap);
	free(bp);
	free(rp);	
	INFO("Test passed\n");
}


void q_algorithm_PM_test(void){
	U_BN   *A = NULL, *B = NULL;
	BIGNUM *A_bn = NULL, *B_bn = NULL;
	unsigned L=5, N=1; 

	A = cu_bn_new();
	B = cu_bn_new();
	A_bn = BN_new();
	B_bn = BN_new();

    assert(1 == cu_bn_dec2bn(A, "139646679005515842574936981204093845234015477199448080618173487964307244013023085128583197111630542490544238833330384988922749579827248789672128374708926982083208967144764090761687656412100792950654957926632851725398402843385546657630803564543021143148692573369062732915509019257416230830566196883330075238963"));
    assert(1 == cu_bn_dec2bn(B, "146162993582921807381683018088111565603506954189468271998863032884583087668828227517021359570023475466312440293312149400604293079119484342586683406361798758744709100580799775832717040923452131314993043044025196060906900080741305825223288577054565664034331863477512214203449815958698517366890485107227899018643"));
    assert(1 < BN_dec2bn(&A_bn, "139646679005515842574936981204093845234015477199448080618173487964307244013023085128583197111630542490544238833330384988922749579827248789672128374708926982083208967144764090761687656412100792950654957926632851725398402843385546657630803564543021143148692573369062732915509019257416230830566196883330075238963"));
    assert(1 < BN_dec2bn(&B_bn, "146162993582921807381683018088111565603506954189468271998863032884583087668828227517021359570023475466312440293312149400604293079119484342586683406361798758744709100580799775832717040923452131314993043044025196060906900080741305825223288577054565664034331863477512214203449815958698517366890485107227899018643"));
    BN_CTX *ctx;
    ctx = BN_CTX_new();
    BIGNUM *r;
    r=BN_new();
    BN_gcd(r, A_bn, B_bn, ctx);
    BN_CTX_free(ctx);

    clock_t start = clock();
    A = q_algorithm_PM(A, B);
    clock_t stop = clock();
    double elapsed = (double)(stop - start) * 1000.0 / CLOCKS_PER_SEC;
    INFO("[CPU] Time elapsed in ms: %f\n", elapsed);
	assert(!strcmp(BN_bn2hex(r), cu_bn_bn2hex(A)));	
	BN_free(A_bn);
	BN_free(B_bn);
    BN_free(r);
    INFO("Test passed\n");
}

void algorithm_PM_test(void){
	U_BN   *A = NULL, *B = NULL;
	BIGNUM *A_bn = NULL, *B_bn = NULL;
	unsigned keysize = 4096;
	unsigned L=5, N=1; 

	A = cu_bn_new();
	B = cu_bn_new();
	A_bn = BN_new();
	B_bn = BN_new();

    assert(1 == cu_bn_dec2bn(A, "139646679005515842574936981204093845234015477199448080618173487964307244013023085128583197111630542490544238833330384988922749579827248789672128374708926982083208967144764090761687656412100792950654957926632851725398402843385546657630803564543021143148692573369062732915509019257416230830566196883330075238963"));
    assert(1 == cu_bn_dec2bn(B, "146162993582921807381683018088111565603506954189468271998863032884583087668828227517021359570023475466312440293312149400604293079119484342586683406361798758744709100580799775832717040923452131314993043044025196060906900080741305825223288577054565664034331863477512214203449815958698517366890485107227899018643"));
    assert(1 < BN_dec2bn(&A_bn, "139646679005515842574936981204093845234015477199448080618173487964307244013023085128583197111630542490544238833330384988922749579827248789672128374708926982083208967144764090761687656412100792950654957926632851725398402843385546657630803564543021143148692573369062732915509019257416230830566196883330075238963"));
    assert(1 < BN_dec2bn(&B_bn, "146162993582921807381683018088111565603506954189468271998863032884583087668828227517021359570023475466312440293312149400604293079119484342586683406361798758744709100580799775832717040923452131314993043044025196060906900080741305825223288577054565664034331863477512214203449815958698517366890485107227899018643"));
    BN_CTX *ctx;
    ctx = BN_CTX_new();
    BIGNUM *r;
    r=BN_new();
    BN_gcd(r, A_bn, B_bn, ctx);
    BN_CTX_free(ctx);

    clock_t start = clock();
    A = algorithm_PM(A, B, keysize);
    clock_t stop = clock();
    double elapsed = (double)(stop - start) * 1000.0 / CLOCKS_PER_SEC;
    INFO("[CPU] Time elapsed in ms: %f\n", elapsed);
	assert(!strcmp(BN_bn2hex(r), cu_bn_bn2hex(A)));	
	BN_free(A_bn);
	BN_free(B_bn);
    BN_free(r);
    INFO("Test passed\n");
}

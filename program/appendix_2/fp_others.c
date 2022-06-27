#include <math.h>
#include <stdint.h>

// float f_sqrt (float in) { return sqrtf(in); }
float f_abs  (float in) { return fabsf(in); }
float f_neg  (float in) { return -in; }

// double d_sqrt (double in) { return sqrt(in); }
double d_abs  (double in) { return fabs(in); }
double d_neg  (double in) { return -in; }

int32_t  cvt_fp_to_sint (float  in) { return ( int32_t)(in); }
uint32_t cvt_fp_to_uint (float  in) { return (uint32_t)(in); }
int32_t  cvt_dp_to_sint (double in) { return ( int32_t)(in); }
uint32_t cvt_dp_to_uint (double in) { return (uint32_t)(in); }

float  cvt_sint_to_fp (int32_t  in) { return (float )(in); }
float  cvt_uint_to_fp (uint32_t in) { return (float )(in); }
double cvt_sint_to_dp (int32_t  in) { return (double)(in); }
double cvt_uint_to_dp (uint32_t in) { return (double)(in); }

float f_sqrt(float k) { return sqrt(k); }

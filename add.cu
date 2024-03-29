#include <iostream>
#include <math.h>
// Kernel function to add the elements of two arrays
__global__
void add(float *x, float *y)
{
    y[blockIdx.x] = x[blockIdx.x] + y[blockIdx.x];
    int a = y[blockIdx.x];
    char b = 0;
}

int main(void)
{
  const int N = 1<<20;
  std::cout << N << std::endl;

  float *x, *y;

  // Allocate Unified Memory – accessible from CPU or GPU
  cudaMallocManaged(&x, N*sizeof(float));
  cudaMallocManaged(&y, N*sizeof(float));

  // initialize x and y arrays on the host
  for (int i = 0; i < N; i++) {
    x[i] = 1.0f;
    y[i] = 2.0f;
  }

  // Run kernel on 1M elements on the GPU
  add<<<1, 1>>>(x, y);

  // Wait for GPU to finish before accessing on host
  cudaDeviceSynchronize();

  // Check for errors (all values should be 3.0f)
  float maxError = 0.0f;
  std::cout << N << std::endl;
  for (int i = 0; i < N; i++) {
    maxError = fmax(maxError, fabs(y[i]-3.0f));
    // std::cout << maxError << std::endl;
  }
  cudaDeviceSynchronize();

  std::cout << "Max error: " << maxError << std::endl;

  char a;
  scanf("%d", &a);

  // Free memory
  cudaFree(x);
  cudaFree(y);
  
  return 0;
}
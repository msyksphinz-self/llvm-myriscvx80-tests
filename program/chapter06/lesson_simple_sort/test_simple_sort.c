#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

#define NUM_ITEMS 10

int select_min_index(int array[], int start_index, int array_size)
{
  int min = start_index;
  for (int j = start_index+1; j < array_size; j++) {
    if (array[j] < array[min]) {
      min = j;
    }
  }
  return min;
}


void simple_sort(int numbers[], int array_size);
int numbers[NUM_ITEMS] = {
 3840 , 11679, 5789 , 14883, 11411,
 8775 , 11607, 4386 , 11391, 24758
};

int main()
{
  int i;

  simple_sort(numbers, NUM_ITEMS);

  for (i = 0; i < NUM_ITEMS; i++) {
    printf("%d\n", numbers[i]);
  }

  return 0;
}

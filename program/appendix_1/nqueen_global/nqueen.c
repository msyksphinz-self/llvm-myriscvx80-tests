// #include <stdio.h>
// #include <string.h>

#include "nqueen.h"

extern int board[N][N];

void print_queen(int queen[N]);

void update_board(int y, int x, int d)
{
  int k;

  for (k = 0; k < N; k++) {
    board[y][k] += d;
    board[k][x] += d;
  }
  if (y > x) {
    for (k = 0; k < N-(y-x); k++) {
      board[k+(y-x)][k] += d;
    }
  } else {
    for (k = 0; k < N-(x-y); k++) {
      board[k][k+(x-y)] += d;
    }
  }
  if (y+x < N) {
    for (k = 0; k <= x+y; k++) {
      board[y+x-k][k] += d;
    }
  } else {
    for (k = y+x-N+1; k < N; k++) {
      board[y+x-k][k] += d;
    }
  }
}

void put_queen(int queen[N], int y)
{

  for (int x = 0; x < N; x++) {
    if (board[y][x] == 0) {
      queen[y] = x + 1;
      if (y == N-1) {
        print_queen(queen);
      } else {
        update_board(y, x, +1);
        print_queen(queen);
        put_queen(queen, y+1);
        update_board(y, x, -1);
      }
    }
  }
}

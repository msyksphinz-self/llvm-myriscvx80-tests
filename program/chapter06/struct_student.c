struct Student
{
  int no;
  char name[20];
  unsigned int score;
};


int update_score (int student_no, int score)
{
  struct Student taro = {32, "Taro Yamada", 95};
  int no = taro.no; // Dummy code

  if (student_no == no) {
    taro.score += score; // Update struct.score
  }

  return taro.score;
}

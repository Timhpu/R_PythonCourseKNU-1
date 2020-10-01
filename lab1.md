**1. Створити змінні базових (atomic) типів. Базові типи: character, numeric,
integer, complex, logical.**

for (v in list("character", 1, 1L, 1+1i, TRUE))
{
  val <- v
  print(typeof(val))
}

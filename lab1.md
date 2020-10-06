**1. Створити змінні базових (atomic) типів. Базові типи: character, numeric, integer, complex, logical.**

```{r}
for (v in list("1", 1, 1L, 1+1i, TRUE))
{
  val <- v  # creation of the variable
  print(typeof(val))
}
```

**2. Створити вектори, які: містить послідовність з 5 до 75; містить числа 3.14, 2.71, 0, 13; 100 значень TRUE.**

```{r}
for (v in list(c(5:75), c(3.14, 2.71, 0, 13), rep(TRUE, 100)))
{
  val <- v
  print(val)
  print(is.vector(val))
}
```

**3. Створити наступну матрицю за допомогою matrix, та за допомогою cbind або rbind**

```{r}
val <- matrix(c(0.5, 3.9, 0, 1.3, 131, 2.2), nrow=3, ncol=2)
val <- rbind(val, c(2, 7))  # adding one row on the bottom
val <- cbind(val, c(3.5, 2.8, 4.6, 5.1))  # addind one column on the right
print(val)
```

**4. Створити довільний список (list), в який включити всі базові типи.**

```{r}
val <- list("1", 1, 1L, 1+1i, TRUE)
for (v in val) print(typeof(v))
```

**5. Створити фактор з трьома рівнями «baby», «child», «adult».**

```{r}
val <- factor(c("adult", "child", "baby", "baby", "child", "adult", "adult", "baby", "child", "baby"), levels=c("baby", "child", "adult"))
print(val)
print(table(val))
print(unclass(val))
```

**6. Знайти індекс першого значення NA в векторі 1, 2, 3, 4, NA, 6, 7, NA, 9, NA, 11. Знайти кількість значень NA.**

```{r}
val <- c(1, 2, 3, 4, NA, 6, 7, NA, 9, NA, 11)
print(match(NA, val))
print(sum(is.na(val)))
```

**7. Створити довільний data frame та вивести в консоль.**

```{r}
val <- data.frame(city=c("New York", "Tokyo", "Berlin"), people=c(8336817, 13929280, 3769495))
print(val)
```

**8. Змінити імена стовпців цього data frame.**

```{r}
val <- data.frame(city=c("New York", "Tokyo", "Berlin"), people=c(8336817, 13929280, 3769495))
names(val) <- c("City", "Population")
print(val)
```

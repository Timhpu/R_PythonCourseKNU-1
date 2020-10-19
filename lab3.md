**1. Функція add2(x, y), яка повертає суму двох чисел.**
```{r}
add2 <- function(x, y) {
  return(x+y)
}
```

**Result:**
```
> add2(5, -3)
[1] 2
```

**2. Функція above(x, n), яка приймає вектор та число n, та повертає всі елементи вектору, які більше n. По замовчуванню n = 10.**
```{r}
above <- function(x, n=10) {
  return(x[x>n])
}
```

**Result:**
```
> above(c(5:15))
[1] 11 12 13 14 15
```

**3. Функція my_ifelse(x, exp, n), яка приймає вектор x, порівнює всі його елементи за допомогою exp з n, та повертає елементи вектору, які відповідають умові expression. Наприклад, my_ifelse(x, “>”, 0) повертає всі елементи x, які більші 0. Exp може дорівнювати “<”, “>”, “<=”, “>=”, “==”. Якщо exp не співпадає ні з одним з цих виразів, повертається вектор x.**
```{r}
my_ifelse <- function(x, exp, n) {
  if (!is.element(exp, c("<", ">", "<=", ">=", "=="))) return(x)
  code <- paste("x[x", exp, "n]")
  return(eval(parse(text=code)))
}
my_ifelse(c(1:5), ">=", 4)
my_ifelse(c(1:5), "more than", 4)
my_ifelse(c(1:5, NA, 50, Inf), ">=", 4)
```

**Result:**
```
> my_ifelse(c(1:5), ">=", 4)
[1] 4 5
> my_ifelse(c(1:5), "more than", 4)
[1] 1 2 3 4 5
> my_ifelse(c(1:5, NA, 50, Inf), ">=", 4)
[1]   4   5  NA  50 Inf
```

**4. Функція columnmean(x, removeNA), яка розраховує середнє значення (mean) по кожному стовпцю матриці, або data frame. Логічний параметр removeNA вказує, чи видаляти NA значення. По замовчуванню він дорівнює TRUE.**
```{r}
columnmean <- function(x, removeNA) {
  for(i in 1:ncol(x))
  {
    print(mean(x[,i], na.rm=removeNA))
  }
}
x <- data.frame(a=rnorm(10), b=(4:8), c=c(0, NA))
columnmean(x, FALSE)
columnmean(x, TRUE)
m <- matrix(c(1:5, NA), nrow=2, ncol=3)
columnmean(m, TRUE)
columnmean(m, FALSE)
```

**Result:**
```
> x <- data.frame(a=rnorm(10), b=(4:8), c=c(0, NA))
> columnmean(x, FALSE)
[1] -0.03178073
[1] 6
[1] NA
> columnmean(x, TRUE)
[1] -0.03178073
[1] 6
[1] 0
> m <- matrix(c(1:5, NA), nrow=2, ncol=3)
> columnmean(m, TRUE)
[1] 1.5
[1] 3.5
[1] 5
> columnmean(m, FALSE)
[1] 1.5
[1] 3.5
[1] NA
```

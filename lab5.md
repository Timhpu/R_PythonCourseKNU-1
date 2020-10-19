**Для цій роботи необхідно додати на Github файл pmean.R, який містить усі функції. В файлі md необхідно указати виклик функції з аргументами та вивід у консоль результатів роботи функцій.**
```{r}
source("C:/Users/User/Documents/pmean.r")
```
**1. Написати функцію pmean, яка обчислює середнє значення (mean) забруднення сульфатами або нітратами серед заданого переліка моніторів.**
```{r}
pmean("specdata", "sulfate", 1:10)
pmean("specdata", "sulfate", 55)
pmean("specdata", "nitrate")
```
**Result:**
```
> pmean("specdata", "sulfate", 1:10)
[1] 4.064128
> pmean("specdata", "sulfate", 55)
[1] 3.587319
> pmean("specdata", "nitrate")
[1] 1.702932
```
**2. Написати функцію complete, яка виводить кількість повних спостережень (the number of completely observed cases) для кожного файлу.**
```{r}
complete("specdata", 1)
complete("specdata", c(2, 4, 8, 10, 12))
complete("specdata", 50:60)
```
**Result:**
```
> complete("specdata", 1)
  X.id. X.nobs.
1    id    nobs
2     1     117
> complete("specdata", c(2, 4, 8, 10, 12))
  X.id. X.nobs.
1    id    nobs
2     2    1041
3     4     474
4     8     192
5    10     148
6    12      96
> complete("specdata", 50:60)
   X.id. X.nobs.
1     id    nobs
2     50     459
3     51     193
4     52     812
5     53     342
6     54     219
7     55     372
8     56     642
9     57     452
10    58     391
11    59     445
12    60     448
```
**3. Написати функцію corr, яка приймає два аргументи: directory (папка, де знаходяться файли спостережень) та threshold (порогове значення, за замовчуванням дорівнює 0) та обчислює кореляцію між сульфатами та нітратами для моніторів, кількість повних спостережень для яких більше порогового значення.**
```{r}
cr<-corr("specdata", 150)
head(cr); summary(cr)
cr <- corr("specdata", 400)
head(cr); summary(cr)
cr <- corr("specdata", 5000)
head(cr); summary(cr) ; length(cr)
```
**Result:**
```
> cr<-corr("specdata", 150)
> head(cr); summary(cr)
[1] -0.01895754 -0.14051254 -0.04389737 -0.06815956 -0.12350667 -0.07588814
    Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
-0.21057 -0.04999  0.09463  0.12525  0.26844  0.76313 
> cr <- corr("specdata", 400)
> head(cr); summary(cr)
[1] -0.01895754 -0.04389737 -0.06815956 -0.07588814  0.76312884 -0.15782860
    Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
-0.17623 -0.03109  0.10021  0.13969  0.26849  0.76313 
> cr <- corr("specdata", 5000)
> head(cr); summary(cr) ; length(cr)
NULL
Length  Class   Mode 
     0   NULL   NULL 
[1] 0
```
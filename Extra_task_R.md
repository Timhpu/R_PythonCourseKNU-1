**Напишіть функцію prepare_set <- function(file_name) {} яка в якості аргументу приймає ім’я файлу і повертає дата фрейм. Збережіть цей дата фрейм в змінну olympics**

```{r}
install.packages('stringr')
library('stringr')

prepare_set <- function(path) {
  df <- read.csv(path, skip=1, header=TRUE, encoding='UTF-8', stringsAsFactors=FALSE)
  colnames(df)[1] <- "Country"
  for(n in 1:ncol(df))
  {
    name <- colnames(df)[n]
    name <- str_replace(name, 'X01..', 'Gold')
    name <- str_replace(name, 'X02..', 'Silver')
    name <- str_replace(name, 'X03..', 'Bronze')
    name <- str_replace(name, 'X..', '')
    colnames(df)[n] <- name
  }
  for(row in 1:nrow(df))
  {
    country <- df[row, 'Country']
    
    country_id <- str_split(country, "[(]")[[1]][2]
    country_id <- str_split(country_id, "[)]")[1]
    df[row, 'ID'] <- country_id
    
    country <- str_split(country, "[(]")[[1]][1]
    gsub("^\\s*", "", country)
    gsub("\\s*$", "", country)
    df[row, 'Country'] <- country
  }
  df <- df[-(nrow(df)), ]
  return(df)
}
olympics <- prepare_set('olympics.csv')
```

**Result:**
```
> head(olympics)
       Country Summer Gold Silver Bronze Total Winter Gold.1 Silver.1 Bronze.1 Total.1 Games Gold.2 Silver.2 Bronze.2 Combined.total  ID
1 Afghanistan      13    0      0      2     2      0      0        0        0       0    13      0        0        2              2 AFG
2     Algeria      12    5      2      8    15      3      0        0        0       0    15      5        2        8             15 ALG
3   Argentina      23   18     24     28    70     18      0        0        0       0    41     18       24       28             70 ARG
4     Armenia       5    1      2      9    12      6      0        0        0       0    11      1        2        9             12 ARM
5 Australasia       2    3      4      5    12      0      0        0        0       0     2      3        4        5             12 ANZ
6   Australia      25  139    152    177   468     18      5        3        4      12    43    144      155      181            480 AUS
```

**1. Котра країна виграла найбільшу кількість золотих нагород на літніх іграх? Функція повинна повернути одне текстове значення.**
```{r}
task1 <- function() {
  return(olympics[which.max(olympics[['Gold']]), 'Country'])
}
task1()
```

**Result:**
```
> task1()
[1] "United States "
```

**2. Яка країна має найбільшу різницю між кількістю нагород на літніх та зимових іграх? Функція повинна повернути одне текстове значення.**
```{r}
task2 <- function() {
  return(olympics[which.max(olympics[['Gold']] - olympics[['Gold.1']]), 'Country'])
}
task2()
```

**Result:**
```
> task2()
[1] "United States "
```

**3. В якій крайні найбільша різниця між літніми та зимовими золотими нагородами відносно до загальної кількості нагород (Summer Gold - Winter Gold) / Total Gold. Врахувати тільки країни які мають як мінімум по одній нагороді в літніх та зимових іграх. Функція повинна повернути одне текстове значення.**
```{r}
task3 <- function() {
  olympics_filtered <- olympics[olympics['Gold'] > 0 & olympics['Gold.1'] > 0, ]
  return(olympics_filtered[which.max((olympics_filtered[['Gold']] - olympics_filtered[['Gold.1']]) / olympics_filtered[['Gold.2']]), 'Country'])
}
task3()
```

**Result:**
```
> task3()
[1] "Bulgaria "
```

**4. Необхідно знайти кількість балів по кожній крайні. Бали рахуються наступним чином: Золота нагорода Gold.2 це три бали, срібна Silver.2 - 2 бали та бронзова Bronze.2 – 1 бал. Функція повинна повертати дата фрейм довжиною 146, який складається з двох колонок: "Country", "Points".**
```{r}
task4 <- function() {
  return(data.frame('Country'=olympics[['Country']], 'Points'=olympics[['Gold.2']]*3 + olympics[['Silver.2']]*2 + olympics[['Bronze.2']]))
}
task4()
```

**Result:**
```
> task4()
                              Country Points
1                        Afghanistan       2
2                            Algeria      27
3                          Argentina     130
4                            Armenia      16
5                        Australasia      22
...
145                         Zimbabwe      18
146                       Mixed team      38
```

**Для наступних питань використаємо дані перепису населення від United States Census Bureau. (...) Файл необхідно завантажити в змінну census_df.**
```{r}
census_df <- read.csv("census.csv", stringsAsFactors = FALSE)
```

**5. В якому штаті (state) більше всього округів (county)? Функція повинна повернути одне текстове значення**
```{r}
task5 <- function() {
  states <- aggregate(COUNTY ~ STNAME, census_df, FUN=length)
  return(states[which.max(states[['COUNTY']]), 'STNAME'])
}
task5()
```

**Result:**
```
> task5()
[1] "Texas"
```

**6. Якщо розглядати три найбільш населених округа (county) з кожного штату, які три найбільш населені штати (в порядку з більш до менш населеного)? Використовуйте CENSUS2010POP. Функція повинна повернути вектор з трьох текстових значень.**
```{r}
task6 <- function() {
  states <- aggregate(CENSUS2010POP ~ STNAME, census_df, FUN=function(x) {return(sum(sort(x, decreasing=TRUE)[2:4]))})
  return(states[order(-states$CENSUS2010POP), ][1:3, 'STNAME'])
}
task6()
```

**Result:**
```
> task6()
[1] "California" "Texas"      "Illinois"  
```

**7. Який округ (county) має найбільшу абсолютну зміну в населенні протягом періоду 2010-2015? (Підказка: значення населення зберігається в колонках з POPESTIMATE2010 до POPESTIMATE2015. Необхідно розглядати всі шість колонок). Якщо населення округу за 5річний період 100, 120, 80, 105, 100, 130, то найбільша різниця за період буде |130-80|=50. Функція повинна повернути одне текстове значення.**
```{r}
task7 <- function() {
  columns <- c('POPESTIMATE2010', 'POPESTIMATE2011', 'POPESTIMATE2012', 'POPESTIMATE2013', 'POPESTIMATE2014', 'POPESTIMATE2015')
  f <- function(...) {
    data <- c(as.list(environment()), list(...))
    data <- unlist(data)
    return(abs(max(data)-min(data)))
  }
  return(census_df[which.max(apply(census_df[,columns], 1, f)), 'CTYNAME'])
}
task7()
```

**Result:**
```
> task7()
[1] "Texas"
```

**В census_df США поділені на 4 регіони (колонка "REGION"). Напишіть функцію, яка знаходить округи (county), що належать регіонам 1 або 2, назва яких починається з "Washington" та POPESTIMATE2015 більше ніж POPESTIMATE2014. Функція повинна повернути 5х2 дата фрейм з колонками "STNAME", "CTYNAME".**
```{r}
task8 <- function() {
  result <- census_df[(census_df[['REGION']] %in% c(1, 2)) & (census_df[['POPESTIMATE2014']] < census_df[['POPESTIMATE2015']]), ]
  result <- result[(grep('^Washington', result$CTYNAME)), ]
  return(result[c('STNAME', 'CTYNAME')])
}
task8()
```

**Result:**
```
> task8()
           STNAME           CTYNAME
897          Iowa Washington County
1420    Minnesota Washington County
2346 Pennsylvania Washington County
2356 Rhode Island Washington County
3164    Wisconsin Washington County
```
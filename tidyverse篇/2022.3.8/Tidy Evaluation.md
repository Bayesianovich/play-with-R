```r
library(tidyverse)
library(rlang)
```
д����Ĺ����У����ǻ������Բ�ͬ�����ݿ�ִ����ͬ�Ĳ�����

```r
df1 %>% group_by(x1) %>% summarise(mean = mean(y1))
df2 %>% group_by(x2) %>% summarise(mean = mean(y2))
df3 %>% group_by(x3) %>% summarise(mean = mean(y3))
df4 %>% group_by(x4) %>% summarise(mean = mean(y4))
```
Ϊ�˼��ٴ�����ظ������ǿ��ǽ���ͬ�Ĳ��ֱ������仯�Ĳ����ò�������ȡ����

```r
data %>% group_by(group_var) %>% summarise(mean = mean(summary_var))
```
�����뵽дһ���Ӻ�������ʽ

```r
grouped_mean <- function(data, group_var, summary_var) {
  group_var <- enquo(group_var)
  summary_var <- enquo(summary_var)

  data %>%
    group_by(!!group_var) %>%
    summarise(mean = mean(!!summary_var))
}
```
��һ������ enquo()���û����ݹ����Ĳ����������������ÿ������Ϊ�䶳������

�ڶ������� !! �⿪������ã������ÿ������Ϊ���䣩��Ȼ��ʹ�ò���������
```r
grouped_mean <- function(data, group_var, summary_var) {
  data %>%
    group_by({{group_var}}) %>%
    summarise(mean = mean({{summary_var}}))
}

grouped_mean(mtcars, cyl, mpg)

```
```r
grouped_mean(mtcars, cyl, mpg)
```

��������(env-variables)

���ݱ���(data-variables)

`grouped_mean(mtcars, cyl, mpg)`

cyl��mpg�Ǵ��㴫�ݵĲ���,�ǻ�������

������ݸ���Ĳ�����������...����group_var ��Ȼ�󴫵ݵ�group_by()������

```r
grouped_mean <- function(data, summary_var, ...) {
  summary_var <- enquo(summary_var)
    group_var <- enquos(...)
 
  data %>%
    group_by(!!!group_var) %>%
    summarise(mean = mean(!!summary_var))
}

grouped_mean(mtcars, disp, cyl, am)
```

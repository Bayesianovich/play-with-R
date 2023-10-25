第4行第3列开始，出现若干NA，这里的NA就是缺失值，NA的意思就是 not available.



注意区分 “NA” 和 NA



“NA” 有引号的是字符串
NA 是R里的特殊标记
![](NA.png)

### tidyverse中的dot

管道符号%>% 主要功能是传递参数。

- y %>% f() is equivalent to f(y)

- y %>% f(x, .) is equivalent to f(x, y)

- z %>% f(x, y, arg = .) is equivalent to f(x, y, arg = z)

.出现在函数.f的位置上， 就是 purrr 风格的Lambda函数~ fun(.)，

**有些函数的参数前缀是 .**

- mutate_all(.tbl, .funs, ...)

- mutate_if(.tbl, .predicate, .funs, ...)

- mutate_at(.tbl, .vars, .funs, ..., .cols = NULL)

- select_all(.tbl, .funs = list(), ...)

- rename_all(.tbl, .funs = list(), ...)
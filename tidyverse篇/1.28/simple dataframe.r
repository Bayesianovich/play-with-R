require(tidyverse)
d <- data.frame(
    a = 1:5,
    b = letters[1:5]
)
d
typeof(d$b)

####
tb <- tibble(
    a = 1:5,
    b = letters[1:5]
)
tb

### 有时我们也喜欢这样,构建两个有关联的变量
tb <- tibble(
    x = 1:3,
    y = x + 2
)
tb
### data.frame就不行
df <- data.frame(
    x = 1:3,
    y = x + 2
)
tibble(a = 1:5, b = letters[1:5])

tibble(
    a = 1:5,
    b = 10:14,
    c = a + b
)
# 或者 tibble(a = 1:5, b = 10:14, c = a + b)

# 为了让每列更加直观，也可以tribble()创建，数据量不大的时候，挺方便的
tribble(
    ~x, ~y, ~z,
    "a", 2, 3.6,
    "b", 1, 8.5
)

# data.frame转换成tibble
t1 <- iris[1:6, 1:4] # data.frame
class(t1)

as_tibble(t1)

# vector转型到tibble
x <- as_tibble(1:5) # Use 'tibble'::enframe()
x

# list转型为tibble
df <- as_tibble(list(x = 1:6, y = runif(6), z = 6:1))
df

# matrix转型到tibble
m <- as_tibble(matrix(1:6, nrow = 3))
m

# tibble简单操作
df <- tibble(
    x = 1:2,
    y = 2:1
)
df
# 添加一列
add_column(df,z = 0:1, w = 0)

#添加一行
add_row(df, x = 3, y = 4)

#在第二行,增加一行
add_row(df,x = 99, y = 100, .before = 2)

#lst,创建一个list,具有tibble特性的list
lst(n = 5, x = runif(n),y = TRUE)

#enframe()将矢量快速创建tibble, 创建的tibble只有两列:name和value
enframe(1:3)
enframe(c(a =5, b = 6, c = 9))
# enframe()可以看做是enframe()的反操作,把tibble反向转成向量
df <- enframe(c(a = 5, b = 7 ))
df
#change to vector
deframe(df)

#read_csv()读取csv文件时,生成的直接是tibble
read_csv("./demo_data/wages.csv")

# data.frame是支持行名的，但tibble不支持行名，这也是两者不同的地方
# create data.frame
df <- data.frame(
    x = 1:3,
    y = 3:1
)
df
# create row name
row.names(df) <- letters[1:3]
df
has_rownames(df)

#但对于tibble
tb <- tibble(
    x = 1:3,
    y = 3:1
)
row.names(tb) <- letters[1:3]

#遇到含有行名的data.frame,转换成tibble后,行名会被丢弃
# 如果想保留行名,就需要把行名转换成单独的一列
df <- mtcars[1:3,1:3]
df
# 把行名转换为单独的一列
rownames_to_column(df, var = "rowname")

#把行索引转换为单独的一列
rowid_to_column(df, var = "rowid")

#error
tibble(x = 1, x = 2)

#repair
tibble(x = 1, x = 2, .name_repair = "minimal")

tibble(x = 1, x = 2, .name_repair = "unique")

tibble(x = 1, x = 2, .name_repair = "universal")

tibble(`a 1` = 1, `a 2` = 2, .name_repair = "universal")

tibble(x = 1, x = 2, .name_repair = make.unique)

tibble(x = 1, x = 2, .name_repair = ~ make.unique(.x, sep = "_"))

tibble(x = 1, x = 2, .name_repair = ~ make.names(., unique = TRUE))

# 如果真正遇到比较乱的列名,推荐使用janitor::clean_names()一步到位
tibble(`year 1` = 1, `year 2` = 2) %>%
    janitor::clean_names()

require(palmerpenguins)

df <- penguins %>%
    drop_na() %>%
    select(
        species,bill_length_mm,bill_depth_mm,body_mass_g)
df
# nest() 为每种species创建了一个小的tibble， 每个小的tibble对应一个species
tb <- df %>%
    nest(data = c(bill_length_mm,bill_depth_mm,body_mass_g))
tb

tb$data[[1]]
# tb的整个data列是一个list
tb$data %>% typeof()

# select()的
df %>% 
  nest(data = !species)

#可以同时创建多个列表列
df %>% 
  nest(data1 = c(bill_length_mm, bill_depth_mm), data2 = body_mass_g)
 
 #tidyr::summarise()可以把tibble的数据汇总到一个新的tibble中
df_collapsed <- df %>%
    group_by(species) %>%
    summarise(
        data = list(bill_length_mm)
    )

df_collapsed


# 创建列表列之前,对数据简单处理,比如排序
df %>%
    group_by(species) %>%
    summarise(
      data = list(sort(bill_length_mm))
  )
# 筛选
df %>%
    group_by(species) %>%
    summarise(
        data = list(
        bill_length_mm[bill_length_mm > 45])
    )

penguins %>%
    drop_na %>%
    group_by(island) %>%
    summarise(
        n_num = n()
    ) %>%
rowwise() %>%
    mutate(random = list(rnorm(n = n_num))) %>%
    ungroup()

tb
tb %>%
    unnest(cols =data)

 tb %>% 
  rowwise() %>% 
  mutate(num_species = nrow(data))

tb %>% 
  rowwise() %>% 
  mutate(corr_coef = cor(data$bill_length_mm, data$bill_depth_mm))

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

### ��ʱ����Ҳϲ������,���������й����ı���
tb <- tibble(
    x = 1:3,
    y = x + 2
)
tb
### data.frame�Ͳ���
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
# ���� tibble(a = 1:5, b = 10:14, c = a + b)

# Ϊ����ÿ�и���ֱ�ۣ�Ҳ����tribble()�����������������ʱ��ͦ�����
tribble(
    ~x, ~y, ~z,
    "a", 2, 3.6,
    "b", 1, 8.5
)

# data.frameת����tibble
t1 <- iris[1:6, 1:4] # data.frame
class(t1)

as_tibble(t1)

# vectorת�͵�tibble
x <- as_tibble(1:5) # Use 'tibble'::enframe()
x

# listת��Ϊtibble
df <- as_tibble(list(x = 1:6, y = runif(6), z = 6:1))
df

# matrixת�͵�tibble
m <- as_tibble(matrix(1:6, nrow = 3))
m

# tibble�򵥲���
df <- tibble(
    x = 1:2,
    y = 2:1
)
df
# ���һ��
add_column(df,z = 0:1, w = 0)

#���һ��
add_row(df, x = 3, y = 4)

#�ڵڶ���,����һ��
add_row(df,x = 99, y = 100, .before = 2)

#lst,����һ��list,����tibble���Ե�list
lst(n = 5, x = runif(n),y = TRUE)

#enframe()��ʸ�����ٴ���tibble, ������tibbleֻ������:name��value
enframe(1:3)
enframe(c(a =5, b = 6, c = 9))
# enframe()���Կ�����enframe()�ķ�����,��tibble����ת������
df <- enframe(c(a = 5, b = 7 ))
df
#change to vector
deframe(df)

#read_csv()��ȡcsv�ļ�ʱ,���ɵ�ֱ����tibble
read_csv("./demo_data/wages.csv")

# data.frame��֧�������ģ���tibble��֧����������Ҳ�����߲�ͬ�ĵط�
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

#������tibble
tb <- tibble(
    x = 1:3,
    y = 3:1
)
row.names(tb) <- letters[1:3]

#��������������data.frame,ת����tibble��,�����ᱻ����
# ����뱣������,����Ҫ������ת���ɵ�����һ��
df <- mtcars[1:3,1:3]
df
# ������ת��Ϊ������һ��
rownames_to_column(df, var = "rowname")

#��������ת��Ϊ������һ��
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

# ������������Ƚ��ҵ�����,�Ƽ�ʹ��janitor::clean_names()һ����λ
tibble(`year 1` = 1, `year 2` = 2) %>%
    janitor::clean_names()

require(palmerpenguins)

df <- penguins %>%
    drop_na() %>%
    select(
        species,bill_length_mm,bill_depth_mm,body_mass_g)
df
# nest() Ϊÿ��species������һ��С��tibble�� ÿ��С��tibble��Ӧһ��species
tb <- df %>%
    nest(data = c(bill_length_mm,bill_depth_mm,body_mass_g))
tb

tb$data[[1]]
# tb������data����һ��list
tb$data %>% typeof()

# select()��
df %>% 
  nest(data = !species)

#����ͬʱ��������б���
df %>% 
  nest(data1 = c(bill_length_mm, bill_depth_mm), data2 = body_mass_g)
 
 #tidyr::summarise()���԰�tibble�����ݻ��ܵ�һ���µ�tibble��
df_collapsed <- df %>%
    group_by(species) %>%
    summarise(
        data = list(bill_length_mm)
    )

df_collapsed


# �����б���֮ǰ,�����ݼ򵥴���,��������
df %>%
    group_by(species) %>%
    summarise(
      data = list(sort(bill_length_mm))
  )
# ɸѡ
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

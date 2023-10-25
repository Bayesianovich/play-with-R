dplyr的一些函数(mutate(),select()等等),事实上，这些函数加上后缀_all、_at,_if、形成三组变体函数,可以方便对特定的子集进行操作.
- 对数据框所有列操作,可以用_all
- 对数据框指定操作，可以用_at
- 对数据框符合条件的几列进行操作，可以用_if

 across函数
 - colwise：group_by() %>% summarize/mutate + across()
 - rowwise：nest_by()/rowwise() %>% summarize/mutate + across(row.names)
  
  across函数替代scope函数
  强大的across函数,代替以上scope函数(_if,_at和_all函数)，同时slice_max(),slice_min(),slice_n()将代替top_n()函数。

# 行方向处理与列表列是天然一对
rowwise()不仅仅用于计算行方向均值这样的简单统计，而是当处理列表列时，方才显示出rowwise()与purrr::map一样的强大。 
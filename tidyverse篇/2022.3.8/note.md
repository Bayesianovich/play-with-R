��4�е�3�п�ʼ����������NA�������NA����ȱʧֵ��NA����˼���� not available.



ע������ ��NA�� �� NA



��NA�� �����ŵ����ַ���
NA ��R���������
![](NA.png)

### tidyverse�е�dot

�ܵ�����%>% ��Ҫ�����Ǵ��ݲ�����

- y %>% f() is equivalent to f(y)

- y %>% f(x, .) is equivalent to f(x, y)

- z %>% f(x, y, arg = .) is equivalent to f(x, y, arg = z)

.�����ں���.f��λ���ϣ� ���� purrr ����Lambda����~ fun(.)��

**��Щ�����Ĳ���ǰ׺�� .**

- mutate_all(.tbl, .funs, ...)

- mutate_if(.tbl, .predicate, .funs, ...)

- mutate_at(.tbl, .vars, .funs, ..., .cols = NULL)

- select_all(.tbl, .funs = list(), ...)

- rename_all(.tbl, .funs = list(), ...)
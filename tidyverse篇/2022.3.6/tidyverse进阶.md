dplyr��һЩ����(mutate(),select()�ȵ�),��ʵ�ϣ���Щ�������Ϻ�׺_all��_at,_if���γ�������庯��,���Է�����ض����Ӽ����в���.
- �����ݿ������в���,������_all
- �����ݿ�ָ��������������_at
- �����ݿ���������ļ��н��в�����������_if

 across����
 - colwise��group_by() %>% summarize/mutate + across()
 - rowwise��nest_by()/rowwise() %>% summarize/mutate + across(row.names)
  
  across�������scope����
  ǿ���across����,��������scope����(_if,_at��_all����)��ͬʱslice_max(),slice_min(),slice_n()������top_n()������

# �з��������б�������Ȼһ��
rowwise()���������ڼ����з����ֵ�����ļ�ͳ�ƣ����ǵ������б���ʱ��������ʾ��rowwise()��purrr::mapһ����ǿ�� 
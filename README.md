#MageINI
MageINI��һ�����GM8��GMS��ini��չ�ű������к�����ͨ��GM���õĺ�����ɣ�֧������λ�õ�INI�ļ�������֧�ִ��ļ����룬��ֱ�Ӵ��ַ�������ini��֧���Զ���ini��ʶ���ȵ�ǿ��Ĺ��ܡ�

���ں���˵���еĲ���д����
����������ĺ���˵���У�ÿһ�������Ҷ���˵�����������֣��������Լ�����ֵ��������������Ĺ��ܣ��Լ�ע�����˵�����������ֲ����ͷ���ֵ�һ�ʹ�����ָ�ʽ��
������(����1���� ����1����,����2���� ����2����,��) : ����ֵ���� ����ֵ����
�������У���Щ�����Ĳ������ܻ���string�ͻ�real�ͣ���˵�����ҽ���ʹ��string|real����ʾ������ֵҲ�з���string��real�������ͬ��ʹ�����ַ�ʽ��ʾ��
����Ϊ�˷����ҿ���˵����һЩini���õ�����һ�ʹ�á�Ƭ�Ρ�������ini�е�section��ʹ�á�����������ini�е�key��ʹ�á�ֵ��������ini�е�value��һ����׼��ini�ļ��ṹ���£�
[section]
key1=value1
key2=value2
key3=value3
;this is a common statement
���������section����һ��Ƭ�Σ�key1��key2��key3��Ϊ����value1��value2��value3����ʾ�ü��µ�ֵ��

����˵����
INI_init()
������ʼ������������Ϸ��ʼ��ʱ��ִ��һ�Ρ���MD�����ʼ�������������˵�ˣ��Ǹ���չӦ�ö������������������⣬�����ʹ�õ���GEX��չ�������Բ�ʹ�����������ʼ������
INI_open(string fname) : real iniHandle
������һ��ini�ļ�������fname��ini�ļ���·����֧�����·���;���·�����򿪺󷵻�ini�ļ��ľ�����Ժ��ڲ������ļ���ʱ����õ�������������ļ�������ֱ�Ӵ򿪶�ȡ���ļ������ڻ��ڸ�ini�ļ��رյ�ʱ�򴴽�һ���µ��ļ����������-1���ʾ��������ʹ��INI_get_error�������Ի�ȡ������Ϣ��
INI_load_from_string(string str) : real iniHandle
����ֱ�Ӵ��ַ���������ini���������һ���ַ���������ַ�����ȫ����ini�ı�׼�������ֱ�ӽ�����ַ������룬�ú�������ini�ľ�����Ժ��ٲ������ini��ʱ����õ����������������-1���ʾ��������ʹ��INI_get_error�������Ի�ȡ������Ϣ��
INI_get_error() : string errorMessage
�������ص�ǰ�Ƿ��д��󣬷���ֵΪ�����������ַ�����
INI_close(real iniHandle) : real|string 1|iniString
�����ر�һ��ini���������ini����������ʱ��ʹ������������رղ��ͷ�ini����������ini��ʹ��INI_open��������һ���ļ�ʱ����������Ὣ�������ini�ļ����б��棬Ҳ����˵�������ʹ�ùرպ�����ini�ļ��������ǲ��ᱻ���������Ӳ���ϵġ�������󣬸ú����᷵��1�������ʹ�õ���INI_load_from_string������һ���ַ�������ô��������᷵�ز������ini�ַ��������Ƿ���һ��ʵ����ע�⣺ʹ����������������ini�ļ��򷵻ص�ini�ַ��������Դini�е�ע���Ƴ���
INI_read(real iniHandle,string section,string|real key,string default) : string value
������key����Ϊstring��ʱ����ָ����ini�����ָ����Ƭ�εļ���ȡһ���ַ�����������Ƭ�β�����ʱ���᷵��defaultֵ������Ƭ���´��ڶ��key��ʱ���᷵�ص�һ��key����ֵ����key����Ϊreal��ʱ����ָ����ini�����ָ����Ƭ�ζ�ȡ��key������ֵ����keyΪ1ʱ���ȡ��Ƭ���µ�һ������ֵ��KeyΪ2ʱ���ȡ��Ƭ���µڶ�������ֵ���Դ����ƣ����key��ֵ���ڸ�Ƭ���´��ڼ���������ȡֵ������key<=0ʱ������᷵��defaultֵ��
INI_read_n(real iniHandle,string section,string key,real n,string default) : string value
������ָ����ini�����ָ����Ƭ�εĵ�n��key����ȡһ���ַ������������ֻ������һ��Ƭ�����ж����ͬ�ļ�ʱ��ʹ�á����Ƭ�λ�������ڻ�n������key�����������򷵻�default��
INI_write (real iniHandle,string section,string key,string value)
������ָ����ini�����ָ��Ƭ�εļ���д��һ��ֵ�������Ƭ���´�������������Ḳ�ǣ�����ڶ����Ḳ�ǵ�һ����
INI_add(real iniHandle,string section,string key,string value)
������ָ����ini�����ָ��Ƭ�εļ���д��һ��ֵ�����Ƭ���´����������������׷�ӣ�������������ǲ�����
INI_section_count(real iniHandle) : real count
��������ָ����ini�����һ���ж��ٸ�Ƭ�Ρ�
INI_key_count(real iniHandle,string section) : real count
��������ָ����ini����µ�ָ��Ƭ���¹��ж��ٸ�����
INI_key_same_count(real iniHandle,string section,string key) : real count
��������ָ����ini����µ�ָ��Ƭ���¹��ж��ٸ�����Ϊkey�ļ���
INI_section_delete(real iniHandle,string section)
����ɾ��ָ��ini����µ�sectionƬ�Σ�ͬʱҲ��ɾ����Ƭ���µ����м���
INI_key_delete(real iniHandle,string section,string key)
����ɾ��ָ��ini�����sectionƬ������������Ϊkey�ļ���
INI_key_delete_n(real iniHandle,string section,string key,real n)
����ɾ��ָ��ini�����sectionƬ���ڵ�n������Ϊkey�ļ������n<=0��n���ڸü�������Ŀ�򲻻�ɾ���κμ���
INI_get_string(real iniHandle) : string iniStr
�������ָ��ini�����ini��ʽ�ַ�����ʹ�øú��������ԭini�ִ��е�����ע�͡�
INI_save_file(real iniHandle,string fname)
������ini�����ini�ĸ�ʽ������fname�ļ��С�ʹ�øú��������ԭini������ע�͡�

�Զ���ini��ʶ����
����������Զ������ini��ʶ������ν��ini��ʶ������Ƭ�����������ţ�[]��������ֵ�����ӷ��ţ�=��ʹ����һ��չ��������ɵĸı���Щ��ʶ������Щ���Ų���ֻӰ���㽫ini��ŵ��ļ����������ini�ַ�������Ҳ��Ӱ�����ȡini�ļ���һ����׼��ini�ļ�����������ʹ���Զ���ı�ʶ�����򲻻�����κ����ݡ�
�����ṩ�˼���ȫ�ֱ�������ı�ini�ı�ʶ����
����INI_SECTION_SIGN_LEFT �� INIƬ�ε������ţ�Ĭ��ֵΪ��[��
����INI_SECTION_SIGN_RIGHT �� INIƬ�ε������ţ�Ĭ��ֵΪ��]��
����INI_ITEM_SIGN �� INI�ļ���ֵ�����ӷ���Ĭ��ֵΪ��=������Щini�ļ����ܻ��ǣ�:������������ini�ļ����ڴ�֮ǰһ��Ҫ�ȸ��Ĵ˱���Ϊ��:����
����INI_NOTE_SIGN �� INI��ע�ͷ�����ini�ļ���һ�еĵ�һ���ַ����������ʱ�����в��ᱻ������������

�����˵���䣺
	������������չ�з�����ɶBUG�Ļ�����ӭ��ϵ���ߣ�QQ386083738������չ��ȫ��Դ����λҲ�����Լ��޸�һЩ

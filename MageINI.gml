#define INI_init
global.__ini_error_string = "";
globalvar INI_SECTION_SIGN_LEFT,INI_SECTION_SIGN_RIGHT,INI_ITEM_SIGN,INI_NOTE_SIGN;
INI_SECTION_SIGN_LEFT = "["
INI_SECTION_SIGN_RIGHT = "]"
INI_ITEM_SIGN = "="
INI_NOTE_SIGN = ";"

#define INI_open
// INI_open(fname) : iniHandle
// open a ini file and return the ini file ID
// if error return -1

/*
    ini MAP的保存方式
    0 : ini的文件位置
    1 : ini是否被更改
    2 : section列表的索引
*/

var fname ;
fname = argument0
if(is_real(fname)) {
    global.__ini_error_string = "fname must be a string";
    return -1;
}
var file,iniID;

// 获取ini的ID，创建ini需要的map
var map;
map = ds_map_create();
iniID = map

// 将路径存入到map,key=0存储的是ini的文件路径
ds_map_add(map,0,fname)

// 该ini文件是否被修改
ds_map_add(map,1,false)

// 读取ini文件，并存入map
var exists,list;
list = ds_list_create()
exists = file_exists(fname)

var section,set_map;
section = ""
set_map = -1
if(exists) {
file = file_text_open_read(fname)
while(!file_text_eof(file)) {
    var text;
    text = file_text_read_string(file)
    file_text_readln(file)
    ds_list_add(list,text)
}
file_text_close(file)
} else ds_map_replace(map,1,true)
__Load_ini(list,iniID)
return iniID;


#define INI_load_from_string
// INI_load_from_string(string) : iniHandle
// open a ini file and return the ini file ID
// if error return -1

/*
    ini MAP的保存方式
    0 : ini的文件位置
    1 : ini是否被更改
    2 : section列表的索引
*/

var iniStr ;
iniStr = argument0
if(is_real(iniStr)) {
    global.__ini_error_string = "argument must be a string";
    return -1;
}
var iniID;

// 获取ini的ID，创建ini需要的map
var map;
map = ds_map_create();
iniID = map

// 将路径存入到map,key=0存储的是ini的文件路径
ds_map_add(map,0,0)

// 该ini文件是否被修改
ds_map_add(map,1,false)

// 读取ini文件，并存入map
var list;
list = ds_list_create()

var i,length,section,set_map;
section = ""
text = ""
set_map = -1
length = string_length(iniStr)
for(i = 1;i <= length;i += 1) {
    var char;
    char = string_copy(iniStr,i,1)
    if(char == chr(13) or char == chr(10)) {
        if(text != "") {
            ds_list_add(list,text)
            text = ""
        }
    } else {
        text += char
    }
}
if(text != "") {
    ds_list_add(list,text)
}

__Load_ini(list,iniID)
return iniID;


#define INI_get_error
return global.__ini_error_string;

#define INI_close
//INI_close(iniHandle)
var iniMap,isChange,secList,is_file,iniStr;
iniMap = argument0
isChange = ds_map_find_value(iniMap,1)
secList = ds_map_find_value(iniMap,2)
if(is_real(ds_map_find_value(iniMap,0))) is_file = false else is_file = true
if(isChange) {
    if(is_file) {
        /*var file,fname;
        fname = ds_map_find_value(iniMap,0)
        file = file_text_open_write(fname)
        var i,size;
        size = ds_list_size(secList)
        for(i = 0;i < size;i += 1) {
            var a,section,sMap;
            section = ds_list_find_value(secList,i)
            file_text_write_string(file,"[" + section + "]")
            file_text_writeln(file)
            sMap = ds_map_find_value(iniMap,section)
            var itemCount,l;
            l[0] = ds_map_find_value(sMap,0)
            l[1] = ds_map_find_value(sMap,1)
            itemCount = ds_list_size(l[0])
            for(a = 0;a < itemCount;a += 1) {
                file_text_write_string(file,ds_list_find_value(l[0],a) + "=" + ds_list_find_value(l[1],a))
                file_text_writeln(file)
            }
        }
        file_text_close(file)*/
        var fname;
        fname = ds_map_find_value(iniMap,0)
        INI_save_file(iniMap,fname)
    }
}
if(!is_file) iniStr = INI_get_string(iniMap)

var i,sMap,size;
size = ds_list_size(secList)
for(i = 0;i < size;i += 1) {
    sMap = ds_map_find_value(iniMap,ds_list_find_value(secList,i))
    ds_list_destroy(ds_map_find_value(sMap,0))
    ds_list_destroy(ds_map_find_value(sMap,1))
    ds_map_destroy(sMap)
}
ds_list_destroy(secList)
ds_map_destroy(iniMap)
if(is_file) {
    return 1
} else {
    return iniStr;
}


#define INI_read
//INI_read(ini,section,key/pos,default)
var ini,section,key,def;
ini = argument0
section = argument1
key = argument2
def = argument3

var sMap;
if(ds_map_exists(ini,section)) {
    sMap = ds_map_find_value(ini,section)
    var l,index;
    l[0] = ds_map_find_value(sMap,0)
    l[1] = ds_map_find_value(sMap,1)
    if(is_string(key)) {
        index = ds_list_find_index(l[0],key)
        if(index = -1) return def
    } else {
        index = key - 1;
    }
    return ds_list_find_value(l[1],index)
} else {
    return def;
}


#define INI_read_n
//INI_read_n(ini,section,key,n,default)
var ini,section,key,def,n;
ini = argument0
section = argument1
key = argument2
n = argument3
def = argument4
n -= 1
var sMap;
if(ds_map_exists(ini,section)) {
    sMap = ds_map_find_value(ini,section)
    var l,index;
    l[0] = ds_map_find_value(sMap,0)
    l[1] = ds_map_find_value(sMap,1)
    var a,i,size;
    size = ds_list_size(l[0])
    a = 0
    for(i = 0;i < size;i += 1) {
        var k,v;
        k = ds_list_find_value(l[0],i)
        if(k == key) {
            if(a == n) {
                return ds_list_find_value(l[1],i)
            }
            a += 1
        }
    }
    return def;
} else {
    return def;
}


#define INI_write
//INI_write(ini,section,key,value)
var ini,section,key,value;
ini = argument0
section = argument1
key = argument2
value = argument3
if(is_real(section)) section = string(section)
if(is_real(key)) key = string(key)
if(is_real(value)) value = string(value)

var sMap,l;
if(!ds_map_exists(ini,section)) {
    var m,l,secList;
    m = ds_map_create();
    sMap = m
    l[0] = ds_list_create()
    l[1] = ds_list_create()
    ds_map_add(ini,section,m)
    ds_map_add(m,0,l[0])
    ds_map_add(m,1,l[1])
    secList = ds_map_find_value(ini,2)
    ds_list_add(secList,section)
} else {
    sMap = ds_map_find_value(ini,section)
    l[0] = ds_map_find_value(sMap,0)
    l[1] = ds_map_find_value(sMap,1)
}
var index;
index = ds_list_find_index(l[0],key)
if(index = -1) {
    ds_list_add(l[0],key)
    ds_list_add(l[1],value)
} else {
    ds_list_replace(l[0],index,key)
    ds_list_replace(l[1],index,value)
}

ds_map_replace(ini,1,true)


#define INI_add
//INI_add(ini,section,key,value)
var ini,section,key,value;
ini = argument0
section = argument1
key = argument2
value = argument3
if(is_real(section)) section = string(section)
if(is_real(key)) key = string(key)
if(is_real(value)) value = string(value)

var sMap,l;
if(!ds_map_exists(ini,section)) {
    var m,l,secList;
    m = ds_map_create();
    sMap = m
    l[0] = ds_list_create()
    l[1] = ds_list_create()
    ds_map_add(ini,section,m)
    ds_map_add(m,0,l[0])
    ds_map_add(m,1,l[1])
    secList = ds_map_find_value(ini,2)
    ds_list_add(secList,section)
} else {
    sMap = ds_map_find_value(ini,section)
    l[0] = ds_map_find_value(sMap,0)
    l[1] = ds_map_find_value(sMap,1)
}

ds_list_add(l[0],key)
ds_list_add(l[1],value)

ds_map_replace(ini,1,true)


#define INI_section_count
//INI_section_count(ini) : count
return ds_list_size(ds_map_find_value(argument0,2))

#define INI_section_get_name
///INI_section_get_name(ini,n)
var list,ini,n;
ini = argument0
n = argument1
list = ds_map_find_value(ini,2)
return ds_list_find_value(list,n-1)

#define INI_section_delete
//INI_section_delete(ini,section)
var ini,section;
ini = argument0
section = argument1

var secList;
secList = ds_map_find_value(ini,2)
ds_list_delete(secList,ds_list_find_index(secList,section))
var sMap,l;
sMap = ds_map_find_value(ini,section)
l[0] = ds_map_find_value(sMap,0)
l[1] = ds_map_find_value(sMap,1)
ds_list_destroy(l[0])
ds_list_destroy(l[1])
ds_map_destroy(sMap)
ds_map_delete(ini,section)
ds_map_replace(ini,1,true)

#define INI_key_count
//INI_key_count(ini,section)
var sMap;
sMap = ds_map_find_value(argument0,argument1)
var l;
l = ds_map_find_value(sMap,0)
return ds_list_size(l)


#define INI_key_get_name
///INI_key_get_name(ini,section,n)
var ini,section,key;
ini = argument0
section = argument1
key = argument2

var sMap;
if(ds_map_exists(ini,section)) {
    sMap = ds_map_find_value(ini,section)
    var l,index;
    l[0] = ds_map_find_value(sMap,0)
    l[1] = ds_map_find_value(sMap,1)
    index = key - 1;
    return ds_list_find_value(l[0],index)
}
return false

#define INI_key_same_count
//INI_key_same_count(ini,section,key)
var sMap;
sMap = ds_map_find_value(argument0,argument1)
var l,key;
l = ds_map_find_value(sMap,0)
key = argument2
var i,size,t;
t = 0
size = ds_list_size(l)
for(i = 0;i < size;i += 1) {
    var k;
    k = ds_list_find_value(l,i)
    if(k == key) {
        t += 1
    }
}
return t;

#define INI_key_delete
//INI_key_delete(ini,section,key)
var ini,section,key;
ini = argument0
section = argument1
key = argument2

var sMap;
if(ds_map_exists(ini,section)) {
    sMap = ds_map_find_value(ini,section)
    var l,index;
    l[0] = ds_map_find_value(sMap,0)
    l[1] = ds_map_find_value(sMap,1)
    var a,i,size,deleteCount;
    deleteCount = 0
    size = ds_list_size(l[0])
    a = 0
    for(i = 0;i < size;i += 1) {
        var k;
        k = ds_list_find_value(l[0],i)
        if(k == key) {
            ds_list_delete(l[0],i)
            ds_list_delete(l[1],i)
            i -= 1
            deleteCount += 1
        }
    }
    ds_map_replace(ini,1,true)
    return deleteCount;
} else {
    return 0;
}

#define INI_key_delete_n
//INI_key_delete_n(ini,section,key,n)
var ini,section,key,n;
ini = argument0
section = argument1
key = argument2
n = argument3

n -= 1
var sMap;
if(ds_map_exists(ini,section)) {
    sMap = ds_map_find_value(ini,section)
    var l,index;
    l[0] = ds_map_find_value(sMap,0)
    l[1] = ds_map_find_value(sMap,1)
    var a,i,size;
    size = ds_list_size(l[0])
    a = 0
    for(i = 0;i < size;i += 1) {
        var k,v;
        k = ds_list_find_value(l[0],i)
        if(k == key) {
            if(a == n) {
                ds_list_delete(l[0],i)
                ds_list_delete(l[1],i)
            }
            a += 1
        }
    }
    ds_map_replace(ini,1,true)
    return 1;
} else {
    return 0;
}

#define INI_get_string
var iniMap,secList;
iniMap = argument0
secList = ds_map_find_value(iniMap,2)
var i,size,iniStr;
iniStr = ""
size = ds_list_size(secList)
for(i = 0;i < size;i += 1) {
            var a,section,sMap;
            section = ds_list_find_value(secList,i)
            
            iniStr += (INI_SECTION_SIGN_LEFT + section + INI_SECTION_SIGN_RIGHT)
            iniStr += (chr(13) + chr(10))
            sMap = ds_map_find_value(iniMap,section)
            var itemCount,l;
            l[0] = ds_map_find_value(sMap,0)
            l[1] = ds_map_find_value(sMap,1)
            itemCount = ds_list_size(l[0])
            for(a = 0;a < itemCount;a += 1) {
                iniStr += ds_list_find_value(l[0],a) + INI_ITEM_SIGN + ds_list_find_value(l[1],a)
                iniStr += (chr(13) + chr(10))
            }
}
return iniStr;

#define INI_save_file
//INI_save_file(ini,fname)
var str,file;
str = INI_get_string(argument0)
file = file_text_open_write(argument1)
file_text_write_string(file,str)
file_text_close(file)


#define __Load_ini
//__Load_ini(list,map)

var iniID;
show_debug_message("------ini loading------")
// 获取ini的ID，创建ini需要的map
var map;
map = argument1;
iniID = map
show_debug_message("ini map:" + string(iniID))
// section列表
var secList;
secList = ds_list_create();
show_debug_message("section list:" + string(secList))
ds_map_add(map,2,secList)

// 读取ini文件，并存入map
var exists,iniList;
iniList = argument0

var section,set_map,size,i;
section = ""
set_map = -1
size = ds_list_size(iniList)
for(i = 0;i < size;i += 1) {
    var text;
    text = ds_list_find_value(iniList,i)
    var a,b,c;
    a = string_pos(INI_SECTION_SIGN_LEFT,text)
    b = string_pos(INI_SECTION_SIGN_RIGHT,text)
    c = string_pos(INI_ITEM_SIGN,text)
    // 检查字符串是否符合标准ini格式
    if(text == "") continue
    if(c == 0) {
        if!(a == 1 and b > 2) {
            continue
        }
    }
    // 检查该行是否为注释语句
    if(string_pos(INI_NOTE_SIGN,text) == 1) continue
    
    if(a == 1 and b > 2) {
        section = string_copy(text,a+1,b-a-1)
        if(!ds_map_exists(map,section)) {
            var m,l;
            m = ds_map_create()
            show_debug_message("section map:" + string(m))
            ds_map_add(map,section,m)
            l[0] = ds_list_create()
            l[1] = ds_list_create()
            show_debug_message("value map:" + string(l[0]) + "," + string(l[1]))
            ds_map_add(m,0,l[0])
            ds_map_add(m,1,l[1])
            if(ds_list_find_index(secList,section) == -1) {
                ds_list_add(secList,section)
            }
            set_map = m
            
        } else {
            set_map = ds_map_find_value(map,section)
        }
        continue
    }
    
    if(c != 0) {
        if(set_map != -1) {
            var left,right,list;
            left = string_copy(text,1,c-1)
            right = string_copy(text,c+1,string_length(text) - c)
            list[0] = ds_map_find_value(set_map,0)
            list[1] = ds_map_find_value(set_map,1)
            ds_list_add(list[0],left)
            ds_list_add(list[1],right)
            //show_debug_message("Set Item : [" + section + "] " + left + " : " + right)
        }
    }
}
ds_list_destroy(iniList)
show_debug_message("------ini loaded------")
return iniID;
//
//  NetSwitch.c
//  NetSwitch
//
//  Created by YiEN on 2021/1/19.
//


#include <stdio.h>
#include <string.h>
#include <stdlib.h>
//缓冲大小如果多个磁盘防止溢出建议设置大点
#define buf_size 4096
#define local_position "~/NTFS/"
//为了简化计算计算好了直接用
#define  WN "Windows_NTFS"
#define WNLEN 12
#define  MBD "Microsoft Basic Data"
#define  MBDLEN 20

char startWisth(char *mainstr, char *substr) {
    
    int ac = 1;
    ac = strstr(mainstr, substr);
    if (ac > 0) {
        return 1;
    }
    return 0;
}

static char *cut_substr(char *dest, const char *src, char start, int n) {
    char *p = dest;
    char *q = src;
    char *temp = NULL;
    int len = strlen(src);
    
    if (start >= len || start < 0) {
        return NULL;
    }
    temp = q + start;
    if (n > strlen(temp)) {//注意这里，截取长度如果超过了src剩余的长度则只截取到src的最后，以避免内存越界；
        n = strlen(temp);
    }
    q += start;
    while (n--) *(p++) = *(q++);
    *(p++) = '\0';
    return dest;
}

void shell(const char *cmd, char *result) {
    char buf_ps[buf_size];
    char ps[buf_size] = {0};
    FILE *ptr;
    strcpy(ps, cmd);
    if ((ptr = popen(ps, "r")) != NULL) {
        while (fgets(buf_ps, buf_size, ptr) != NULL) {
            strcat(result, buf_ps);
            if (strlen(result) > buf_size)
                break;
        }
        pclose(ptr);
        ptr = NULL;
    } else {
        printf("命令: %s 错误\n", ps);
    }
}

void getName(const char *data, char *reult) {
    
}

void mountNTFS_10_13_6(const char *raw) {
    //    printf("%s\n",raw);
    //    char www[4096];
    //    strcpy(www,raw);
    
    //    char *ac=1;
    //    ac=strstr(raw,"/dev/");
    //    printf("Reusle: %s\n",ac);
    char *substr = "/dev/";
    char *slice = NULL;
    char slice_res[512][512];
    int n = 0;
    //分割字符串
    slice = strstr(raw, substr);
    while (slice != NULL) {
        
        char *path0 = strstr(slice + 5, "/dev/");//获取下一个带dev的地址
        //处理最后一个分类
        if (path0 == NULL) {
            path0 = raw + strlen(raw);
        }
        int asd0 = path0 - slice;//计算一个临时长度
        char temp0[4096];//声明存储空间
        //复制 段结果 到临时内存
        strncpy(temp0, slice,asd0 );
        //查看是否包括一下两个字段-
        //        printf("%d\n",strlen(WN));
        //        printf("%d\n",strlen(MBD));
        //查找段字符串内 制定字符位置
        char *pathW = strstr(temp0, WN);
        int lentaA = 0;
        if (pathW != NULL) {
            lentaA = WNLEN;
            
        } else{
            pathW= strstr(temp0, MBD);
            if (pathW != NULL) {
                lentaA = MBDLEN;
            }
            
        }
        if (lentaA > 0) {
            //存储变量
            char *uuu = pathW + lentaA + 1;
            char *ttt = strstr(uuu, " ");
            //            char *kkk=strstr(ttt," ");
            int bbq = ttt - uuu;
            char tempT[512]={};
            char tempDisk[512]={};
            // char name[]
            strncpy(tempT, uuu,bbq);
            
            char *disk=strstr(uuu, "disk");
            char *nnn = strstr(disk, "\n");
            strncpy(tempDisk, disk,nnn-disk);
            printf("磁盘名称: %s\n", tempT);
            printf("磁盘名称: %s\n", tempDisk);
            char *path = strstr(slice, ")");
            int asd = path - slice;
            char temp[4096];
            strncpy(temp, slice,asd);
            if (strstr(temp, "physical") != NULL) {
                char *path1 = strstr(temp, " ");
                int bb = path1 - temp;
                char temp1[512];
                strncpy(temp1, temp, bb);
                //存储数据
                strcpy(slice_res[n], temp1);
                strcpy(slice_res[n + 1], tempT);
                strcpy(slice_res[n + 2], tempDisk);
                n += 3;
            }
            lentaA = 0;
        }
        
        
        //  char *context= strstr(slice+5,temp);
        //复制slice到slice_res数组位去
        
        
        //循环读取上次传进来的数据
        slice = strstr(slice + 5, substr);
    }
    
    char  *whileTemp="";
    int nns=0;
    
    whileTemp=slice_res[nns];
    while (*whileTemp!='\0'|*whileTemp != (void*)0){
        
        
        printf("\n即将执行命令,请输入密码:\n\n");
        //拼接卸载命令
        char cmd_umount[1024] = "echo '123123' | sudo hdiutil eject /Volumes/";
        strcat(cmd_umount, slice_res[nns+1]);
 
        //卸载原有
        printf("执行命令: %s\n",cmd_umount);
        system(cmd_umount);
        
        //拼接新建文件夹命令
        char cmd_mkdir[1024] = "sudo mkdir  /Volumes/";
        //        strcat(cmd_mkdir,local_position);
        strcat(cmd_mkdir, slice_res[nns+1]);
        
        //创建要挂在的文件夹
        printf("执行命令: %s\n",cmd_mkdir);
        system(cmd_mkdir);
        
        //拼接挂载命令
        //sudo mount_ntfs -o rw,nobrowse /dev/disk2s1 /Users/xxx/myMobileDisk
        char cmd_mount[1024] = "sudo mount_ntfs -o rw,nobrowse /dev/";
        strcat(cmd_mount, slice_res[nns+2]);
        strcat(cmd_mount, " /Volumes/");
        //        strcat(cmd_mount,local_position);
        strcat(cmd_mount,slice_res[nns+1]);
        printf("执行命令: %s\n",cmd_mount);
        //执行挂载命令
        system(cmd_mount);
        nns=nns+3;
        whileTemp="";
        
        whileTemp=slice_res[nns];
    }
    
    //创建要挂在的文件夹
    
    
    
    printf("\n所有磁盘均被挂载\n");
    printf("请在移除磁盘前卸载,避免失数据\n");
}

void umountNTFS(const char *raw) {
    char substr[] = " \n";
    char *slice = NULL;
    char slice_res[512][512];
    int n = 0;
    slice = strtok(raw, substr);
    while (slice != NULL) {
        strcpy(slice_res[n], slice);
        n++;
        slice = strtok(NULL, substr);
    }
    char name[128][128], size[128][128], node[128][128];
    int m = 0;
    for (int i = 0; i < n; i++) {
        if (strcmp(slice_res[i], "Windows_NTFS") == 0) {
            
            strcpy(name[m], slice_res[i + 1]);
            strcat(slice_res[i + 2], slice_res[i + 3]);
            strcpy(size[m], slice_res[i + 2]);
            strcpy(node[m], "/dev/");
            strcat(node[m], slice_res[i + 4]);
            m++;
        }
    }
    printf("发现 %d Windows_NTFS 磁盘端口:\n\n", m);
    for (int i = 0; i < m; i++) {
        printf("%d:\n", i);
        printf("  类型  %s\n", "Windows_NTFS");
        printf("  名称  %s\n", name[i]);
        printf("  大小  %s\n", size[i]);
        printf("  节点  %s\n", node[i]);
    }
    printf("\n即将执行命令,请输入密码\n\n");
    for (int i = 0; i < m; i++) {
        char cmd_umount[1024] = "sudo umount ";
        strcat(cmd_umount, local_position);
        strcat(cmd_umount, name[i]);
        system(cmd_umount);
    }
    printf("\n执行完毕\n");
    printf("你的NTFS磁盘已被卸载。\n");
    printf("移除你的设备以后, 你可以使用 \" sudo rm -R %s* \" 命令删除临时文件\n", local_position);
}

//int main(int argc, char *argv[]) {
int maint() {
    //顺便记一下，int main(int argc, const char
    ///*argv[])中的参数argc为传入参数的个数，argv为传入的参数，argv[0]是程序名，从argv[1]开始才是传入的参数。
    
    printf("=====NetSwitch排序修改工具Swifch 调用c语言=====\n");
    //获取网卡终端列表 列出可以网络 最好加入起别名
    // networksetup -listallnetworkservices

    char list[] = "sudo -i networksetup -ordernetworkservices \"Ethernet\" \"Ethernet Adaptor (en15)\"", res_list[buf_size];
    shell(list, res_list);
    // 切换网络顺序
    //  networksetup -ordernetworkservices  "Ethernet 2" "Ethernet Adaptor (en4)"
    //  networksetup -ordernetworkservices  "Ethernet Adaptor (en4)" "Ethernet 2"
    // networksetup -getinfo "Ethernet 2"

    printf("%s\n",res_list);
    printf("=====谢谢使用=====\n");
    return 1;
}

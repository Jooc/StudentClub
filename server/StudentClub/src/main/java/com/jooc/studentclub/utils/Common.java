package com.jooc.studentclub.utils;

public class Common {

    // local
    public static String ip = "localhost";
    public static String port = "8080";
    public static String backendUrl = "http://" + ip + ":" + port;
    public static String resPath = "file:/Users/Jooc/CodeProject/ImportantPro/StudentClub/server/Data/";
    public static String root = "/Users/Jooc/CodeProject/ImportantPro/StudentClub/server/Data/";
    public static String virtual = "/files/";


    // 权限等级
    public final static int level0 = 0;
    public final static int level1 = 1;
    public final static int level2 = 2;
    public final static int level3 = 3;


    // aliyun.OSS
    public static String endpoint = "oss-cn-huhehaote.aliyuncs.com";
    public static String accessKeyId = "LTAI4G1vT51hqgFohKJ4rJ6t";
    public static String accessKeySecret = "zIOoNFLwKBEXp1gEQOLolGnpByOTpH";
    public static String bucketName = "jooc-studentclub";

    public static String oss_path = "http://jooc-studentclub.oss-cn-huhehaote.aliyuncs.com";
}

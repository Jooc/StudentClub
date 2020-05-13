package com.jooc.studentclub.utils;

import com.aliyun.oss.OSS;
import com.aliyun.oss.OSSClient;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;


public class FileManager {

    final String rootDirectory = Common.root;

    private OSSClient ossClient;
    private String directory;

    public FileManager(String directory){
        this.ossClient = new OSSClient(Common.endpoint, Common.accessKeyId, Common.accessKeySecret);
        this.directory = directory;
    }

    public String save(MultipartFile[] files) throws IOException{
        String filePath = "";
        for (MultipartFile uploadFile: files){
            String oldName = uploadFile.getOriginalFilename();
            String suffix = oldName.substring(oldName.lastIndexOf(".") + 1);
            long timestamp = System.currentTimeMillis();
            String newName = "" + timestamp + "." + suffix;

            File file = new File(rootDirectory + this.directory + "/" + newName);
            uploadFile.transferTo(file);

            String fileKey = this.directory + "/" + newName;
            this.ossClient.putObject(Common.bucketName, fileKey, file);

            filePath += "/" + this.directory + "/" + newName + ";";
        }
        return filePath;
    }

    public void close(){
        this.ossClient.shutdown();
        this.ossClient = null;
    }

    @Override
    public void finalize(){
        if(this.ossClient != null)
            this.ossClient.shutdown();
    }

}
package com.jooc.studentclub.service.interfaces;

import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.HashMap;

public interface NewsServiceInterface {

    Object getByPrivilege(int privilege, int batchNum);
    Object getByUserId(int user_id);
    Object getById(int id);
    Object getAllNews();

    Object publish(HashMap<String, Object> req, MultipartFile[] uploadingFiles) throws IOException;
    Object deleteById(int id);

    //TODO: Search by tags


}

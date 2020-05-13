package com.jooc.studentclub.service.interfaces;

public interface BlogServiceInterface {

    Object getAllBlog();
    Object getById(int id);
    Object getByUserId(int user_id);

    Object insertBlog();

    void deleteById(int id);

}

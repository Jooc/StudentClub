package com.jooc.studentclub.service.interfaces;

import com.jooc.studentclub.model.BlogModel;
import com.jooc.studentclub.model.DBModel.DBBlogModel;

import java.util.List;

public interface BlogServiceInterface {

    List<BlogModel> getAllBlog();
    BlogModel getById(int id);
    List<BlogModel> getByPrivilege(int privilege);
    List<BlogModel> getByUserId(int user_id);

    void insert(DBBlogModel db);

    void delete(int id);

}

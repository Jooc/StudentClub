package com.jooc.studentclub.service;

import com.jooc.studentclub.mapper.BlogMapper;
import com.jooc.studentclub.model.BlogModel;
import com.jooc.studentclub.model.DBModel.DBBlogModel;
import com.jooc.studentclub.service.interfaces.BlogServiceInterface;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Service
public class BlogService implements BlogServiceInterface {

    @Autowired
    public BlogMapper blogMapper;

    public List<BlogModel> getAllBlog() {
        List<DBBlogModel> list = blogMapper.getAllBlog();
        ArrayList<BlogModel> resultList = new ArrayList<>();
        for (DBBlogModel db : list) {
            resultList.add(new BlogModel(db));
        }
        return resultList;
    }

    public BlogModel getById(int id) {
        return new BlogModel(blogMapper.getById(id));
    }

    public List<BlogModel> getByPrivilege(int privilege, int batchNum) {
        List<DBBlogModel> list = blogMapper.getByPrivilege(privilege);
        ArrayList<BlogModel> resultList = new ArrayList<>();
        if (batchNum * 5 < list.size()) {
            for (int i = batchNum * 5; i < (batchNum + 1) * 5 && i < list.size(); i++) {
                resultList.add(new BlogModel(list.get(i)));
            }
        }
        return resultList;
    }

    public List<BlogModel> getByUserId(int user_id) {
        List<DBBlogModel> list = blogMapper.getByUserId(user_id);
        ArrayList<BlogModel> resultList = new ArrayList<>();
        for (DBBlogModel db : list) {
            resultList.add(new BlogModel(db));
        }
        return resultList;
    }


    public void insert(DBBlogModel db) {
        blogMapper.insertBlog(db);
    }

    public void delete(int id) {
        blogMapper.deleteById(id);
    }


}

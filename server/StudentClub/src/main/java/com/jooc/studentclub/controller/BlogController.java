package com.jooc.studentclub.controller;


import com.jooc.studentclub.mapper.BlogMapper;
import com.jooc.studentclub.mapper.UserMapper;
import com.jooc.studentclub.model.BlogModel;
import com.jooc.studentclub.model.DBModel.DBBlogModel;
import com.jooc.studentclub.model.UserInfoModel;
import com.jooc.studentclub.model.DBModel.DBUserModel;
import com.jooc.studentclub.service.BlogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;

@RestController
@RequestMapping("/blog")
public class BlogController {

    @Autowired
    private BlogService blogService;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private BlogMapper blogMapper;


    @Autowired
    public BlogController(BlogService blogService){
        this.blogService = blogService;
    }

    @GetMapping("/getAllBlog")
    public Object getAllBlog(){
        return blogService.getAllBlog();
    }

    @GetMapping("/getById")
    public Object getById(int id){
        return blogService.getById(id);
    }

    @GetMapping("/getByPrivilege")
    public Object getByPrivilege(int privilege){
        return blogService.getByPrivilege(privilege);
    }

    @GetMapping("/getByUserId")
    public Object getByUserID(int id){
        return blogService.getByUserId(id);
    }

    @PostMapping("/publish")
    public Object postBlog(@RequestBody HashMap<String, Object> req){
        HashMap<String, Object> res = new HashMap<>();

        int user_id = -1;
        try{
            user_id = Integer.parseInt(req.get("publisher_id").toString());
        }catch (Exception e){
            res.put("code", -1);
            res.put("msg", "非法输入，请确认用户信息" + e);
            return res;
        }

        DBUserModel DBUserModel = userMapper.getUserById(user_id);
        if (DBUserModel.privilege < 1){
            res.put("code", -1);
            res.put("msg", "权限不足");
            return res;
        }else{
            try {

                // TODO: generate unique ID
                int id = blogMapper.getMaxId() + 1;

                Date d = new Date();
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                String post_time = sdf.format(d);

                String url = (String) req.get("url");

                UserInfoModel userInfo = userMapper.getUserInfoById(user_id);

                int privilege = Integer.parseInt(req.get("privilege").toString());

                String tags = (String) req.get("tags");

                DBBlogModel db = new DBBlogModel(id, post_time, url, userInfo.id, userInfo.name, userInfo.avatar, privilege, tags);

                blogService.insert(db);

                res.put("blog", new BlogModel(blogMapper.getById(id)));
                res.put("code", 0);
                res.put("msg", "发布成功");
            }catch (Exception e){
                res.put("code", -1);
                res.put("msg", "发布失败" + e);
            }

            return res;
        }
    }

    @PostMapping("/delete")
    public Object delete(@RequestBody HashMap<String, Object> req){
        HashMap<String, Object> res = new HashMap<>();

        try{
            int blog_id = Integer.parseInt(req.get("blog_id").toString());
            int user_id = -1;
            try{
                user_id = Integer.parseInt(req.get("user_id").toString());
            }catch (Exception e){
                res.put("code", -1);
                res.put("msg", "非法删除Blog请求，请完善用户信息" + e);
                return res;
            }

            BlogModel blogModel = new BlogModel(blogMapper.getById(blog_id));

            if (blogModel.publisherInfo.id == user_id){
                blogService.delete(blog_id);
                res.put("code", 0);
                res.put("msg", "删除成功");
                return res;
            }else{
                DBUserModel publisherModel = userMapper.getUserById(blogModel.publisherInfo.id);
                DBUserModel requesterModel = userMapper.getUserById(user_id);

                if(requesterModel.privilege > publisherModel.privilege){
                    blogService.delete(blog_id);
                    res.put("code", 0);
                    res.put("msg", "代删除成功");
                    return res;
                }else{
                    res.put("code", 0);
                    res.put("msg", "权限不足,删除失败");
                    return res;
                }
            }
        }catch (Exception e){
            res.put("code", -2);
            res.put("msg", "未知错误" + e);
        }
        return res;
    }
}

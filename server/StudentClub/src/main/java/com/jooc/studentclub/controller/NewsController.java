package com.jooc.studentclub.controller;

import com.jooc.studentclub.mapper.NewsMapper;
import com.jooc.studentclub.mapper.UserMapper;
import com.jooc.studentclub.model.NewsModel;
import com.jooc.studentclub.model.UserModel;
import com.jooc.studentclub.service.NewsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Required;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.HashMap;

@RestController
@RequestMapping("/news")
public class NewsController {

    @Autowired
    private NewsMapper newsMapper;

    @Autowired
    private UserMapper userMapper;

    private NewsService newsService;

    @Autowired
    public NewsController(NewsService newsService){
        this.newsService = newsService;
    }

    @GetMapping("getAllNews")
    public Object getAllNews(){
        return newsService.getAllNews();
    }

    @GetMapping("/getById")
    public Object getById(int id){
        return newsService.getById(id);
    }

    @GetMapping("/getByPrivilege")
    public Object getByPrivilege(int privilege){
        return newsService.getByPrivilege(privilege);
    }

    @GetMapping("/getByUserId")
    public Object getByUserId(int user_id){
        return newsService.getByUserId(user_id);
    }


    @PostMapping("/publish")
    @Required
    public Object Publisher(@RequestParam HashMap<String, Object> req, @RequestPart(value = "files", required = false)MultipartFile[] uploadedFiles) throws IOException{
        HashMap<String, Object> res = new HashMap<>();

        try{
            int user_id = Integer.parseInt(req.get("publisher_id").toString());
//            int privilege =  Integer.parseInt(req.get("privilege").toString());
        }catch (Exception e){
            res.put("news", null);
            res.put("code", -2);
            res.put("msg", "Invalid Post");
            return res;
        }

        try{
            NewsModel newsModel = (NewsModel) newsService.publish(req, uploadedFiles);
            res.put("news", newsModel);
            res.put("code", 0);
            res.put("msg", "发布成功");
        }catch (Exception e){
            res.put("news", null);
            res.put("code", -1);
            res.put("msg", "发布失败" + e.getMessage());
        }

        return res;
    }

    @PostMapping("/delete")
    public Object Delete(@RequestBody HashMap<String, Object> req){
        HashMap<String, Object> res = new HashMap<>();

        try{
            int news_id = Integer.parseInt(req.get("news_id").toString());
            int user_id = -1;
            try{
                user_id = Integer.parseInt(req.get("user_id").toString());
            }catch (Exception e){
                res.put("code", -1);
                res.put("msg", "非法删除News请求，请完善用户信息" + e);
                return res;
            }

            NewsModel newsModel = new NewsModel(newsMapper.getNewsById(news_id));

            // 本人可以直接删除
            if (newsModel.publisherInfo.id == user_id){
                newsService.deleteById(news_id);
                res.put("code", 0);
                res.put("msg", "删除成功");
                return res;
            }else{
                UserModel publisherModel = userMapper.getUserById(newsModel.publisherInfo.id);
                UserModel requesterModel = userMapper.getUserById(user_id);

                // 非本人情况，需要请求者权限大于原发布人
                if (requesterModel.privilege > publisherModel.privilege){
                    newsService.deleteById(news_id);
                    res.put("code", 0);
                    res.put("msg", "代删除成功");
                    return res;
                }else{
                    res.put("code", -1);
                    res.put("msg", "权限不足，删除失败");
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

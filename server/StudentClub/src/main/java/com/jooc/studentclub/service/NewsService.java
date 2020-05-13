package com.jooc.studentclub.service;

import com.jooc.studentclub.mapper.NewsMapper;
import com.jooc.studentclub.mapper.UserMapper;
import com.jooc.studentclub.model.DBModel.DBNewsModel;
import com.jooc.studentclub.model.NewsModel;
import com.jooc.studentclub.model.UserInfoModel;
import com.jooc.studentclub.service.interfaces.NewsServiceInterface;
import com.jooc.studentclub.utils.FileManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

@Service
public class NewsService implements NewsServiceInterface {

    @Autowired
    public NewsMapper newsMapper;

    @Autowired
    public UserMapper userMapper;


    public Object getAllNews() {
        List<DBNewsModel> list = newsMapper.getAllNews();
        ArrayList<HashMap<String, Object>> resultList = pack(list);

        return resultList;
    }

    public Object getById(int id){
        try{
            NewsModel news = new NewsModel(newsMapper.getNewsById(id));
            return news;
        }catch (Exception e){
            HashMap<String, Object> res = new HashMap<>();
            res.put("code", -1);
            res.put("msg", "查无此项");
            return res;
        }
    }

    public Object getByPrivilege(int privilege) {
        List<DBNewsModel> list = newsMapper.getNewsByPrivilege(privilege);
        ArrayList<HashMap<String, Object>> resultList = pack(list);

        return resultList;
    }

    public Object getByUserId(int id) {
        List<DBNewsModel> list = newsMapper.getNewsByUserId(id);
        ArrayList<HashMap<String, Object>> resultList = pack(list);

        return resultList;
    }


    @Override
    public Object publish(HashMap<String, Object> req, MultipartFile[] files) throws IOException {
        DBNewsModel dbNewsModel = new DBNewsModel();

        // TODO: Generate id
        dbNewsModel.id = Integer.parseInt((String) req.get("title"));

        Date d = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        dbNewsModel.post_time = sdf.format(d);

        dbNewsModel.title = (String) req.get("title");
        dbNewsModel.content = (String) req.get("content");

        FileManager fileManager;
        String images = "";

        int invalid = 0;
        for (MultipartFile uploadedFile : files){
            String img[] = {"bmp", "jpg", "jpeg", "png", "heic"};
            int i;
            for (i = 0; i < img.length; i++){
                String oldName = uploadedFile.getOriginalFilename();
                String suffix = oldName.substring(oldName.lastIndexOf(".") + 1);
                if (suffix.toLowerCase().equals(img[i])){
                    break;
                }
            }
            if(i >= img.length){
                invalid = 1;
                break;
            }
        }
        if(invalid == 1){
            throw new IOException("格式不支持!");
        }
        fileManager = new FileManager("news_images");
        images += fileManager.save(files);
        fileManager.close();

        dbNewsModel.images = images;

        try {
            dbNewsModel.publisher_id = Integer.parseInt(req.get("publisher_id").toString());
        }catch (Exception e){
            dbNewsModel.publisher_id = -1;
        }
        if (dbNewsModel.publisher_id == -1){
            dbNewsModel.publisher_name = "";
            dbNewsModel.publisher_avatar = "";
        } else{
            UserInfoModel userInfo = userMapper.getUserInfoById(dbNewsModel.publisher_id);
            dbNewsModel.publisher_name = userInfo.name;
            dbNewsModel.publisher_avatar = userInfo.avatar;
        }

        // TODO: generate tags
        dbNewsModel.tags = (String) req.get("tags");

        dbNewsModel.privilege = Integer.parseInt(req.get("privilege").toString());

        newsMapper.insertNews(dbNewsModel);

        NewsModel news = new NewsModel(dbNewsModel);
        return news;
    }

    @Override
    public Object deleteById(int id) {
        HashMap<String, Object> res = new HashMap<>();
        try{
            newsMapper.deleteById(id);
            res.put("code", 0);
            res.put("msg", "删除成功");
        }catch (Exception e){
            res.put("cpde", -1);
            res.put("msg", "删除失败" + e.getMessage());
        }
        return res;
    }


    public static ArrayList<HashMap<String, Object>> pack(List<DBNewsModel> list){
        ArrayList<HashMap<String, Object>> resultList = new ArrayList<>();

        for(DBNewsModel dbNewsModel : list){
            HashMap<String, Object> newsObject = new HashMap<>();

            NewsModel news = new NewsModel(dbNewsModel);

            newsObject.put("news", news);
            resultList.add(newsObject);
        }

        return resultList;
    }

}

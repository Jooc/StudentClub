package com.jooc.studentclub.model;

import com.jooc.studentclub.model.DBModel.DBNewsModel;
import com.jooc.studentclub.utils.Common;

public class NewsModel {
    int id;
    public String postTime;
    public String title;
    public String content;
    public String[] images;
//    public String video;
    public int privilege;

    public UserInfoModel publisherInfo;

    public String tags;

    public NewsModel(DBNewsModel dbNewsModel){
        this.id = dbNewsModel.id;
        this.postTime = dbNewsModel.post_time;
        this.title = dbNewsModel.title;
        this.content = dbNewsModel.content;

        this.images = dbNewsModel.images.split(";");
        for (int i = 0; i < images.length; i++){
            this.images[i] = Common.oss_path + this.images[i];
        }
        this.privilege = dbNewsModel.privilege;
        this.publisherInfo = new UserInfoModel(dbNewsModel.publisher_id, dbNewsModel.publisher_name, dbNewsModel.publisher_avatar);
        this.tags = dbNewsModel.tags;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getPostTime() {
        return postTime;
    }

    public void setPostTime(String postTime) {
        this.postTime = postTime;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String[] getImages() {
        return images;
    }

    public void setImages(String[] images) {
        this.images = images;
    }

    public int getPrivilege() {
        return privilege;
    }

    public void setPrivilege(int privilege) {
        this.privilege = privilege;
    }

    public UserInfoModel getPublisherInfo() {
        return publisherInfo;
    }

    public void setPublisherInfo(UserInfoModel publisherInfo) {
        this.publisherInfo = publisherInfo;
    }

    public String getTags() {
        return tags;
    }

    public void setTags(String tags) {
        this.tags = tags;
    }
}

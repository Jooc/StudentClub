package com.jooc.studentclub.model;

import com.jooc.studentclub.model.DBModel.DBBlogModel;

public class BlogModel {

    public int id;
    public String postTime;
    public String url;

    public UserInfoModel publisherInfo;
    public int privilege;

    public String tags;

    public BlogModel(DBBlogModel dbBlogModel){
        this.id = dbBlogModel.id;
        this.postTime = dbBlogModel.post_time;
        this.url = dbBlogModel.url;

        this.publisherInfo = new UserInfoModel(dbBlogModel.publisher_id, dbBlogModel.publisher_name, dbBlogModel.publisher_avatar);
        this.privilege = dbBlogModel.privilege;
        this.tags = dbBlogModel.tags;
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

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public UserInfoModel getPublisherInfo() {
        return publisherInfo;
    }

    public void setPublisherInfo(UserInfoModel publisherInfo) {
        this.publisherInfo = publisherInfo;
    }

    public int getPrivilege() {
        return privilege;
    }

    public void setPrivilege(int privilege) {
        this.privilege = privilege;
    }

    public String getTags() {
        return tags;
    }

    public void setTags(String tags) {
        this.tags = tags;
    }
}
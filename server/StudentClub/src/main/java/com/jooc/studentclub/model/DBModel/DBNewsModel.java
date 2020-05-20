package com.jooc.studentclub.model.DBModel;


public class DBNewsModel{

    public int id;
    public String post_time;
    public String title;
    public String content;
    public String images;
    // public String video;
    public int publisher_id;
    public String publisher_name;
    public String publisher_avatar;
    public int publisher_privilege;


    public String tags;
    public int privilege;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getPost_time() {
        return post_time;
    }

    public void setPost_time(String post_time) {
        this.post_time = post_time;
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

    public String getImages() {
        return images;
    }

    public void setImages(String images) {
        this.images = images;
    }

    public int getPublisher_id() {
        return publisher_id;
    }

    public void setPublisher_id(int publisher_id) {
        this.publisher_id = publisher_id;
    }

    public String getPublisher_name() {
        return publisher_name;
    }

    public void setPublisher_name(String publisher_name) {
        this.publisher_name = publisher_name;
    }

    public String getPublisher_avatar() {
        return publisher_avatar;
    }

    public void setPublisher_avatar(String publisher_avatar) {
        this.publisher_avatar = publisher_avatar;
    }

    public int getPublisher_privilege() {
        return publisher_privilege;
    }

    public void setPublisher_privilege(int publisher_privilege) {
        this.publisher_privilege = publisher_privilege;
    }

    public String getTags() {
        return tags;
    }

    public void setTags(String tags) {
        this.tags = tags;
    }

    public int getPrivilege() {
        return privilege;
    }

    public void setPrivilege(int privilege) {
        this.privilege = privilege;
    }
}
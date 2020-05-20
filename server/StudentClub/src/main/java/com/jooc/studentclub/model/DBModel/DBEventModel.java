package com.jooc.studentclub.model.DBModel;

public class DBEventModel {

    public int id;
    public String title;
    public String location;
    public String start_date;
    public String end_date;
    public String url;
    public String notes;
    public int club_code;
    public String participant;
    // MARK: 1代表开放，0代表不开放
    public int open_or_not;

    public DBEventModel(int id, String title, String location, String start_date, String end_date, String url, String notes, int club_code, String participant, int open_or_not) {
        this.id = id;
        this.title = title;
        this.location = location;
        this.start_date = start_date;
        this.end_date = end_date;
        this.url = url;
        this.notes = notes;
        this.club_code = club_code;
        this.participant = participant;
        this.open_or_not = open_or_not;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getStart_date() {
        return start_date;
    }

    public void setStart_date(String start_date) {
        this.start_date = start_date;
    }

    public String getEnd_date() {
        return end_date;
    }

    public void setEnd_date(String end_date) {
        this.end_date = end_date;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public int getClub_code() {
        return club_code;
    }

    public void setClub_code(int club_code) {
        this.club_code = club_code;
    }

    public String getParticipant() {
        return participant;
    }

    public void setParticipant(String participant) {
        this.participant = participant;
    }

    public int getOpen_or_not() {
        return open_or_not;
    }

    public void setOpen_or_not(int open_or_not) {
        this.open_or_not = open_or_not;
    }
}

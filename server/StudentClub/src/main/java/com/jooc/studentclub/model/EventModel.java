package com.jooc.studentclub.model;

import com.jooc.studentclub.model.DBModel.DBEventModel;

public class EventModel {

    public int id;
    public String title;
    public String location;
    public String startDate;
    public String endDate;
    public String url;
    public String notes;
    public int clubCode;
    public String participant;
    // MARK: 1代表开放，0代表不开放
    public int openOrNot;

    public EventModel(int id, String title, String location, String startDate, String endDate, String url, String notes, int clubCode, String participant, int openOrNot) {
        this.id = id;
        this.title = title;
        this.location = location;
        this.startDate = startDate;
        this.endDate = endDate;
        this.url = url;
        this.notes = notes;
        this.clubCode = clubCode;
        this.participant = participant;
        this.openOrNot = openOrNot;
    }

    public EventModel(DBEventModel db) {
        this.id = db.id;
        this.title = db.title;
        this.location = db.location;
        this.startDate = db.start_date;
        this.endDate = db.end_date;
        this.url = db.url;
        this.notes = db.notes;
        this.clubCode = db.club_code;
        this.participant = db.participant;
        this.openOrNot = db.open_or_not;
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

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
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

    public int getClubCode() {
        return clubCode;
    }

    public void setClubCode(int clubCode) {
        this.clubCode = clubCode;
    }

    public String getParticipant() {
        return participant;
    }

    public void setParticipant(String participant) {
        this.participant = participant;
    }

    public int getOpenOrNot() {
        return openOrNot;
    }

    public void setOpenOrNot(int openOrNot) {
        this.openOrNot = openOrNot;
    }
}

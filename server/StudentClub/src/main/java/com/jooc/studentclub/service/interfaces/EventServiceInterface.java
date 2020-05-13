package com.jooc.studentclub.service.interfaces;

import java.util.HashMap;

public interface EventServiceInterface {

    Object getAllEvent();
    Object getEventByClubCode(int clubCode);
    Object getById(int id);
    Object createEvent(HashMap<String, Object> req);
    Object updateEvetn(HashMap<String, Object> req);
    Object deleteById(int id);

}

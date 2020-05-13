package com.jooc.studentclub.service.interfaces;

import java.util.HashMap;

public interface UserServiceInterface{

    Object getUserById(int id);
    Object getUserInfoById(int id);
    Object getIdByEmail(String email);

    Object register(HashMap<String, Object> req);
    Object login(HashMap<String, Object> req);

}
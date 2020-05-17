package com.jooc.studentclub.service.interfaces;

import java.util.HashMap;

public interface ClubServiceInterface {

    Object getAllClub();
    Object getByCode(int code);
    Object getClubByRegisterCode(String registerCode);
    Object add(HashMap<String, Object> req);
    Object remove(HashMap<String, Object> req);

    Object editDescription(HashMap<String, Object> req);

    Object addMember(HashMap<String, Object> req);
    Object removeMember(HashMap<String, Object> req);
    Object setAdvisor(HashMap<String, Object> req);
    Object setManager(HashMap<String, Object> req);

    Object getRegisterCodeByClubCode(int clubCode);
    Object getClubNameByRegisterCode(String registerCode);
    Object resetRegisterCode(HashMap<String, Object> req);
}

package com.jooc.studentclub.controller;

import com.jooc.studentclub.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;

@RestController
@RequestMapping("/user")
public class UserController {

    private UserService userService;

    @Autowired
    public UserController(UserService userService){
        this.userService = userService;
    }

    @GetMapping("/getUserById")
    public Object getUserById(int id){
        return userService.getUserById(id);
    }

    @PostMapping("/login")
    public Object login(@RequestBody HashMap<String, Object> req) throws InterruptedException{
        return userService.login(req);
    }

    @PostMapping("register")
    public Object register(@RequestBody HashMap<String, Object> req) throws InterruptedException{
        return userService.register(req);
    }

}

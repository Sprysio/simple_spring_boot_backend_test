package com.example.demo;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@CrossOrigin(origins = "http://localhost:3000",maxAge = 3600)
@RestController
@RequestMapping("/api")
public class HelloController {

    
    @GetMapping("/message")
    public String getMessage() {
        return "Hello from Spring Boot!";
    }
}

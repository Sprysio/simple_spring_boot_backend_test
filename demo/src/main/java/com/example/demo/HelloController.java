package com.example.demo;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api")
public class HelloController {

    
    @GetMapping("/api/message")
    public String getMessage() {
        return "Hello from Spring Boot!";
    }
}

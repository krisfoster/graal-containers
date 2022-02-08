package com.example.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.context.annotation.Bean;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.ApplicationContext;
import java.util.Arrays;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.beans.factory.annotation.Autowired;


@SpringBootApplication
@RestController
public class DemoApplication {

    @Autowired
    Jabberwocky j;

	public static void main(String[] args) {
		SpringApplication.run(DemoApplication.class, args);
	}

    @RequestMapping(method = RequestMethod.GET, path = "/jibber")
    ResponseEntity<String> jibber() {
        return ResponseEntity.ok(j.generate());
    }
}

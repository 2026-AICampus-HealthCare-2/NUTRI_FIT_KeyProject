package com.smhrd;

import java.nio.file.Paths;
import org.springframework.scheduling.annotation.EnableScheduling;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@EnableScheduling
@SpringBootApplication
public class TestApplication {

    public static void main(String[] args) {
        SpringApplication.run(TestApplication.class, args);
    }

}

@Configuration
class WebConfig implements WebMvcConfigurer {

    @Override
    public void addResourceHandlers(
            ResourceHandlerRegistry registry) {

        String uploadPath =
                Paths.get(
                    System.getProperty("user.dir"),
                    "uploads"
                )
                .toUri()
                .toString();

        registry
            .addResourceHandler("/images/supplement/**")
            .addResourceLocations(
                uploadPath + "/supplement/"
            );
    }
}
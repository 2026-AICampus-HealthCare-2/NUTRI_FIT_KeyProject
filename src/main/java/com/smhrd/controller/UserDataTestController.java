package com.smhrd.controller;

import com.smhrd.dto.AiUserData;
import com.smhrd.service.AiUserDataService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class UserDataTestController {

    private final AiUserDataService aiUserDataService;

    public UserDataTestController(
            AiUserDataService aiUserDataService
    ) {
        this.aiUserDataService = aiUserDataService;
    }

    @GetMapping("/ai/user-data")
    public AiUserData getUserData(
            @RequestParam Long userId
    ) {

        return aiUserDataService.getUserData(userId);
    }
}
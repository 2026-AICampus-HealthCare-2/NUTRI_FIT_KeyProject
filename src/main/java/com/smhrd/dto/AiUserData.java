package com.smhrd.dto;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class AiUserData {

    private Long userId;

    private String wakeUp;
    private String breakfast;
    private String lunch;
    private String dinner;
    private String bedtime;

    private List<AiSupplementData> supplements;
}
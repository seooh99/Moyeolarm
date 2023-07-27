package com.ssafy.moyeolam.domain.member.controller;

import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

@RestController
public class MemberController {

    @GetMapping("/loginSuccess")
    public ResponseEntity<Object> loginSuccess() {

        String nickname = "nicknameExample";
        Map<String, String> responseData = new HashMap<>();
        responseData.put("nickname", nickname);

        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization", "accessTokenExample");
        headers.add("Authorization-rest", "refreshTokenExample");

        return ResponseEntity.ok()
                .headers(headers)
                .body(responseData);
    }
}

package com.ssafy.moyeolam.domain.member.controller;

import com.ssafy.moyeolam.domain.auth.dto.PrincipalDetails;
import com.ssafy.moyeolam.domain.member.dto.ProfileImageDto;
import com.ssafy.moyeolam.domain.member.service.MemberService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;

@RestController
@RequiredArgsConstructor
public class MemberController {

    private final MemberService memberService;

    @PostMapping("/member/profileImage")
    public String uploadProfileImage(@AuthenticationPrincipal PrincipalDetails principal, ProfileImageDto profileImageDto) throws IOException {

        System.out.println(principal);
        try {
            String username = principal.getUsername();
            System.out.println("유저 이름: " + username);
            memberService.findByOauthIdentifier(username)
                    .ifPresent(member ->{
                        try {
                            memberService.saveProfileImage(member, profileImageDto);
                        } catch (IOException e) {
                            throw new RuntimeException(e);
                        }
                    });
        } catch (NullPointerException e) {
            System.out.println("에러 발생: " + e.getMessage());
        }
        return "redirect:/";
    }



    static class ResponseData {
        private int code;
        private String msg;
        private Data data;

        public ResponseData(int code, String msg, Data data) {
            this.code = code;
            this.msg = msg;
            this.data = data;
        }

        public int getCode() {
            return code;
        }

        public String getMsg() {
            return msg;
        }

        public Data getData() {
            return data;
        }
    }

    static class Data {
        private String nickname;

        public Data(String nickname) {
            this.nickname = nickname;
        }

        public String getNickname() {
            return nickname;
        }
    }

    @GetMapping("/loginSuccess")
    public ResponseEntity<Object> loginSuccess() {
        // JSON 데이터를 생성하거나 가져오는 작업 수행
        String nickname = "nicknameExample";

        // 데이터 객체 생성
        Data data = new Data(nickname);

        // ResponseData 객체 생성
        ResponseData responseData = new ResponseData(200, "success", data);

        // 응답 헤더에 추가할 값을 설정
        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization", "accessTokenExample");
        headers.add("Authorization-rest", "refreshTokenExample");

        // ResponseEntity 생성
        return ResponseEntity.ok()
                .headers(headers)
                .body(responseData);
    }
}

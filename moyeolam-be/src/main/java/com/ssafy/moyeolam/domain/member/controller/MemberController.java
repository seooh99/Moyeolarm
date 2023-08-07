package com.ssafy.moyeolam.domain.member.controller;

import com.ssafy.moyeolam.domain.auth.dto.PrincipalDetails;
import com.ssafy.moyeolam.domain.member.domain.Member;
import com.ssafy.moyeolam.domain.member.dto.SaveNicknameRequestDto;
import com.ssafy.moyeolam.domain.member.dto.SearchMembereResponseDto;
import com.ssafy.moyeolam.domain.member.dto.UploadProfileImageRequestDto;
import com.ssafy.moyeolam.domain.member.dto.UploadProfileImageResponseDto;
import com.ssafy.moyeolam.domain.member.exception.MemberErrorInfo;
import com.ssafy.moyeolam.domain.member.exception.MemberException;
import com.ssafy.moyeolam.domain.member.service.MemberService;
import com.ssafy.moyeolam.global.common.response.EnvelopeResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;

@RestController
@RequiredArgsConstructor
public class MemberController {

    private final MemberService memberService;

    @PostMapping("/member/profileImage")
    public EnvelopeResponse<UploadProfileImageResponseDto> uploadProfileImage(@AuthenticationPrincipal PrincipalDetails principal, @RequestBody UploadProfileImageRequestDto uploadProfileImageRequestDto) throws IOException {

        Member member = principal.getMember();

        return EnvelopeResponse.<UploadProfileImageResponseDto>builder()
                .data(memberService.uploadProfileImage(member, uploadProfileImageRequestDto))
                .build();
    }

    @DeleteMapping("/member/profileImage")
    public EnvelopeResponse<Long> deleteProfileImage(@AuthenticationPrincipal PrincipalDetails principal){

        Member member = principal.getMember();

        return EnvelopeResponse.<Long>builder()
                .data(memberService.deleteProfileImage(member))
                .build();
    }

    @PostMapping("/member/nickname")
    public EnvelopeResponse<Long> saveNickname(@AuthenticationPrincipal PrincipalDetails principal, @RequestBody SaveNicknameRequestDto saveNicknameRequestDto){

        if (principal==null){
            throw new MemberException(MemberErrorInfo.NOT_FOUND_MEMBER);
        }

        Member member = principal.getMember();

        return EnvelopeResponse.<Long>builder()
                .data(memberService.saveNickname(member, saveNicknameRequestDto))
                .build();
    }

    @GetMapping("/member")
    public EnvelopeResponse<SearchMembereResponseDto> searchMember(@AuthenticationPrincipal PrincipalDetails principal, @RequestParam String keyword){

        return EnvelopeResponse.<SearchMembereResponseDto>builder()
                .data(memberService.searchMember(keyword))
                .build();

    }

    @DeleteMapping("/member")
    public EnvelopeResponse<Long> deleteMember(@AuthenticationPrincipal PrincipalDetails principal){

        Member member = principal.getMember();

        return EnvelopeResponse.<Long>builder()
                .data(memberService.deleteMember(member))
                .build();
    }


    //== 테스트 코드 ==//

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

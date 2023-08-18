package com.ssafy.moyeolam.domain.auth.dto;

import com.ssafy.moyeolam.domain.member.domain.Member;
import com.ssafy.moyeolam.domain.member.domain.ProfileImage;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class LoginResponseDto {
    private Long memberId;
    private String nickname;
    private String profileImageUrl;
    private String accessToken;
    private String refreshToken;

    public static LoginResponseDto of(Member member, ProfileImage profileImage, String accessToken, String refreshToken) {
        return LoginResponseDto.builder()
                .memberId(member.getId())
                .nickname(member.getNickname())
                .profileImageUrl(profileImage.getImageUrl())
                .accessToken(accessToken)
                .refreshToken(refreshToken)
                .build();
    }

}

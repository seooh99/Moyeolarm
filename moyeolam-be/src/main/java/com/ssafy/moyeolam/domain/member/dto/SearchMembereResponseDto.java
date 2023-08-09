package com.ssafy.moyeolam.domain.member.dto;

import com.ssafy.moyeolam.domain.member.domain.Member;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class SearchMembereResponseDto {
    private Long memberId;
    private String nickname;
    private String profileImageUrl;

    public static SearchMembereResponseDto from(Member member) {
        return SearchMembereResponseDto.builder()
                .memberId(member.getId())
                .nickname(member.getNickname())
                .profileImageUrl(member.getProfileImage().getImageUrl())
                .build();
    }
}

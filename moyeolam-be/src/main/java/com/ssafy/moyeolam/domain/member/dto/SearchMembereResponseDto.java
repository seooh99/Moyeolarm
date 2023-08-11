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
    private Boolean isFriend;

    public static SearchMembereResponseDto from(Member searchMember, Boolean isFriend) {
        return SearchMembereResponseDto.builder()
                .memberId(searchMember.getId())
                .nickname(searchMember.getNickname())
                .profileImageUrl(searchMember.getProfileImage().getImageUrl())
                .isFriend(isFriend)
                .build();
    }
}

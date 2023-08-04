package com.ssafy.moyeolam.domain.member.dto;

import com.ssafy.moyeolam.domain.member.domain.Member;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class MemberElement {

    private String nickname;
    private String imageUrl;

    public static MemberElement of(Member member){
        return MemberElement.builder()
                .nickname(member.getNickname())
                .imageUrl(member.getProfileImage() == null ? null : member.getProfileImage().getImageUrl())
                .build();
    }
}

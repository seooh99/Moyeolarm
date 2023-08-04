package com.ssafy.moyeolam.domain.member.dto;

import com.ssafy.moyeolam.domain.member.domain.ProfileImage;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class ProfileImageElement {

    private String imagePath;
    private String imageUrl;

    public static ProfileImageElement of(ProfileImage profileImage){
        return ProfileImageElement.builder()
                .imagePath(profileImage.getImagePath())
                .imageUrl(profileImage.getImageUrl())
                .build();
    }
}

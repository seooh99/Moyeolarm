package com.ssafy.moyeolam.domain.member.dto;

import com.ssafy.moyeolam.domain.member.domain.ProfileImage;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class UploadProfileImageResponseDto {

    private ProfileImageElement profileImage;

    public static UploadProfileImageResponseDto of(ProfileImage profileImage) {
        return UploadProfileImageResponseDto.builder()
                .profileImage(ProfileImageElement.of(profileImage))
                .build();
    }

}

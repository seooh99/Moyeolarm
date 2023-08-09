package com.ssafy.moyeolam.domain.auth.dto;

import lombok.Getter;
import lombok.Setter;

import javax.validation.constraints.NotNull;

@Getter
@Setter
public class LoginRequestDto {

    @NotNull
    private String oauthIdentifier;

    @NotNull
    private String fcmToken;

    @NotNull
    private String deviceIdentifier;

}

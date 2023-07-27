package com.ssafy.moyeolam.domain.auth.service.oauth2.provider;

public interface OAuth2UserInfo {
    String getProviderId();
    String getProvider();
    String getEmail();
    String getName();

}

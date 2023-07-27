package com.ssafy.moyeolam.domain.auth.service.oauth2.provider;

import java.util.Map;

public class KakaoUserInfo implements OAuth2UserInfo{

    private Map<String, Object> attributes;

    public KakaoUserInfo(Map<String, Object> attributes){
        this.attributes=attributes;
    }
    @Override
    public String getProviderId() {
        return (String) attributes.get("id").toString();
    }

    @Override
    public String getProvider() {
        return "Kakao";
    }

    @Override
    public String getEmail() {
        return (String) attributes.get("email");
    }

    @Override
    public String getName() {
        return null;
    }

}

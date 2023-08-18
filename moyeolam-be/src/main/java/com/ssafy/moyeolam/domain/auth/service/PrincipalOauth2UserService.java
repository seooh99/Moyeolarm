package com.ssafy.moyeolam.domain.auth.service;


import com.ssafy.moyeolam.domain.auth.dto.PrincipalDetails;
import com.ssafy.moyeolam.domain.auth.service.oauth2.provider.KakaoUserInfo;
import com.ssafy.moyeolam.domain.auth.service.oauth2.provider.OAuth2UserInfo;
import com.ssafy.moyeolam.domain.member.domain.Member;
import com.ssafy.moyeolam.domain.member.repository.MemberRepository;
import com.ssafy.moyeolam.domain.meta.domain.MetaDataType;
import com.ssafy.moyeolam.domain.meta.service.MetaDataService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
@RequiredArgsConstructor
public class PrincipalOauth2UserService extends DefaultOAuth2UserService {


    private final MemberRepository memberRepository;
    private final MetaDataService metaDataService;

    @Override
    public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {

        OAuth2User oAuth2User = super.loadUser(userRequest);

        String registrationId = userRequest.getClientRegistration().getRegistrationId();

        OAuth2UserInfo oAuth2UserInfo = null;
        if(registrationId.equals("kakao")){
//            System.out.println("카카오 로그인 요청");
            oAuth2UserInfo = new KakaoUserInfo(oAuth2User.getAttributes());
        }else if (registrationId.equals("google")){
            // ...
        }

        String provider = oAuth2UserInfo.getProvider(); // kakao
        String providerId = oAuth2UserInfo.getProviderId();
        String username = provider+"_"+providerId;  // kakao_123102401051349
        String email = oAuth2UserInfo.getEmail();
//      Role role = Role.GUEST;

        Optional<Member> memberOptional = memberRepository.findByOauthIdentifier(username);
        Member memberEntity = memberOptional.orElseGet(() -> {
            return Member.builder()
                    .oauthType(metaDataService.getMetaData(MetaDataType.OAUTH_TYPE.name(), provider))
                    .oauthIdentifier(username)
//                  .memberToken()
//                  .email(email)
//                  .role(role)
                    .build();
        });
        memberOptional.ifPresentOrElse(
                member -> {  },
                () -> memberRepository.save(memberEntity)
        );

        return new PrincipalDetails(memberEntity, oAuth2User.getAttributes());
    }
}

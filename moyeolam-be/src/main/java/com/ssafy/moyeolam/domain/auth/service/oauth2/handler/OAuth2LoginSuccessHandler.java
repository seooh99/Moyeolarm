package com.ssafy.moyeolam.domain.auth.service.oauth2.handler;

import com.ssafy.moyeolam.domain.auth.dto.PrincipalDetails;
import com.ssafy.moyeolam.domain.auth.service.jwt.JwtProvider.JwtProvider;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


@RequiredArgsConstructor
@Component
public class OAuth2LoginSuccessHandler implements AuthenticationSuccessHandler {

    private final JwtProvider jwtProvider;

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {

        PrincipalDetails principalDetails =(PrincipalDetails)authentication.getPrincipal();
        loginSuccess(response, principalDetails);
        response.sendRedirect("/");
    }

    private void loginSuccess(HttpServletResponse response, PrincipalDetails principalDetails) throws IOException {

        String accessToken = jwtProvider.createAccessToken(principalDetails.getUsername());
        String refreshToken = jwtProvider.createRefreshToken();
        response.addHeader(jwtProvider.getAccessHeader(), "Bearer " + accessToken);
        response.addHeader(jwtProvider.getRefreshHeader(), "Bearer " + refreshToken);

        jwtProvider.sendAccessAndRefreshToken(response, accessToken, refreshToken);
        jwtProvider.updateRefreshToken(principalDetails.getUsername(), refreshToken);

    }
}

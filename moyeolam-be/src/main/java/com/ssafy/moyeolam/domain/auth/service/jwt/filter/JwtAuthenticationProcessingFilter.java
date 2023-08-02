package com.ssafy.moyeolam.domain.auth.service.jwt.filter;


import com.ssafy.moyeolam.domain.auth.dto.PrincipalDetails;
import com.ssafy.moyeolam.domain.auth.service.jwt.JwtProvider.JwtProvider;
import com.ssafy.moyeolam.domain.member.domain.Member;
import com.ssafy.moyeolam.domain.member.repository.MemberRepository;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.mapping.GrantedAuthoritiesMapper;
import org.springframework.security.core.authority.mapping.NullAuthoritiesMapper;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.www.BasicAuthenticationFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Optional;


public class JwtAuthenticationProcessingFilter extends BasicAuthenticationFilter {

    private final JwtProvider jwtProvider;
    private final MemberRepository memberRepository;

    private final GrantedAuthoritiesMapper authoritiesMapper = new NullAuthoritiesMapper();

    private static final String BEARER = "Bearer";

    public JwtAuthenticationProcessingFilter(AuthenticationManager authenticationManager, JwtProvider jwtProvider, MemberRepository memberRepository) {
        super(authenticationManager);
        this.memberRepository = memberRepository;
        this.jwtProvider = jwtProvider;
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {

        String header = request.getHeader("Authorization");
        if(header == null || !header.startsWith("Bearer")) {
            filterChain.doFilter(request, response);
            return;
        }

        String refreshToken = jwtProvider.extractRefreshToken(request)
                .filter(jwtProvider::isTokenValid)
                .orElse(null);

        if(refreshToken != null){
            checkRefreshTokenAndReIssueAccessToken(response, refreshToken);
            return;
        }

        checkAccessTokenAndAuthentication(request, response, filterChain);
    }

    private void checkRefreshTokenAndReIssueAccessToken(HttpServletResponse response, String refreshToken) {
        memberRepository.findByRefreshToken(refreshToken)
                .ifPresent(member -> {
                    String reIssuedRefreshToken = reIssueRefreshToken(member);
                    jwtProvider.sendAccessAndRefreshToken(response, jwtProvider.createAccessToken(member.getOauthIdentifier()),
                            reIssuedRefreshToken);
                });
    }

    private String reIssueRefreshToken(Member member) {
        String reIssuedRefreshToken = jwtProvider.createRefreshToken();
        member.updateRefreshToken(reIssuedRefreshToken);
        memberRepository.saveAndFlush(member);
        return reIssuedRefreshToken;
    }


    private void checkAccessTokenAndAuthentication(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {

        Optional<String> token  = jwtProvider.extractAccessToken(request);
        if(token.isEmpty()){
            throw new RuntimeException("액세스토큰이 비어있습니다.");
        }
        jwtProvider.extractAccessToken(request)
                .filter(jwtProvider::isTokenValid)
                .ifPresent(accessToken -> jwtProvider.extractEmail(accessToken)
                        .ifPresent(username -> memberRepository.findByOauthIdentifier(username)
                                    .ifPresent(this::saveAuthentication)));

        filterChain.doFilter(request, response);
    }

    private void saveAuthentication(Member member) {

        PrincipalDetails principalDetails = new PrincipalDetails(member);

        Authentication authentication =
                new UsernamePasswordAuthenticationToken(principalDetails, null, authoritiesMapper.mapAuthorities(principalDetails.getAuthorities()));

        SecurityContextHolder.getContext().setAuthentication(authentication);
        }
}
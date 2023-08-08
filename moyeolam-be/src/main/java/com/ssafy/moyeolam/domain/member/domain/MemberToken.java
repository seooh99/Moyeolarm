package com.ssafy.moyeolam.domain.member.domain;

import com.ssafy.moyeolam.domain.BaseTimeEntity;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity(name = "member_token")
@Builder
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class MemberToken extends BaseTimeEntity {
    @Id
    @Column(name = "member_id")
    private Long id;

    @Column
    private String acessToken;

    @Column
    private String refreshToken;

    @OneToOne(fetch = FetchType.LAZY)
    @MapsId
    @JoinColumn(name = "member_id")
    private Member member;

    public void setMember(Member member) {
        this.member = member;
    }

    public void setRefreshToken(String refreshToken) {
        this.refreshToken = refreshToken;
    }

    public void setAccessToken(String accessToken){ this.acessToken = accessToken;}
}

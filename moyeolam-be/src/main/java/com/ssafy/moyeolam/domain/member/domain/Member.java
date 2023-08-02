package com.ssafy.moyeolam.domain.member.domain;

import com.ssafy.moyeolam.domain.BaseTimeEntity;
import com.ssafy.moyeolam.domain.friend.domain.Friend;
import com.ssafy.moyeolam.domain.meta.converter.OauthTypeConverter;
import com.ssafy.moyeolam.domain.meta.domain.MetaData;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity(name = "member")
@Builder
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class Member extends BaseTimeEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "member_id")
    private Long id;

    @Convert(converter = OauthTypeConverter.class)
    private MetaData oauthType;

    @OneToOne(cascade = CascadeType.ALL, mappedBy = "member")
    private MemberToken memberToken;

    @Column
    private String oauthIdentifier;

    @Column
    private String fcmToken;

    @Column
    private String nickname;

    @OneToMany(mappedBy = "member")
    private List<Friend> friends = new ArrayList<>();

    @OneToOne(mappedBy = "member")
    private ProfileImage profileImage;

    public void updateRefreshToken(String updateRefreshToken) {
        if (this.memberToken == null) {
            this.memberToken = new MemberToken();
            this.memberToken.setMember(this);
        }
        this.memberToken.setRefreshToken(updateRefreshToken);
    }

    public void setNickname(String nickname){
        this.nickname=nickname;
    }
}

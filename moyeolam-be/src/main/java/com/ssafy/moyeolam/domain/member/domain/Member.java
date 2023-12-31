package com.ssafy.moyeolam.domain.member.domain;

import com.ssafy.moyeolam.domain.BaseTimeEntity;
import com.ssafy.moyeolam.domain.alarmgroup.domain.AlarmGroup;
import com.ssafy.moyeolam.domain.alarmgroup.domain.AlarmGroupMember;
import com.ssafy.moyeolam.domain.friend.domain.Friend;
import com.ssafy.moyeolam.domain.friend.domain.FriendRequest;
import com.ssafy.moyeolam.domain.meta.converter.OauthTypeConverter;
import com.ssafy.moyeolam.domain.meta.domain.MetaData;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

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
    private String nickname;

    @Builder.Default
    @Column
    private Boolean notificationToggle = Boolean.TRUE;

    @Builder.Default
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "member")
    private List<Friend> friends = new ArrayList<>();

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "myFriend")
    private List<Friend> friendsOfMine;

    @OneToOne(cascade = CascadeType.ALL, mappedBy = "member")
    private ProfileImage profileImage;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "hostMember")
    private List<AlarmGroup> alarmGroup;

    @Builder.Default
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "member")
    private Set<FcmToken> fcmTokens = new HashSet<>();

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "fromMember")
    private List<FriendRequest> sentFriendRequests;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "toMember")
    private List<FriendRequest> receivedFriendRequests;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "member")
    private List<AlarmGroupMember> alarmGroupMembers;

    public void updateRefreshToken(String updateRefreshToken) {
        if (this.memberToken == null) {
            this.memberToken = new MemberToken();
            this.memberToken.setMember(this);
        }
        this.memberToken.setRefreshToken(updateRefreshToken);
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public void setMemberToken(MemberToken memberToken) {
        this.memberToken = memberToken;
    }

    public void setNotificationToggle(Boolean notificationToggle) {
        this.notificationToggle = notificationToggle;
    }
}

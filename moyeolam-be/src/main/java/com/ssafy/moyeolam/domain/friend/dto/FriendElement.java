package com.ssafy.moyeolam.domain.friend.dto;

import com.ssafy.moyeolam.domain.friend.domain.Friend;
import com.ssafy.moyeolam.domain.member.domain.ProfileImage;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class FriendElement {
    private Long memberId;
    private String nickname;
    private String profileImageUrl;

    public static FriendElement from(Friend friend) {
        ProfileImage profileImage = friend.getMyFriend().getProfileImage();

        return FriendElement.builder()
                .memberId(friend.getMyFriend().getId())
                .nickname(friend.getMyFriend().getNickname())
                .profileImageUrl(profileImage != null ? profileImage.getImageUrl() : null)
                .build();
    }
}

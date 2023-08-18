package com.ssafy.moyeolam.domain.friend.dto;

import com.ssafy.moyeolam.domain.friend.domain.Friend;
import lombok.Builder;
import lombok.Getter;

import java.util.List;
import java.util.stream.Collectors;

@Getter
@Builder
public class FindFriendsResponseDto {
    private List<FriendElement> friends;

    public static FindFriendsResponseDto from(List<Friend> friends) {
        return FindFriendsResponseDto.builder()
                .friends(friends.stream()
                        .map(FriendElement::from)
                        .collect(Collectors.toList()))
                .build();
    }
}

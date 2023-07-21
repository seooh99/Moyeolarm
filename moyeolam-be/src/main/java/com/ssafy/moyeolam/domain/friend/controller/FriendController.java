package com.ssafy.moyeolam.domain.friend.controller;

import com.ssafy.moyeolam.domain.friend.service.FriendService;
import com.ssafy.moyeolam.domain.member.dto.AuthenticatedMember;
import com.ssafy.moyeolam.global.common.response.EnvelopeResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/friends")
@RequiredArgsConstructor
@Slf4j
public class FriendController {
    private final FriendService friendService;

    @PostMapping("/{memberId}/request")
    public EnvelopeResponse<Long> requestFriendRequest(@PathVariable Long memberId) {
        AuthenticatedMember loginMember = AuthenticatedMember.builder()
                .memberId(1L)
                .build();

        return EnvelopeResponse.<Long>builder()
                .data(friendService.requestFriendRequest(loginMember.getMemberId(), memberId))
                .build();
    }
}

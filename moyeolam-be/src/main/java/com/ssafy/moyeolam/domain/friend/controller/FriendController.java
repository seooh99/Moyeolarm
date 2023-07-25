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
    public EnvelopeResponse<Long> sendFriendRequest(@PathVariable Long memberId) {
        AuthenticatedMember loginMember = AuthenticatedMember.builder()
                .memberId(1L)
                .build();

        return EnvelopeResponse.<Long>builder()
                .data(friendService.sendFriendRequest(loginMember.getMemberId(), memberId))
                .build();
    }

    @PostMapping("/{friendRequestId}/approve")
    public EnvelopeResponse<Void> approveFriendRequest(@PathVariable Long friendRequestId) {
        AuthenticatedMember loginMember = AuthenticatedMember.builder()
                .memberId(1L)
                .build();

        return EnvelopeResponse.<Void>builder()
                .data(friendService.approveFriendRequest(loginMember.getMemberId(), friendRequestId))
                .build();
    }

    @PostMapping("/{friendRequestId}/reject")
    public EnvelopeResponse<Void> rejectFriendRequest(@PathVariable Long friendRequestId) {
        AuthenticatedMember loginMember = AuthenticatedMember.builder()
                .memberId(1L)
                .build();

        return EnvelopeResponse.<Void>builder()
                .data(friendService.rejectFriendRequest(loginMember.getMemberId(), friendRequestId))
                .build();
    }
}

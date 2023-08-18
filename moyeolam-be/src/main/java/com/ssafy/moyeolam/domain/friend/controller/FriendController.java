package com.ssafy.moyeolam.domain.friend.controller;

import com.ssafy.moyeolam.domain.auth.dto.PrincipalDetails;
import com.ssafy.moyeolam.domain.friend.dto.FindFriendsResponseDto;
import com.ssafy.moyeolam.domain.friend.service.FriendService;
import com.ssafy.moyeolam.domain.member.dto.AuthenticatedMember;
import com.ssafy.moyeolam.domain.member.exception.MemberErrorInfo;
import com.ssafy.moyeolam.domain.member.exception.MemberException;
import com.ssafy.moyeolam.global.common.response.EnvelopeResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/friends")
@RequiredArgsConstructor
@Slf4j
public class FriendController {
    private final FriendService friendService;

    @PostMapping("/{memberId}/request")
    public EnvelopeResponse<Long> sendFriendRequest(@PathVariable Long memberId, @AuthenticationPrincipal PrincipalDetails principalDetails) {
        if (principalDetails == null) {
            throw new MemberException(MemberErrorInfo.NOT_FOUND_MEMBER);
        }

        return EnvelopeResponse.<Long>builder()
                .data(friendService.sendFriendRequest(principalDetails.getMember().getId(), memberId))
                .build();
    }

    @PostMapping("/{friendRequestId}/approve")
    public EnvelopeResponse<Void> approveFriendRequest(@PathVariable Long friendRequestId, @AuthenticationPrincipal PrincipalDetails principalDetails) {
        if (principalDetails == null) {
            throw new MemberException(MemberErrorInfo.NOT_FOUND_MEMBER);
        }

        return EnvelopeResponse.<Void>builder()
                .data(friendService.approveFriendRequest(principalDetails.getMember().getId(), friendRequestId))
                .build();
    }

    @PostMapping("/{friendRequestId}/reject")
    public EnvelopeResponse<Void> rejectFriendRequest(@PathVariable Long friendRequestId, @AuthenticationPrincipal PrincipalDetails principalDetails) {
        if (principalDetails == null) {
            throw new MemberException(MemberErrorInfo.NOT_FOUND_MEMBER);
        }

        return EnvelopeResponse.<Void>builder()
                .data(friendService.rejectFriendRequest(principalDetails.getMember().getId(), friendRequestId))
                .build();
    }

    @GetMapping
    public EnvelopeResponse<FindFriendsResponseDto> findFriends(@AuthenticationPrincipal PrincipalDetails principalDetails) {
        if (principalDetails == null) {
            throw new MemberException(MemberErrorInfo.NOT_FOUND_MEMBER);
        }

        return EnvelopeResponse.<FindFriendsResponseDto>builder()
                .data(friendService.findFriends(principalDetails.getMember().getId()))
                .build();
    }

    @DeleteMapping("/{myFriendId}")
    public EnvelopeResponse<Void> deleteFriend(@PathVariable Long myFriendId, @AuthenticationPrincipal PrincipalDetails principalDetails) {
        if (principalDetails == null) {
            throw new MemberException(MemberErrorInfo.NOT_FOUND_MEMBER);
        }

        return EnvelopeResponse.<Void>builder()
                .data(friendService.deleteFriend(principalDetails.getMember().getId(), myFriendId))
                .build();
    }

    @GetMapping("/search")
    public EnvelopeResponse<FindFriendsResponseDto> searchFriends(@RequestParam String keyword, @AuthenticationPrincipal PrincipalDetails principalDetails) {
        if (principalDetails == null) {
            throw new MemberException(MemberErrorInfo.NOT_FOUND_MEMBER);
        }

        return EnvelopeResponse.<FindFriendsResponseDto>builder()
                .data(friendService.searchFriends(principalDetails.getMember().getId(), keyword))
                .build();
    }
}

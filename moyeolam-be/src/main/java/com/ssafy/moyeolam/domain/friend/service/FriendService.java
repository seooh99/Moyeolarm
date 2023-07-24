package com.ssafy.moyeolam.domain.friend.service;

import com.ssafy.moyeolam.domain.friend.domain.Friend;
import com.ssafy.moyeolam.domain.friend.domain.FriendRequest;
import com.ssafy.moyeolam.domain.friend.exception.FriendErrorInfo;
import com.ssafy.moyeolam.domain.friend.exception.FriendException;
import com.ssafy.moyeolam.domain.friend.repository.FriendRepository;
import com.ssafy.moyeolam.domain.friend.repository.FriendRequestRepository;
import com.ssafy.moyeolam.domain.member.domain.Member;
import com.ssafy.moyeolam.domain.member.repository.MemberRepository;
import com.ssafy.moyeolam.domain.meta.domain.MatchStatus;
import com.ssafy.moyeolam.domain.meta.domain.MetaDataType;
import com.ssafy.moyeolam.domain.meta.service.MetaDataService;
import com.ssafy.moyeolam.global.common.exception.GlobalErrorInfo;
import com.ssafy.moyeolam.global.common.exception.GlobalException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.Optional;
import java.util.function.Consumer;

@Service
@RequiredArgsConstructor
@Slf4j
public class FriendService {
    private final MetaDataService metaDataService;
    private final MemberRepository memberRepository;
    private final FriendRepository friendRepository;
    private final FriendRequestRepository friendRequestRepository;

    @Transactional
    public Long sendFriendRequest(Long loginMemberId, Long toMemberId) {

        /**
         * TODO: memberException으로 변경
         */
        Member loginMember = memberRepository.findById(loginMemberId)
                .orElseThrow(() -> new GlobalException(GlobalErrorInfo.INTERNAL_SERVER_ERROR));

        Member toMember = memberRepository.findById(toMemberId)
                .orElseThrow(() -> new GlobalException(GlobalErrorInfo.INTERNAL_SERVER_ERROR));

        Consumer<FriendRequest> friendRequestStatusValidator = friendRequest -> {
            String matchStatusName = friendRequest.getMatchStatus().getName();

            if (matchStatusName.equals(MatchStatus.REQUEST_STATUS.getName()))
                throw new FriendException(FriendErrorInfo.ALREADY_REQUEST_STATUS);
            if (matchStatusName.equals(MatchStatus.APPROVE_STATUS.getName()))
                throw new FriendException(FriendErrorInfo.ALREADY_APPROVE_STATUS);
        };

        Optional<FriendRequest> fromToFriendRequestOptional = friendRequestRepository.findByFromMemberIdAndToMemberId(loginMemberId, toMemberId);
        Optional<FriendRequest> toFromFriendRequestOptional = friendRequestRepository.findByFromMemberIdAndToMemberId(toMemberId, loginMemberId);

        fromToFriendRequestOptional.ifPresent(friendRequestStatusValidator);
        toFromFriendRequestOptional.ifPresent(friendRequestStatusValidator);

        if (fromToFriendRequestOptional.isEmpty()) {
            FriendRequest friendRequest = FriendRequest.builder()
                    .fromMember(loginMember)
                    .toMember(toMember)
                    .matchStatus(metaDataService.getMetaData(MetaDataType.MATCH_STATUS.name(), MatchStatus.REQUEST_STATUS.getName()))
                    .build();
            friendRequestRepository.save(friendRequest);
            return friendRequest.getId();
        }

        FriendRequest fromToFriendRequest = fromToFriendRequestOptional.get();
        fromToFriendRequest.updateMatchStatus(metaDataService.getMetaData(MetaDataType.MATCH_STATUS.name(), MatchStatus.REQUEST_STATUS.getName()));
        return fromToFriendRequest.getId();
    }

    @Transactional
    public Void approveFriendRequest(Long loginMemberId, Long friendRequestId) {

        /**
         * TODO: memberException으로 변경
         */
        Member loginMember = memberRepository.findById(loginMemberId)
                .orElseThrow(() -> new GlobalException(GlobalErrorInfo.INTERNAL_SERVER_ERROR));

        FriendRequest friendRequest = friendRequestRepository.findById(friendRequestId)
                .orElseThrow(() -> new FriendException(FriendErrorInfo.NOT_FOUND_FRIEND_REQUEST));

        /**
         * TODO: memberException으로 변경
         */
        Member fromMember = memberRepository.findById(friendRequest.getFromMember().getId())
                .orElseThrow(() -> new GlobalException(GlobalErrorInfo.INTERNAL_SERVER_ERROR));

        if (!loginMemberId.equals(friendRequest.getToMember().getId()))
            throw new FriendException(FriendErrorInfo.NOT_REQUESTED_USER);

        if (!friendRequest.getMatchStatus().equals(metaDataService.getMetaData(MetaDataType.MATCH_STATUS.name(), MatchStatus.REQUEST_STATUS.getName())))
            throw new FriendException(FriendErrorInfo.NOT_REQUEST_STATUS);

        friendRequest.updateMatchStatus(metaDataService.getMetaData(MetaDataType.MATCH_STATUS.name(), MatchStatus.APPROVE_STATUS.getName()));

        Friend fromToFriend = Friend.builder()
                .member(fromMember)
                .myFriend(loginMember)
                .build();
        friendRepository.save(fromToFriend);

        Friend toFromFriend = Friend.builder()
                .member(loginMember)
                .myFriend(fromMember)
                .build();
        friendRepository.save(toFromFriend);

        return null;
    }
}

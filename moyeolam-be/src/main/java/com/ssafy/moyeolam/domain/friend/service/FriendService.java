package com.ssafy.moyeolam.domain.friend.service;

import com.ssafy.moyeolam.domain.alert.domain.AlertLog;
import com.ssafy.moyeolam.domain.alert.repository.AlertLogRepository;
import com.ssafy.moyeolam.domain.friend.domain.Friend;
import com.ssafy.moyeolam.domain.friend.domain.FriendRequest;
import com.ssafy.moyeolam.domain.friend.dto.FindFriendsResponseDto;
import com.ssafy.moyeolam.domain.friend.exception.FriendErrorInfo;
import com.ssafy.moyeolam.domain.friend.exception.FriendException;
import com.ssafy.moyeolam.domain.friend.repository.FriendRepository;
import com.ssafy.moyeolam.domain.friend.repository.FriendRequestRepository;
import com.ssafy.moyeolam.domain.member.domain.Member;
import com.ssafy.moyeolam.domain.member.exception.MemberErrorInfo;
import com.ssafy.moyeolam.domain.member.exception.MemberException;
import com.ssafy.moyeolam.domain.member.repository.MemberRepository;
import com.ssafy.moyeolam.domain.meta.domain.AlertType;
import com.ssafy.moyeolam.domain.meta.domain.MatchStatus;
import com.ssafy.moyeolam.domain.meta.domain.MetaDataType;
import com.ssafy.moyeolam.domain.meta.service.MetaDataService;
import com.ssafy.moyeolam.domain.notification.service.NotificationService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.function.Consumer;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Slf4j
public class FriendService {
    private final MetaDataService metaDataService;
    private final MemberRepository memberRepository;
    private final FriendRepository friendRepository;
    private final FriendRequestRepository friendRequestRepository;
    private final AlertLogRepository alertLogRepository;
    private final NotificationService notificationService;

    @Transactional
    public Long sendFriendRequest(Long loginMemberId, Long toMemberId) {
        Member loginMember = memberRepository.findById(loginMemberId)
                .orElseThrow(() -> new MemberException(MemberErrorInfo.NOT_FOUND_MEMBER));

        Member toMember = memberRepository.findById(toMemberId)
                .orElseThrow(() -> new MemberException(MemberErrorInfo.NOT_FOUND_MEMBER));

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

        // 푸시알림 전송
        String body = loginMember.getNickname() + " 님이 친구를 요청하였습니다.";
        notificationService.sendNotification(toMember, body, AlertType.FRIEND_REQUEST.getName());

        return fromToFriendRequest.getId();
    }

    @Transactional
    public Void approveFriendRequest(Long loginMemberId, Long friendRequestId) {
        Member loginMember = memberRepository.findById(loginMemberId)
                .orElseThrow(() -> new MemberException(MemberErrorInfo.NOT_FOUND_MEMBER));

        FriendRequest friendRequest = friendRequestRepository.findById(friendRequestId)
                .orElseThrow(() -> new FriendException(FriendErrorInfo.NOT_FOUND_FRIEND_REQUEST));

        Member fromMember = memberRepository.findById(friendRequest.getFromMember().getId())
                .orElseThrow(() -> new MemberException(MemberErrorInfo.NOT_FOUND_MEMBER));

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

        // 알림로그 저장
        AlertLog alertLog = AlertLog.builder()
                .fromMember(loginMember)
                .toMember(fromMember)
                .alertType(metaDataService.getMetaData(MetaDataType.ALERT_TYPE.name(), AlertType.FRIEND_APPROVE.getName()))
                .build();
        alertLogRepository.save(alertLog);

        // 푸시알림 전송
        String body = loginMember.getNickname() + " 님이 친구를 수락하였습니다.";
        notificationService.sendNotification(fromMember, body, AlertType.FRIEND_APPROVE.getName());

        return null;
    }

    @Transactional
    public Void rejectFriendRequest(Long loginMemberId, Long friendRequestId) {
        Member loginMember = memberRepository.findById(loginMemberId)
                .orElseThrow(() -> new MemberException(MemberErrorInfo.NOT_FOUND_MEMBER));

        FriendRequest friendRequest = friendRequestRepository.findById(friendRequestId)
                .orElseThrow(() -> new FriendException(FriendErrorInfo.NOT_FOUND_FRIEND_REQUEST));

        Member fromMember = memberRepository.findById(friendRequest.getFromMember().getId())
                .orElseThrow(() -> new MemberException(MemberErrorInfo.NOT_FOUND_MEMBER));

        if (!loginMemberId.equals(friendRequest.getToMember().getId()))
            throw new FriendException(FriendErrorInfo.NOT_REQUESTED_USER);

        if (!friendRequest.getMatchStatus().equals(metaDataService.getMetaData(MetaDataType.MATCH_STATUS.name(), MatchStatus.REQUEST_STATUS.getName())))
            throw new FriendException(FriendErrorInfo.NOT_REQUEST_STATUS);

        friendRequest.updateMatchStatus(metaDataService.getMetaData(MetaDataType.MATCH_STATUS.name(), MatchStatus.REJECT_STATUS.getName()));

//        // 알림로그 저장
//        AlertLog alertLog = AlertLog.builder()
//                .fromMember(loginMember)
//                .toMember(fromMember)
//                .alertType(metaDataService.getMetaData(MetaDataType.ALERT_TYPE.name(), AlertType.FRIEND_REJECT.getName()))
//                .build();
//        alertLogRepository.save(alertLog);

        return null;
    }

    @Transactional(readOnly = true)
    public FindFriendsResponseDto findFriends(Long loginMemberId) {
        memberRepository.findById(loginMemberId)
                .orElseThrow(() -> new MemberException(MemberErrorInfo.NOT_FOUND_MEMBER));

        List<Friend> friends = friendRepository.findAllByMemberId(loginMemberId);
        return FindFriendsResponseDto.from(friends);
    }

    @Transactional
    public Void deleteFriend(Long loginMemberId, Long myFriendId) {
        memberRepository.findById(loginMemberId)
                .orElseThrow(() -> new MemberException(MemberErrorInfo.NOT_FOUND_MEMBER));

        memberRepository.findById(myFriendId)
                .orElseThrow(() -> new MemberException(MemberErrorInfo.NOT_FOUND_MEMBER));

        Friend fromToFriend = friendRepository.findByMemberIdAndMyFriendId(loginMemberId, myFriendId)
                .orElseThrow(() -> new FriendException(FriendErrorInfo.NOT_FRIEND_STATUS));

        Friend toFromFriend = friendRepository.findByMemberIdAndMyFriendId(myFriendId, loginMemberId)
                .orElseThrow(() -> new FriendException(FriendErrorInfo.NOT_FRIEND_STATUS));

        friendRepository.delete(fromToFriend);
        friendRepository.delete(toFromFriend);

        friendRequestRepository.findByFromMemberIdAndToMemberId(loginMemberId, myFriendId)
                .ifPresent(friendRequest -> friendRequest.updateMatchStatus(metaDataService.getMetaData(MetaDataType.MATCH_STATUS.name(), MatchStatus.DELETE_STATUS.getName())));
        friendRequestRepository.findByFromMemberIdAndToMemberId(myFriendId, loginMemberId)
                .ifPresent(friendRequest -> friendRequest.updateMatchStatus(metaDataService.getMetaData(MetaDataType.MATCH_STATUS.name(), MatchStatus.DELETE_STATUS.getName())));

        return null;
    }

    @Transactional(readOnly = true)
    public FindFriendsResponseDto searchFriends(Long loginMemberId, String keyword) {
        memberRepository.findById(loginMemberId)
                .orElseThrow(() -> new MemberException(MemberErrorInfo.NOT_FOUND_MEMBER));

        List<Friend> friends = friendRepository.findAllByMemberIdAndKeyword(loginMemberId, keyword);
        return FindFriendsResponseDto.from(friends);
    }
}

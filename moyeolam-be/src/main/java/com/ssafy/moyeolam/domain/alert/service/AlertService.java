package com.ssafy.moyeolam.domain.alert.service;

import com.ssafy.moyeolam.domain.alarmgroup.domain.AlarmGroupRequest;
import com.ssafy.moyeolam.domain.alarmgroup.repository.AlarmGroupRequestRepository;
import com.ssafy.moyeolam.domain.alert.domain.AlertLog;
import com.ssafy.moyeolam.domain.alert.dto.AlertElement;
import com.ssafy.moyeolam.domain.alert.dto.FindAlertsResponseDto;
import com.ssafy.moyeolam.domain.alert.repository.AlertLogRepository;
import com.ssafy.moyeolam.domain.friend.domain.FriendRequest;
import com.ssafy.moyeolam.domain.friend.repository.FriendRequestRepository;
import com.ssafy.moyeolam.domain.member.domain.Member;
import com.ssafy.moyeolam.domain.member.exception.MemberErrorInfo;
import com.ssafy.moyeolam.domain.member.exception.MemberException;
import com.ssafy.moyeolam.domain.member.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class AlertService {
    private final AlertLogRepository alertLogRepository;
    private final FriendRequestRepository friendRequestRepository;
    private final AlarmGroupRequestRepository alarmGroupRequestRepository;
    private final MemberRepository memberRepository;

    public FindAlertsResponseDto findAlerts(Long loginMemberId) {
        Member loginMember = memberRepository.findById(loginMemberId)
                .orElseThrow(() -> new MemberException(MemberErrorInfo.NOT_FOUND_MEMBER));

        List<AlertLog> alertLogs = alertLogRepository.findAllByToMemberIdWithDetailsFetch(loginMember.getId());
        List<FriendRequest> friendRequests = friendRequestRepository.findAllByToMemberIdWithToMemberFetch(loginMember.getId());
        List<AlarmGroupRequest> alarmGroupRequests = alarmGroupRequestRepository.findAllByToMemberIdWithToMemberFetch(loginMember.getId());
        return FindAlertsResponseDto.of(alertLogs, friendRequests, alarmGroupRequests);
    }
}

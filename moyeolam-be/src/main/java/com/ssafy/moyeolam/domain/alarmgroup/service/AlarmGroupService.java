package com.ssafy.moyeolam.domain.alarmgroup.service;

import com.ssafy.moyeolam.domain.alarmgroup.domain.AlarmDay;
import com.ssafy.moyeolam.domain.alarmgroup.domain.AlarmGroup;
import com.ssafy.moyeolam.domain.alarmgroup.domain.AlarmGroupMember;
import com.ssafy.moyeolam.domain.alarmgroup.domain.AlarmGroupRequest;
import com.ssafy.moyeolam.domain.alarmgroup.dto.FindAlarmGroupResponseDto;
import com.ssafy.moyeolam.domain.alarmgroup.dto.FindAlarmGroupsResponseDto;
import com.ssafy.moyeolam.domain.alarmgroup.dto.SaveAlarmGroupRequestDto;
import com.ssafy.moyeolam.domain.alarmgroup.dto.UpdateAlarmGroupRequestDto;
import com.ssafy.moyeolam.domain.alarmgroup.exception.AlarmGroupErrorInfo;
import com.ssafy.moyeolam.domain.alarmgroup.exception.AlarmGroupException;
import com.ssafy.moyeolam.domain.alarmgroup.repository.AlarmDayRepository;
import com.ssafy.moyeolam.domain.alarmgroup.repository.AlarmGroupMemberRepository;
import com.ssafy.moyeolam.domain.alarmgroup.repository.AlarmGroupRepository;
import com.ssafy.moyeolam.domain.alarmgroup.repository.AlarmGroupRequestRepository;
import com.ssafy.moyeolam.domain.alert.domain.AlertLog;
import com.ssafy.moyeolam.domain.alert.repository.AlertLogRepository;
import com.ssafy.moyeolam.domain.member.domain.Member;
import com.ssafy.moyeolam.domain.member.exception.MemberErrorInfo;
import com.ssafy.moyeolam.domain.member.exception.MemberException;
import com.ssafy.moyeolam.domain.member.repository.MemberRepository;
import com.ssafy.moyeolam.domain.meta.domain.*;
import com.ssafy.moyeolam.domain.meta.service.MetaDataService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Slf4j
public class AlarmGroupService {
    private final MetaDataService metaDataService;
    private final MemberRepository memberRepository;
    private final AlarmGroupRepository alarmGroupRepository;
    private final AlarmGroupMemberRepository alarmGroupMemberRepository;
    private final AlarmDayRepository alarmDayRepository;
    private final AlarmGroupRequestRepository alarmGroupRequestRepository;
    private final AlertLogRepository alertLogRepository;


    @Transactional
    public Long saveAlarmGroup(SaveAlarmGroupRequestDto requestDto, Long loginMemberId) {
        Member loginMember = memberRepository.findById(loginMemberId)
                .orElseThrow(() -> new MemberException(MemberErrorInfo.NOT_FOUND_MEMBER));

        // 1. 알람그룹 방 생성
        AlarmGroup alarmGroup = AlarmGroup.builder()
                .hostMember(loginMember)
                .title(requestDto.getTitle())
                .time(requestDto.getTime())
                .repeat(requestDto.getDayOfWeek().size() > 0)
                .alarmSound(metaDataService.getMetaData(MetaDataType.ALARM_SOUND.name(), requestDto.getAlarmSound()))
                .alarmMission(metaDataService.getMetaData(MetaDataType.ALARM_MISSION.name(), requestDto.getAlarmMission()))
                .build();
        alarmGroupRepository.save(alarmGroup);

        // 2. 알람그룹 멤버 등록(방장)
        AlarmGroupMember alarmGroupMember = AlarmGroupMember.builder()
                .member(loginMember)
                .alarmGroup(alarmGroup)
                .alarmGroupMemberRole(metaDataService.getMetaData(MetaDataType.ALARM_GROUP_MEMBER_ROLE.name(), AlarmGroupMemberRole.HOST.getName()))
                .alarmToggle(true)
                .build();
        alarmGroupMemberRepository.save(alarmGroupMember);

        //3. 알람그룹 요일 등록
        for (String day : requestDto.getDayOfWeek()) {
            AlarmDay alarmDay = AlarmDay.builder()
                    .alarmGroup(alarmGroup)
                    .dayOfWeek(metaDataService.getMetaData(MetaDataType.DAY_OF_WEEK.name(), day))
                    .build();
            alarmDayRepository.save(alarmDay);
        }

        return alarmGroup.getId();
    }

    @Transactional(readOnly = true)
    public FindAlarmGroupsResponseDto findAlarmGroups(Long loginMemberId) {
        Member loginMember = memberRepository.findById(loginMemberId)
                .orElseThrow(() -> new MemberException(MemberErrorInfo.NOT_FOUND_MEMBER));

        List<AlarmGroupMember> alarmGroupMembers = alarmGroupMemberRepository.findAllWithAlarmGroupAndMemberByMemberId(loginMember.getId());
        return FindAlarmGroupsResponseDto.of(alarmGroupMembers);
    }

    @Transactional(readOnly = true)
    public FindAlarmGroupResponseDto findAlarmGroup(Long alarmGroupId, Long loginMemberId) {
        Member loginMember = memberRepository.findById(loginMemberId)
                .orElseThrow(() -> new MemberException(MemberErrorInfo.NOT_FOUND_MEMBER));

        AlarmGroup alarmGroup = alarmGroupRepository.findByIdWithAlarmGroupMembers(alarmGroupId)
                .orElseThrow(() -> new AlarmGroupException(AlarmGroupErrorInfo.NOT_FOUND_ALARM_GROUP));

        if (!alarmGroupMemberRepository.existsByMemberIdAndAlarmGroupId(loginMember.getId(), alarmGroupId)) {
            throw new AlarmGroupException(AlarmGroupErrorInfo.ALREADY_NOT_ALARM_GROUP_MEMBER);
        }

        return FindAlarmGroupResponseDto.of(alarmGroup, loginMember);
    }

    @Transactional
    public Long quitAlarmGroup(Long alarmGroupId, Long loginMemberId) {
        Member loginMember = memberRepository.findById(loginMemberId)
                .orElseThrow(() -> new MemberException(MemberErrorInfo.NOT_FOUND_MEMBER));

        AlarmGroup alarmGroup = alarmGroupRepository.findByIdWithHostMember(alarmGroupId)
                .orElseThrow(() -> new AlarmGroupException(AlarmGroupErrorInfo.NOT_FOUND_ALARM_GROUP));

        if (!alarmGroupMemberRepository.existsByMemberIdAndAlarmGroupId(loginMember.getId(), alarmGroupId)) {
            throw new AlarmGroupException(AlarmGroupErrorInfo.ALREADY_NOT_ALARM_GROUP_MEMBER);
        }

        Member hostMember = alarmGroup.getHostMember();
        if (hostMember.getId().equals(loginMember.getId())) {
            alarmGroupMemberRepository.deleteAllInBatch(alarmGroup.getAlarmGroupMembers());
            alarmDayRepository.deleteAllInBatch(alarmGroup.getAlarmDays());
            alarmGroupRepository.delete(alarmGroup);
            return alarmGroup.getId();
        }
        alarmGroupMemberRepository.deleteByMemberIdAndAlarmGroupId(loginMember.getId(), alarmGroupId);

        AlarmGroupRequest alarmGroupRequest = alarmGroupRequestRepository.findByAlarmGroupIdAndFromMemberIdAndToMemberId(alarmGroup.getId(), hostMember.getId(), loginMember.getId())
                .orElseThrow(() -> new AlarmGroupException(AlarmGroupErrorInfo.NOT_FOUND_ALARM_GROUP_REQUEST));
        alarmGroupRequest.setMatchStatus(metaDataService.getMetaData(MetaDataType.MATCH_STATUS.name(), MatchStatus.DELETE_STATUS.getName()));

        AlertLog alertLog = AlertLog.builder()
                .fromMember(loginMember)
                .toMember(alarmGroup.getHostMember())
                .alertType(metaDataService.getMetaData(MetaDataType.ALERT_TYPE.name(), AlertType.ALARM_GROUP_QUIT.getName()))
                .build();
        alertLogRepository.save(alertLog);

        return alarmGroup.getId();
    }

    @Transactional
    public Long updateAlarmGroup(Long alarmGroupId, Long loginMemberId, UpdateAlarmGroupRequestDto requestDto) {
        Member loginMember = memberRepository.findById(loginMemberId)
                .orElseThrow(() -> new MemberException(MemberErrorInfo.NOT_FOUND_MEMBER));

        AlarmGroup alarmGroup = alarmGroupRepository.findByIdWithHostMember(alarmGroupId)
                .orElseThrow(() -> new AlarmGroupException(AlarmGroupErrorInfo.NOT_FOUND_ALARM_GROUP));

        if (!alarmGroup.getHostMember().getId().equals(loginMember.getId())) {
            throw new AlarmGroupException(AlarmGroupErrorInfo.UNAUTHORIZED_UPDATE);
        }

        alarmGroup.updateAlarmGroup(requestDto.getTitle(), requestDto.getTime());
        alarmGroup.setAlarmSound(metaDataService.getMetaData(MetaDataType.ALARM_SOUND.name(), requestDto.getAlarmSound()));
        alarmGroup.setAlarmMission(metaDataService.getMetaData(MetaDataType.ALARM_MISSION.name(), requestDto.getAlarmMission()));

        updateAlarmDays(requestDto.getDayOfWeek(), alarmGroup);

        return alarmGroup.getId();
    }

    private void updateAlarmDays(List<String> days, AlarmGroup alarmGroup) {
        alarmDayRepository.deleteAllInBatch(alarmGroup.getAlarmDays());

        List<AlarmDay> alarmDays = days.stream()
                .map(day -> (AlarmDay.builder()
                        .alarmGroup(alarmGroup)
                        .dayOfWeek(metaDataService.getMetaData(MetaDataType.DAY_OF_WEEK.name(), day))
                        .build()))
                .collect(Collectors.toList());
        alarmDayRepository.saveAll(alarmDays);
    }

    @Transactional
    public List<Long> requestAlarmGroup(Long loginMemberId, Long alarmGroupId, List<Long> memberIds) {
        Member loginMember = memberRepository.findById(loginMemberId)
                .orElseThrow(() -> new MemberException(MemberErrorInfo.NOT_FOUND_MEMBER));

        AlarmGroup alarmGroup = alarmGroupRepository.findByIdWithAlarmGroupMembers(alarmGroupId)
                .orElseThrow(() -> new AlarmGroupException(AlarmGroupErrorInfo.NOT_FOUND_ALARM_GROUP));

        if (!alarmGroup.getHostMember().getId().equals(loginMember.getId())) {
            throw new AlarmGroupException(AlarmGroupErrorInfo.UNAUTHORIZED_REQUEST);
        }

        List<Long> requestFailMember = new ArrayList<>();
        for (Long memberId : memberIds) {
            if (loginMember.getId().equals(memberId)) {
                requestFailMember.add(memberId);
                continue;
            }

            AlarmGroupRequest alarmGroupRequest = alarmGroupRequestRepository.findByAlarmGroupIdAndFromMemberIdAndToMemberId(alarmGroupId, loginMember.getId(), memberId)
                    .orElse(null);

            if (alarmGroupRequest != null) {
                MetaData matchStatus = alarmGroupRequest.getMatchStatus();
                if (matchStatus.getName().equals(MatchStatus.REQUEST_STATUS.getName()) || matchStatus.getName().equals(MatchStatus.APPROVE_STATUS.getName())) {
                    requestFailMember.add(memberId);
                    continue;
                }

                alarmGroupRequest.setMatchStatus(metaDataService.getMetaData(MetaDataType.MATCH_STATUS.name(), MatchStatus.REQUEST_STATUS.getName()));
                continue;
            }

            Member toMember = memberRepository.findById(memberId)
                    .orElseThrow(() -> new MemberException(MemberErrorInfo.NOT_FOUND_MEMBER));

            alarmGroupRequest = AlarmGroupRequest.builder()
                    .alarmGroup(alarmGroup)
                    .fromMember(loginMember)
                    .toMember(toMember)
                    .matchStatus(metaDataService.getMetaData(MetaDataType.MATCH_STATUS.name(), MatchStatus.REQUEST_STATUS.getName()))
                    .build();
            alarmGroupRequestRepository.save(alarmGroupRequest);
        }
        return requestFailMember;
    }

    @Transactional
    public Long approveAlarmGroup(Long alarmGroupId, Long loginMemberId, Long fromMemberId, Long toMemberId) {
        Member loginMember = memberRepository.findById(loginMemberId)
                .orElseThrow(() -> new MemberException(MemberErrorInfo.NOT_FOUND_MEMBER));

        Member fromMember = memberRepository.findById(fromMemberId)
                .orElseThrow(() -> new MemberException(MemberErrorInfo.NOT_FOUND_MEMBER));

        Member toMember = memberRepository.findById(toMemberId)
                .orElseThrow(() -> new MemberException(MemberErrorInfo.NOT_FOUND_MEMBER));

        if (!loginMember.getId().equals(toMember.getId())) {
            throw new AlarmGroupException(AlarmGroupErrorInfo.UNAUTHORIZED_APPROVE);
        }

        AlarmGroup alarmGroup = alarmGroupRepository.findById(alarmGroupId)
                .orElseThrow(() -> new AlarmGroupException(AlarmGroupErrorInfo.NOT_FOUND_ALARM_GROUP));

        AlarmGroupRequest alarmGroupRequest = alarmGroupRequestRepository.findByAlarmGroupIdAndFromMemberIdAndToMemberId(alarmGroup.getId(), fromMember.getId(), toMember.getId())
                .orElseThrow(() -> new AlarmGroupException(AlarmGroupErrorInfo.NOT_FOUND_ALARM_GROUP_REQUEST));

        if (alarmGroupRequest.getMatchStatus().getName().equals(MatchStatus.REQUEST_STATUS.getName())) {
            alarmGroupRequest.setMatchStatus(metaDataService.getMetaData(MetaDataType.MATCH_STATUS.name(), MatchStatus.APPROVE_STATUS.getName()));
            AlarmGroupMember alarmGroupMember = AlarmGroupMember.builder()
                    .member(loginMember)
                    .alarmGroup(alarmGroup)
                    .alarmGroupMemberRole(metaDataService.getMetaData(MetaDataType.ALARM_GROUP_MEMBER_ROLE.name(), AlarmGroupMemberRole.NORMAL.getName()))
                    .alarmToggle(false)
                    .build();
            alarmGroupMemberRepository.save(alarmGroupMember);

            // 알림로그 저장
            AlertLog alertLog = AlertLog.builder()
                    .fromMember(loginMember)
                    .toMember(fromMember)
                    .alertType(metaDataService.getMetaData(MetaDataType.ALERT_TYPE.name(), AlertType.ALARM_GROUP_APPROVE.getName()))
                    .build();
            alertLogRepository.save(alertLog);

            return loginMember.getId();
        }

        throw new AlarmGroupException(AlarmGroupErrorInfo.NOT_FOUND_ALARM_GROUP_REQUEST);
    }


    @Transactional
    public Long rejectAlarmGroup(Long alarmGroupId, Long loginMemberId, Long fromMemberId, Long toMemberId) {
        Member loginMember = memberRepository.findById(loginMemberId)
                .orElseThrow(() -> new MemberException(MemberErrorInfo.NOT_FOUND_MEMBER));

        Member fromMember = memberRepository.findById(fromMemberId)
                .orElseThrow(() -> new MemberException(MemberErrorInfo.NOT_FOUND_MEMBER));

        Member toMember = memberRepository.findById(toMemberId)
                .orElseThrow(() -> new MemberException(MemberErrorInfo.NOT_FOUND_MEMBER));

        if (!loginMember.getId().equals(toMember.getId())) {
            throw new AlarmGroupException(AlarmGroupErrorInfo.UNAUTHORIZED_APPROVE);
        }

        AlarmGroup alarmGroup = alarmGroupRepository.findById(alarmGroupId)
                .orElseThrow(() -> new AlarmGroupException(AlarmGroupErrorInfo.NOT_FOUND_ALARM_GROUP));

        AlarmGroupRequest alarmGroupRequest = alarmGroupRequestRepository.findByAlarmGroupIdAndFromMemberIdAndToMemberId(alarmGroup.getId(), fromMember.getId(), toMember.getId())
                .orElseThrow(() -> new AlarmGroupException(AlarmGroupErrorInfo.NOT_FOUND_ALARM_GROUP_REQUEST));

        if (alarmGroupRequest.getMatchStatus().getName().equals(MatchStatus.REQUEST_STATUS.getName())) {
            alarmGroupRequest.setMatchStatus(metaDataService.getMetaData(MetaDataType.MATCH_STATUS.name(), MatchStatus.REJECT_STATUS.getName()));

            // 알림로그 저장
            AlertLog alertLog = AlertLog.builder()
                    .fromMember(loginMember)
                    .toMember(fromMember)
                    .alertType(metaDataService.getMetaData(MetaDataType.ALERT_TYPE.name(), AlertType.ALARM_GROUP_REJECT.getName()))
                    .build();
            alertLogRepository.save(alertLog);
            return loginMember.getId();
        }

        throw new AlarmGroupException(AlarmGroupErrorInfo.NOT_FOUND_ALARM_GROUP_REQUEST);
    }

    @Transactional
    public Long banAlarmGroupMember(Long alarmGroupId, Long loginMemberId, Long banMemberId) {
        Member loginMember = memberRepository.findById(loginMemberId)
                .orElseThrow(() -> new MemberException(MemberErrorInfo.NOT_FOUND_MEMBER));

        Member banMember = memberRepository.findById(banMemberId)
                .orElseThrow(() -> new MemberException(MemberErrorInfo.NOT_FOUND_MEMBER));

        AlarmGroup alarmGroup = alarmGroupRepository.findByIdWithHostMember(alarmGroupId)
                .orElseThrow(() -> new AlarmGroupException(AlarmGroupErrorInfo.NOT_FOUND_ALARM_GROUP));

        if (!alarmGroupMemberRepository.existsByMemberIdAndAlarmGroupId(banMemberId, alarmGroupId)) {
            throw new AlarmGroupException(AlarmGroupErrorInfo.NOT_FOUND_ALARM_GROUP_MEMBER);
        }

        if (!alarmGroup.getHostMember().getId().equals(loginMember.getId())) {
            throw new AlarmGroupException(AlarmGroupErrorInfo.UNAUTHORIZED_BAN);
        }

        if (alarmGroup.getHostMember().getId().equals(banMemberId)) {
            throw new AlarmGroupException(AlarmGroupErrorInfo.NOT_SELF_BAN);
        }
        alarmGroupMemberRepository.deleteByMemberIdAndAlarmGroupId(banMemberId, alarmGroupId);

        AlertLog alertLog = AlertLog.builder()
                .fromMember(loginMember)
                .toMember(banMember)
                .alertType(metaDataService.getMetaData(MetaDataType.ALERT_TYPE.name(), AlertType.ALARM_GROUP_BAN.getName()))
                .build();
        alertLogRepository.save(alertLog);
        return banMemberId;
    }
}

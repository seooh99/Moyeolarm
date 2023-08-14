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
import com.ssafy.moyeolam.domain.notification.service.NotificationService;
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
    private final NotificationService notificationService;


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
        return FindAlarmGroupsResponseDto.of(alarmGroupMembers, loginMember);
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
        Member loginMember = memberRepository.findByIdWithFcmTokens(loginMemberId)
                .orElseThrow(() -> new MemberException(MemberErrorInfo.NOT_FOUND_MEMBER));

        AlarmGroup alarmGroup = alarmGroupRepository.findByIdWithHostMemberAndAlarmGroupMembersWithMember(alarmGroupId)
                .orElseThrow(() -> new AlarmGroupException(AlarmGroupErrorInfo.NOT_FOUND_ALARM_GROUP));

        if (!alarmGroupMemberRepository.existsByMemberIdAndAlarmGroupId(loginMember.getId(), alarmGroupId)) {
            throw new AlarmGroupException(AlarmGroupErrorInfo.ALREADY_NOT_ALARM_GROUP_MEMBER);
        }

        Member hostMember = alarmGroup.getHostMember();
        if (hostMember.getId().equals(loginMember.getId())) {
            List<AlarmGroupMember> alarmGroupMembers = alarmGroup.getAlarmGroupMembers();

            // 알람그룹 로그
            for (AlarmGroupMember alarmGroupMember : alarmGroupMembers) {
                Member member = alarmGroupMember.getMember();
                if (member.getId().equals(loginMember.getId())) {
                    continue;
                }

                AlertLog alertLog = AlertLog.builder()
                        .fromMember(loginMember)
                        .toMember(member)
                        .alarmGroup(alarmGroup)
                        .alertType(metaDataService.getMetaData(MetaDataType.ALERT_TYPE.name(), AlertType.ALARM_GROUP_ABOLISHED.getName()))
                        .build();
                alertLogRepository.save(alertLog);
            }

            // 푸시알림 전송
            for (AlarmGroupMember alarmGroupMember : alarmGroupMembers) {
                Member member = alarmGroupMember.getMember();
                if (member.getId().equals(loginMember.getId())) {
                    continue;
                }
                String body = hostMember.getNickname() + " 님의 알람그룹 " + alarmGroup.getTitle() + "이 해체 되었습니다.";
                notificationService.sendAllNotification(member, body, AlertType.ALARM_GROUP_QUIT);
            }

            alarmGroupMemberRepository.deleteAllInBatch(alarmGroupMembers);
            alarmDayRepository.deleteAllInBatch(alarmGroup.getAlarmDays());
//            alarmGroupRepository.delete(alarmGroup);
            return alarmGroup.getId();
        }
        alarmGroupMemberRepository.deleteByMemberIdAndAlarmGroupId(loginMember.getId(), alarmGroupId);

        AlarmGroupRequest alarmGroupRequest = alarmGroupRequestRepository.findByAlarmGroupIdAndFromMemberIdAndToMemberId(alarmGroup.getId(), hostMember.getId(), loginMember.getId())
                .orElseThrow(() -> new AlarmGroupException(AlarmGroupErrorInfo.NOT_FOUND_ALARM_GROUP_REQUEST));
        alarmGroupRequest.setMatchStatus(metaDataService.getMetaData(MetaDataType.MATCH_STATUS.name(), MatchStatus.DELETE_STATUS.getName()));

        // 알람그룹 로그
        AlertLog alertLog = AlertLog.builder()
                .fromMember(loginMember)
                .toMember(alarmGroup.getHostMember())
                .alarmGroup(alarmGroup)
                .alertType(metaDataService.getMetaData(MetaDataType.ALERT_TYPE.name(), AlertType.ALARM_GROUP_QUIT.getName()))
                .build();
        alertLogRepository.save(alertLog);

        // 푸시알림 전송
        String body = hostMember.getNickname() + " 님의 알람그룹 " + alarmGroup.getTitle() + "에서 나갔습니다.";
        notificationService.sendAllNotification(loginMember, body, AlertType.ALARM_GROUP_QUIT);

        return alarmGroup.getId();
    }

    @Transactional
    public Long updateAlarmGroup(Long alarmGroupId, Long loginMemberId, UpdateAlarmGroupRequestDto requestDto) {
        Member loginMember = memberRepository.findById(loginMemberId)
                .orElseThrow(() -> new MemberException(MemberErrorInfo.NOT_FOUND_MEMBER));

        AlarmGroup alarmGroup = alarmGroupRepository.findByIdWithHostMemberAndAlarmGroupMembersWithMember(alarmGroupId)
                .orElseThrow(() -> new AlarmGroupException(AlarmGroupErrorInfo.NOT_FOUND_ALARM_GROUP));

        if (!alarmGroup.getHostMember().getId().equals(loginMember.getId())) {
            throw new AlarmGroupException(AlarmGroupErrorInfo.UNAUTHORIZED_UPDATE);
        }

        alarmGroup.updateAlarmGroup(requestDto.getTitle(), requestDto.getTime());
        alarmGroup.setAlarmSound(metaDataService.getMetaData(MetaDataType.ALARM_SOUND.name(), requestDto.getAlarmSound()));
        alarmGroup.setAlarmMission(metaDataService.getMetaData(MetaDataType.ALARM_MISSION.name(), requestDto.getAlarmMission()));

        updateAlarmDays(requestDto.getDayOfWeek(), alarmGroup);


        List<AlarmGroupMember> alarmGroupMembers = alarmGroup.getAlarmGroupMembers();
        // 알람그룹 로그
        for (AlarmGroupMember alarmGroupMember : alarmGroupMembers) {
            Member member = alarmGroupMember.getMember();
            if (member.getId().equals(loginMember.getId())) {
                continue;
            }

            AlertLog alertLog = AlertLog.builder()
                    .fromMember(loginMember)
                    .toMember(member)
                    .alarmGroup(alarmGroup)
                    .alertType(metaDataService.getMetaData(MetaDataType.ALERT_TYPE.name(), AlertType.ALARM_GROUP_UPDATE.getName()))
                    .build();
            alertLogRepository.save(alertLog);
        }

        // 푸시알림 전송
        String body = alarmGroup.getHostMember().getNickname() + "님의" + alarmGroup.getTitle() + "의 알람그룹이 수정되었습니다.";
        for (AlarmGroupMember alarmGroupMember : alarmGroupMembers) {
            Member member = alarmGroupMember.getMember();
            if (!member.getId().equals(loginMember.getId())) {
                notificationService.sendAllNotification(member, body, AlertType.ALARM_GROUP_UPDATE);
            }
        }

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

            Member toMember = memberRepository.findByIdWithFcmTokens(memberId)
                    .orElseThrow(() -> new MemberException(MemberErrorInfo.NOT_FOUND_MEMBER));

            alarmGroupRequest = AlarmGroupRequest.builder()
                    .alarmGroup(alarmGroup)
                    .fromMember(loginMember)
                    .toMember(toMember)
                    .matchStatus(metaDataService.getMetaData(MetaDataType.MATCH_STATUS.name(), MatchStatus.REQUEST_STATUS.getName()))
                    .build();
            alarmGroupRequestRepository.save(alarmGroupRequest);

            // 푸시알림 전송
            String body = loginMember.getNickname() + " 님의 " + alarmGroup.getTime() + " 알람그룹 " + alarmGroup.getTitle() + "방에 초대되었습니다.";
            notificationService.sendAllNotification(toMember, body, AlertType.ALARM_GROUP_REQUEST);
        }
        return requestFailMember;
    }

    @Transactional
    public Long approveAlarmGroup(Long alarmGroupId, Long loginMemberId, Long fromMemberId, Long toMemberId) {
        Member loginMember = memberRepository.findById(loginMemberId)
                .orElseThrow(() -> new MemberException(MemberErrorInfo.NOT_FOUND_MEMBER));

        Member fromMember = memberRepository.findByIdWithFcmTokens(fromMemberId)
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
                    .alarmGroup(alarmGroup)
                    .alertType(metaDataService.getMetaData(MetaDataType.ALERT_TYPE.name(), AlertType.ALARM_GROUP_APPROVE.getName()))
                    .build();
            alertLogRepository.save(alertLog);

            // 푸시알림 전송
            String body = loginMember.getNickname() + " 님이 알람그룹 " + alarmGroup.getTitle() + "방에 참여하였습니다.";
            notificationService.sendAllNotification(fromMember, body, AlertType.ALARM_GROUP_APPROVE);

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

            return loginMember.getId();
        }

        throw new AlarmGroupException(AlarmGroupErrorInfo.NOT_FOUND_ALARM_GROUP_REQUEST);
    }

    @Transactional
    public Long banAlarmGroupMember(Long alarmGroupId, Long loginMemberId, Long banMemberId) {
        Member loginMember = memberRepository.findById(loginMemberId)
                .orElseThrow(() -> new MemberException(MemberErrorInfo.NOT_FOUND_MEMBER));

        Member banMember = memberRepository.findByIdWithFcmTokens(banMemberId)
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

        AlarmGroupRequest alarmGroupRequest = alarmGroupRequestRepository.findByAlarmGroupIdAndFromMemberIdAndToMemberId(alarmGroupId, loginMember.getId(), banMember.getId())
                .orElseThrow(() -> new AlarmGroupException(AlarmGroupErrorInfo.NOT_FOUND_ALARM_GROUP_REQUEST));
        alarmGroupRequest.setMatchStatus(metaDataService.getMetaData(MetaDataType.MATCH_STATUS.name(), MatchStatus.DELETE_STATUS.getName()));

        AlertLog alertLog = AlertLog.builder()
                .fromMember(loginMember)
                .toMember(banMember)
                .alarmGroup(alarmGroup)
                .alertType(metaDataService.getMetaData(MetaDataType.ALERT_TYPE.name(), AlertType.ALARM_GROUP_BAN.getName()))
                .build();
        alertLogRepository.save(alertLog);

        // 푸시알림 전송
        String body = loginMember.getNickname() + " 님의 알람그룹 " + alarmGroup.getTitle() + "에서 강퇴당했습니다.";
        notificationService.sendAllNotification(banMember, body, AlertType.ALARM_GROUP_BAN);

        return banMemberId;
    }

    @Transactional
    public Boolean lockAlarmGroup(Long alarmGroupId, Long loginMemberId) {
        Member loginMember = memberRepository.findById(loginMemberId)
                .orElseThrow(() -> new MemberException(MemberErrorInfo.NOT_FOUND_MEMBER));

        AlarmGroup alarmGroup = alarmGroupRepository.findByIdWithHostMember(alarmGroupId)
                .orElseThrow(() -> new AlarmGroupException(AlarmGroupErrorInfo.NOT_FOUND_ALARM_GROUP));

        if (!alarmGroup.getHostMember().getId().equals(loginMember.getId())) {
            throw new AlarmGroupException(AlarmGroupErrorInfo.UNAUTHORIZED_LOCK);
        }

        alarmGroup.setLock(!alarmGroup.getLock());
        return alarmGroup.getLock();
    }

    @Transactional
    public Boolean toggleAlarm(Long alarmGroupId, Long loginMemberId) {
        Member loginMember = memberRepository.findById(loginMemberId)
                .orElseThrow(() -> new MemberException(MemberErrorInfo.NOT_FOUND_MEMBER));

        AlarmGroup alarmGroup = alarmGroupRepository.findById(alarmGroupId)
                .orElseThrow(() -> new AlarmGroupException(AlarmGroupErrorInfo.NOT_FOUND_ALARM_GROUP));

        AlarmGroupMember alarmGroupMember = alarmGroupMemberRepository.findByAlarmGroupIdAndMemberId(alarmGroup.getId(), loginMember.getId())
                .orElseThrow(() -> new AlarmGroupException(AlarmGroupErrorInfo.NOT_FOUND_ALARM_GROUP_MEMBER));

        if (alarmGroup.getLock()) {
            throw new AlarmGroupException(AlarmGroupErrorInfo.LOCKED_ALARM_TOGGLE);
        }
        alarmGroupMember.setAlarmToggle(!alarmGroupMember.getAlarmToggle());

        return alarmGroupMember.getAlarmToggle();
    }

    @Transactional(readOnly = true)
    public Boolean findAlarmToggle(Long alarmGroupId, Long loginMemberId){
        Member loginMember = memberRepository.findById(loginMemberId)
                .orElseThrow(() -> new MemberException(MemberErrorInfo.NOT_FOUND_MEMBER));

        AlarmGroup alarmGroup = alarmGroupRepository.findById(alarmGroupId)
                .orElseThrow(() -> new AlarmGroupException(AlarmGroupErrorInfo.NOT_FOUND_ALARM_GROUP));

        AlarmGroupMember alarmGroupMember = alarmGroupMemberRepository.findByAlarmGroupIdAndMemberId(alarmGroup.getId(), loginMember.getId())
                .orElseThrow(() -> new AlarmGroupException(AlarmGroupErrorInfo.NOT_FOUND_ALARM_GROUP_MEMBER));

        return alarmGroupMember.getAlarmToggle();
    }
}

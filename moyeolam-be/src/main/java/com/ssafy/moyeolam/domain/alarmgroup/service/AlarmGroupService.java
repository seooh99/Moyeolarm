package com.ssafy.moyeolam.domain.alarmgroup.service;

import com.ssafy.moyeolam.domain.alarmgroup.domain.AlarmDay;
import com.ssafy.moyeolam.domain.alarmgroup.domain.AlarmGroup;
import com.ssafy.moyeolam.domain.alarmgroup.domain.AlarmGroupMember;
import com.ssafy.moyeolam.domain.alarmgroup.dto.FindAlarmGroupResponseDto;
import com.ssafy.moyeolam.domain.alarmgroup.dto.FindAlarmGroupsResponseDto;
import com.ssafy.moyeolam.domain.alarmgroup.dto.SaveAlarmGroupRequestDto;
import com.ssafy.moyeolam.domain.alarmgroup.exception.AlarmGroupErrorInfo;
import com.ssafy.moyeolam.domain.alarmgroup.exception.AlarmGroupException;
import com.ssafy.moyeolam.domain.alarmgroup.repository.AlarmDayRepository;
import com.ssafy.moyeolam.domain.alarmgroup.repository.AlarmGroupMemberRepository;
import com.ssafy.moyeolam.domain.alarmgroup.repository.AlarmGroupRepository;
import com.ssafy.moyeolam.domain.member.domain.Member;
import com.ssafy.moyeolam.domain.member.exception.MemberErrorInfo;
import com.ssafy.moyeolam.domain.member.exception.MemberException;
import com.ssafy.moyeolam.domain.member.repository.MemberRepository;
import com.ssafy.moyeolam.domain.meta.domain.AlarmGroupMemberRole;
import com.ssafy.moyeolam.domain.meta.domain.MetaDataType;
import com.ssafy.moyeolam.domain.meta.service.MetaDataService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class AlarmGroupService {
    private final MetaDataService metaDataService;
    private final MemberRepository memberRepository;
    private final AlarmGroupRepository alarmGroupRepository;
    private final AlarmGroupMemberRepository alarmGroupMemberRepository;
    private final AlarmDayRepository alarmDayRepository;


    @Transactional
    public Long saveAlarmGroup(SaveAlarmGroupRequestDto requestDto, Long loginMemberId) {
        /**
         * TODO: memberException으로 변경
         */
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
            throw new AlarmGroupException(AlarmGroupErrorInfo.UNAUTHORIZED_ACCESS);
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
            throw new AlarmGroupException(AlarmGroupErrorInfo.UNAUTHORIZED_ACCESS);
        }

        boolean isHost = alarmGroup.getHostMember().getId().equals(loginMember.getId());
        if (isHost) {
            alarmGroupMemberRepository.deleteAllInBatch(alarmGroup.getAlarmGroupMembers());
            alarmDayRepository.deleteAllInBatch(alarmGroup.getAlarmDays());
            alarmGroupRepository.delete(alarmGroup);
            return alarmGroup.getId();
        }

        alarmGroupMemberRepository.deleteByMemberIdAndAlarmGroupId(loginMember.getId(), alarmGroupId);
        return alarmGroup.getId();
    }
}

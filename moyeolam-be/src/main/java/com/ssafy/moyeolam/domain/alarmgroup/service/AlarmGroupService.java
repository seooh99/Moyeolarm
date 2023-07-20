package com.ssafy.moyeolam.domain.alarmgroup.service;

import com.ssafy.moyeolam.domain.alarmgroup.domain.AlarmGroup;
import com.ssafy.moyeolam.domain.alarmgroup.dto.FindAlarmGroupsResponseDto;
import com.ssafy.moyeolam.domain.alarmgroup.dto.SaveAlarmGroupRequestDto;
import com.ssafy.moyeolam.domain.alarmgroup.repository.AlarmGroupRepository;
import com.ssafy.moyeolam.domain.member.domain.Member;
import com.ssafy.moyeolam.domain.member.repository.MemberRepository;
import com.ssafy.moyeolam.domain.meta.domain.MetaDataType;
import com.ssafy.moyeolam.domain.meta.service.MetaDataService;
import com.ssafy.moyeolam.global.common.exception.GlobalErrorInfo;
import com.ssafy.moyeolam.global.common.exception.GlobalException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Slf4j
public class AlarmGroupService {
    private final MetaDataService metaDataService;
    private final MemberRepository memberRepository;
    private final AlarmGroupRepository alarmGroupRepository;


    @Transactional
    public Long generateAlarmGroup(SaveAlarmGroupRequestDto requestDto, Long loginMemberId) {
        /**
         * TODO: 사용자 및 권한 검증 로직 추가
         */

        AlarmGroup alarmGroup = AlarmGroup.builder()
                .title(requestDto.getTitle())
                .time(requestDto.getTime())
                .repeat(requestDto.getDayOfWeek().size() > 0)
                .alarmSound(metaDataService.getMetaData(MetaDataType.ALARM_SOUND.name(), requestDto.getAlarmSound()))
                .alarmMission(metaDataService.getMetaData(MetaDataType.ALARM_MISSION.name(), requestDto.getAlarmMission()))
                .build();

        alarmGroupRepository.save(alarmGroup);
        return alarmGroup.getId();
    }

    @Transactional(readOnly = true)
    public FindAlarmGroupsResponseDto findAlarmGroups(Long loginMemberId) {
        /**
         * memberException으로 변경
         */
        Member loginMember = memberRepository.findById(loginMemberId)
                .orElseThrow(() -> new GlobalException(GlobalErrorInfo.INTERNAL_SERVER_ERROR));

        List<AlarmGroup> alarmGroups = alarmGroupRepository.findAllWithAlarmGroupMembersFetch();
        return FindAlarmGroupsResponseDto.of(alarmGroups, loginMember);
    }

}

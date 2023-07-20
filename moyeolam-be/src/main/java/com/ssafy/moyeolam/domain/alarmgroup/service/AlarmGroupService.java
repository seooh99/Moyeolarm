package com.ssafy.moyeolam.domain.alarmgroup.service;

import com.ssafy.moyeolam.domain.alarmgroup.domain.AlarmGroup;
import com.ssafy.moyeolam.domain.alarmgroup.dto.AlarmGroupGenerateRequest;
import com.ssafy.moyeolam.domain.alarmgroup.repository.AlarmGroupRepository;
import com.ssafy.moyeolam.domain.meta.domain.MetaDataType;
import com.ssafy.moyeolam.domain.meta.service.MetaDataService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@Slf4j
public class AlarmGroupService {
    private final MetaDataService metaDataService;
    private final AlarmGroupRepository alarmGroupRepository;

    public Long generateAlarmGroup(AlarmGroupGenerateRequest request) {
        /**
         * TODO: 사용자 및 권한 검증 로직 추가
         */

        AlarmGroup alarmGroup = AlarmGroup.builder()
                .time(request.getTime())
                .repeat(request.getDayOfWeek().size() > 0)
                .alarmSound(metaDataService.getMetaData(MetaDataType.ALARM_SOUND.name(), request.getAlarmSound()))
                .alarmMission(metaDataService.getMetaData(MetaDataType.ALARM_MISSION.name(), request.getAlarmMission()))
                .build();

        alarmGroupRepository.save(alarmGroup);
        return alarmGroup.getId();
    }
}

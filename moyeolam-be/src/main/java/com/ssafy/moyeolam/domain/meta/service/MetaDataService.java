package com.ssafy.moyeolam.domain.meta.service;

import com.ssafy.moyeolam.domain.meta.domain.*;
import com.ssafy.moyeolam.global.common.exception.GlobalErrorInfo;
import com.ssafy.moyeolam.global.common.exception.GlobalException;
import org.springframework.stereotype.Component;

import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

@Component
public class MetaDataService {
    private final Map<String, Map<String, MetaData>> map;

    public MetaDataService() {
        this.map = new HashMap<>();
        this.putMetaData(MetaDataType.ALARM_GROUP_MEMBER_ROLE.name(), AlarmGroupMemberRole.class);
        this.putMetaData(MetaDataType.ALARM_MISSION.name(), AlarmMission.class);
        this.putMetaData(MetaDataType.ALARM_SOUND.name(), AlarmSound.class);
        this.putMetaData(MetaDataType.ALERT_TYPE.name(), AlertType.class);
        this.putMetaData(MetaDataType.DAY_OF_WEEK.name(), DayOfWeek.class);
        this.putMetaData(MetaDataType.MATCH_STATUS.name(), MatchStatus.class);
        this.putMetaData(MetaDataType.OAUTH_TYPE.name(), OauthType.class);
        this.putMetaData(MetaDataType.PUSH_ALERT_TYPE.name(), PushAlertType.class);
    }

    public MetaData getMetaData(String type, String name) {
        MetaData metaData = this.getMetaMap(type.toLowerCase())
                .get(name.toLowerCase());

        if (metaData == null) {
            throw new GlobalException(GlobalErrorInfo.NOT_FOUND);
        }
        return metaData;
    }

    private Map<String, MetaData> getMetaMap(String type) {
        Map<String, MetaData> metaDataMap = map.get(type);

        if (metaDataMap == null) {
            throw new GlobalException(GlobalErrorInfo.NOT_FOUND);
        }
        return metaDataMap;
    }

    public void putMetaData(String data, Class<? extends MetaDataProvider> enumClass) {
        this.map.put(data.toLowerCase(), fromEnum(enumClass));
    }

    private Map<String, MetaData> fromEnum(Class<? extends MetaDataProvider> enumClass) {
        Map<String, MetaData> metaDataMap = new HashMap<>();

        Arrays.stream(enumClass.getEnumConstants())
                .map(MetaData::new)
                .forEach(metaData -> metaDataMap.put(metaData.getName().toLowerCase(), metaData));
        return Collections.unmodifiableMap(metaDataMap);
    }
}

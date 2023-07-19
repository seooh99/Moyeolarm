package com.ssafy.moyeolam.domain.meta.converter;

import com.ssafy.moyeolam.domain.meta.domain.MetaDataType;
import com.ssafy.moyeolam.domain.meta.service.MetaDataService;

import javax.persistence.Convert;

@Convert
public class AlarmGroupMemberRoleConverter extends BaseConverter {
    public AlarmGroupMemberRoleConverter(MetaDataService metaDataService) {
        super(metaDataService, MetaDataType.AlarmGroupMemberRole.name());
    }
}

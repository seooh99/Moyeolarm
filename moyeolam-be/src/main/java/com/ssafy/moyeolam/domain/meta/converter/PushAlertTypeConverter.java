package com.ssafy.moyeolam.domain.meta.converter;

import com.ssafy.moyeolam.domain.meta.domain.MetaDataType;
import com.ssafy.moyeolam.domain.meta.service.MetaDataService;

import javax.persistence.Convert;

@Convert
public class PushAlertTypeConverter extends BaseConverter {
    public PushAlertTypeConverter(MetaDataService metaDataService) {
        super(metaDataService, MetaDataType.PUSH_ALERT_TYPE.name());
    }
}

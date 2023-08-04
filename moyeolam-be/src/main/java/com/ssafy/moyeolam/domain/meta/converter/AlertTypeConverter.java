package com.ssafy.moyeolam.domain.meta.converter;

import com.ssafy.moyeolam.domain.meta.domain.MetaDataType;
import com.ssafy.moyeolam.domain.meta.service.MetaDataService;

import javax.persistence.Convert;

@Convert
public class AlertTypeConverter extends BaseConverter {
    public AlertTypeConverter(MetaDataService metaDataService) {
        super(metaDataService, MetaDataType.ALERT_TYPE.name());
    }
}

package com.ssafy.moyeolam.domain.meta.converter;

import com.ssafy.moyeolam.domain.meta.domain.MetaDataType;
import com.ssafy.moyeolam.domain.meta.service.MetaDataService;

import javax.persistence.Convert;

@Convert
public class MatchStatusConverter extends BaseConverter {
    public MatchStatusConverter(MetaDataService metaDataService) {
        super(metaDataService, MetaDataType.MatchStatus.name());
    }
}

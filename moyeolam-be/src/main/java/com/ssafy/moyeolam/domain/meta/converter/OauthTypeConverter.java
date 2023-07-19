package com.ssafy.moyeolam.domain.meta.converter;

import com.ssafy.moyeolam.domain.meta.domain.MetaDataType;
import com.ssafy.moyeolam.domain.meta.service.MetaDataService;

import javax.persistence.Convert;

@Convert
public class OauthTypeConverter extends BaseConverter {
    public OauthTypeConverter(MetaDataService metaDataService) {
        super(metaDataService, MetaDataType.OAUTH_TYPE.name());
    }
}

package com.ssafy.moyeolam.domain.meta.converter;

import com.ssafy.moyeolam.domain.meta.domain.MetaData;
import com.ssafy.moyeolam.domain.meta.domain.MetaDataType;
import com.ssafy.moyeolam.domain.meta.exception.MetaDataException;
import com.ssafy.moyeolam.domain.meta.service.MetaDataService;
import com.ssafy.moyeolam.global.common.exception.GlobalErrorInfo;
import com.ssafy.moyeolam.global.common.exception.GlobalException;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import javax.persistence.AttributeConverter;

@AllArgsConstructor
@Slf4j
public class BaseConverter implements AttributeConverter<MetaData, String> {
    private final MetaDataService metaDataService;
    private final String metaDataType;

    @Override
    public String convertToDatabaseColumn(MetaData attribute) {
        if (attribute == null) return null;
        return attribute.getName();
    }

    @Override
    public MetaData convertToEntityAttribute(String dbData) {
        if (dbData == null) return null;

        MetaData metaData;
        try {
            metaData = metaDataService.getMetaData(metaDataType, dbData);
        } catch (GlobalException e) {
            log.error("Data Integrity error: fail to convert {}", metaDataType);
            throw new MetaDataException(GlobalErrorInfo.INTERNAL_SERVER_ERROR);
        }
        return metaData;
    }
}

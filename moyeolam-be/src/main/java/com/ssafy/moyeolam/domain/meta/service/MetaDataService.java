package com.ssafy.moyeolam.domain.meta.service;

import com.ssafy.moyeolam.domain.meta.domain.MetaData;
import com.ssafy.moyeolam.domain.meta.domain.MetaDataProvider;
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
    }

    public MetaData getMetaData(String type, String name) {
        MetaData metaData = this.getMetaMap(type.toLowerCase()).get(name.toLowerCase());

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

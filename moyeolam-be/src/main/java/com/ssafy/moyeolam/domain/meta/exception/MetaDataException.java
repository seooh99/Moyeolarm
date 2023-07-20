package com.ssafy.moyeolam.domain.meta.exception;

import com.ssafy.moyeolam.global.common.exception.GlobalErrorInfo;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class MetaDataException extends RuntimeException {
    private GlobalErrorInfo info;
}

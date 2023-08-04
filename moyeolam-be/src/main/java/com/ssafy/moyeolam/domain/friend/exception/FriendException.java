package com.ssafy.moyeolam.domain.friend.exception;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class FriendException extends RuntimeException {
    private final FriendErrorInfo info;
}

package com.ssafy.moyeolam.domain.alert.dto;

import com.ssafy.moyeolam.domain.alarmgroup.domain.AlarmGroupRequest;
import com.ssafy.moyeolam.domain.alert.domain.AlertLog;
import com.ssafy.moyeolam.domain.friend.domain.FriendRequest;
import com.ssafy.moyeolam.domain.meta.domain.AlertType;
import com.ssafy.moyeolam.domain.meta.domain.MatchStatus;
import lombok.Builder;
import lombok.Getter;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

@Getter
@Builder
public class FindAlertsResponseDto {
    private List<AlertElement> alerts;

    public static FindAlertsResponseDto of(List<AlertLog> alertLogs, List<FriendRequest> friendRequests, List<AlarmGroupRequest> alarmGroupRequests) {
        List<AlertElement> alertElements = new ArrayList<>();
        alertElements.addAll(getAlertLogs(alertLogs));
        alertElements.addAll(getFriendRequests(friendRequests));
        alertElements.addAll(getAlarmGroupRequests(alarmGroupRequests));
        return FindAlertsResponseDto.builder()
                .alerts(alertElements.stream()
                        .sorted(Comparator.comparing(AlertElement::getModifiedAt).reversed())
                        .collect(Collectors.toList()))
                .build();
    }

    private static List<AlertElement> getAlertLogs(List<AlertLog> alertLogs) {
        // 친구 수락, 알람그룹 수락, 탈퇴, 강퇴, 수정, 해체 로그
        List<AlertElement> alertElements = new ArrayList<>();
        for (AlertLog alertLog : alertLogs) {
            if (alertLog.getAlertType().getName().equals(AlertType.FRIEND_APPROVE.getName())) {
                alertElements.add(AlertElement.builder()
                        .alarmGroupId(null)
                        .friendRequestId(null)
                        .fromMemberId(alertLog.getFromMember().getId())
                        .fromNickname(alertLog.getFromMember().getNickname())
                        .alertType(alertLog.getAlertType().getName())
                        .createAt(alertLog.getCreatedAt())
                        .modifiedAt(alertLog.getCreatedAt())
                        .build()
                );
            } else if (alertLog.getAlertType().getName().equals(AlertType.ALARM_GROUP_APPROVE.getName()) ||
                    alertLog.getAlertType().getName().equals(AlertType.ALARM_GROUP_QUIT.getName()) ||
                    alertLog.getAlertType().getName().equals(AlertType.ALARM_GROUP_BAN.getName()) ||
                    alertLog.getAlertType().getName().equals(AlertType.ALARM_GROUP_UPDATE.getName()) ||
                    alertLog.getAlertType().getName().equals(AlertType.ALARM_GROUP_ABOLISHED.getName())) {

                alertElements.add(AlertElement.builder()
                        .alarmGroupId(alertLog.getAlarmGroup().getId())
                        .friendRequestId(null)
                        .fromMemberId(alertLog.getFromMember().getId())
                        .fromNickname(alertLog.getFromMember().getNickname())
                        .title(alertLog.getAlarmGroup().getTitle())
                        .alertType(alertLog.getAlertType().getName())
                        .createAt(alertLog.getCreatedAt())
                        .modifiedAt(alertLog.getCreatedAt())
                        .build()
                );
            }
        }
        return alertElements;
    }

    private static List<AlertElement> getFriendRequests(List<FriendRequest> friendRequests) {
        // 친구 요청 로그
        List<AlertElement> alertElements = new ArrayList<>();
        for (FriendRequest friendRequest : friendRequests) {
            if (friendRequest.getMatchStatus().getName().equals(MatchStatus.REQUEST_STATUS.getName())) {
                alertElements.add(AlertElement.builder()
                        .alarmGroupId(null)
                        .friendRequestId(friendRequest.getId())
                        .fromMemberId(friendRequest.getFromMember().getId())
                        .fromNickname(friendRequest.getFromMember().getNickname())
                        .alertType(AlertType.FRIEND_REQUEST.getName())
                        .createAt(friendRequest.getCreatedAt())
                        .modifiedAt(friendRequest.getModifiedAt() == null ? friendRequest.getCreatedAt() : friendRequest.getModifiedAt())
                        .build());
            }
        }
        return alertElements;
    }

    private static List<AlertElement> getAlarmGroupRequests(List<AlarmGroupRequest> alarmGroupRequests) {
        // 알람그룹 요청 로그
        List<AlertElement> alertElements = new ArrayList<>();
        for (AlarmGroupRequest alarmGroupRequest : alarmGroupRequests) {
            if (alarmGroupRequest.getMatchStatus().getName().equals(MatchStatus.REQUEST_STATUS.getName())) {
                alertElements.add(AlertElement.builder()
                        .alarmGroupId(alarmGroupRequest.getAlarmGroup().getId())
                        .friendRequestId(null)
                        .fromMemberId(alarmGroupRequest.getFromMember().getId())
                        .fromNickname(alarmGroupRequest.getFromMember().getNickname())
                        .alertType(AlertType.ALARM_GROUP_REQUEST.getName())
                        .time(alarmGroupRequest.getAlarmGroup().getTime())
                        .createAt(alarmGroupRequest.getCreatedAt())
                        .modifiedAt(alarmGroupRequest.getModifiedAt() == null ? alarmGroupRequest.getCreatedAt() : alarmGroupRequest.getModifiedAt())
                        .build());
            }
        }
        return alertElements;
    }
}

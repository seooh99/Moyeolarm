package com.ssafy.moyeolam.domain.notification.service;

import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.FirebaseMessagingException;
import com.google.firebase.messaging.Message;
import com.google.firebase.messaging.Notification;
import com.ssafy.moyeolam.domain.member.domain.FcmToken;
import com.ssafy.moyeolam.domain.member.domain.Member;
import com.ssafy.moyeolam.domain.meta.domain.AlertType;
import com.ssafy.moyeolam.domain.notification.exception.NotificationErrorInfo;
import com.ssafy.moyeolam.domain.notification.exception.NotificationException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@Slf4j
public class NotificationService {

    private final FirebaseMessaging firebaseMessaging;
    private final static String TITLE = "Moyeolam";

    public void sendAllNotification(Member member, String body, AlertType alertType) {
        for (FcmToken fcmToken : member.getFcmTokens()) {
            sendNotification(fcmToken, body, alertType);
        }
    }

    private void sendNotification(FcmToken fcmToken, String body, AlertType alertType) {
        Notification notification = Notification.builder()
                .setTitle(TITLE)
                .setBody(body)
                .build();

        Message message = Message.builder()
                .setToken(fcmToken.getFcmToken())
                .setNotification(notification)
                .putData("notificationType", alertType.getName())
                .build();

        try {
            firebaseMessaging.send(message);
        } catch (FirebaseMessagingException e) {
            log.info(NotificationErrorInfo.NOTIFICATION_SEND_ERROR.getMessage());
//            throw new NotificationException(NotificationErrorInfo.NOTIFICATION_SEND_ERROR);
        }
    }
}

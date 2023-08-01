package com.ssafy.moyeolam.domain.notification.service;

import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.FirebaseMessagingException;
import com.google.firebase.messaging.Message;
import com.google.firebase.messaging.Notification;
import com.ssafy.moyeolam.domain.member.domain.Member;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@Slf4j
public class NotificationService {

    private final FirebaseMessaging firebaseMessaging;
    private final static String TITLE = "Moyeolam";

    public void sendNotification(Member member, String body, String notificationType) {

        Notification notification = Notification.builder()
                .setTitle(TITLE)
                .setBody(body)
                .build();

        Message message = Message.builder()
                .setToken(member.getFcmToken())
                .setNotification(notification)
                .putData("notificationType", notificationType)
                .build();

        try {
            firebaseMessaging.send(message);
        } catch (FirebaseMessagingException e) {
            e.printStackTrace();
        }
    }
}

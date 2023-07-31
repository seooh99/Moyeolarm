package com.ssafy.moyeolam.domain.webrtc.service;

import com.ssafy.moyeolam.domain.webrtc.dto.GetTokenRequestDto;
import com.ssafy.moyeolam.domain.webrtc.exception.WebRtcErrorInfo;
import com.ssafy.moyeolam.domain.webrtc.exception.WebRtcException;
import io.openvidu.java.client.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Service
@Slf4j
public class WebRtcService {
    private final OpenVidu openVidu;
    private final Map<String, Session> mapSessions = new ConcurrentHashMap<>();
    private final Map<String, Map<String, OpenViduRole>> mapSessionNamesTokens = new ConcurrentHashMap<>();

    public WebRtcService(@Value("${openvidu.secret}") String secret, @Value("${openvidu.url}") String openviduUrl) {
        this.openVidu = new OpenVidu(openviduUrl, secret);
    }

    public String getToken(GetTokenRequestDto requestDto) {
        String sessionName = requestDto.getSessionName();
        OpenViduRole role = OpenViduRole.PUBLISHER;

        ConnectionProperties connectionProperties = new ConnectionProperties.Builder()
                .type(ConnectionType.WEBRTC)
                .role(role)
                .data("user_data")
                .build();

        if (this.mapSessions.get(sessionName) != null) {
            try {
                String token = this.mapSessions.get(sessionName).createConnection(connectionProperties).getToken();
                this.mapSessionNamesTokens.get(sessionName).put(token, role);
                return token;
            } catch (OpenViduJavaClientException e) {
                throw new WebRtcException(WebRtcErrorInfo.OPEN_VIDU_JAVA_CLIENT_EXCEPTION);
            } catch (OpenViduHttpException e) {
                if (HttpStatus.NOT_FOUND.value() == e.getStatus()) {
                    this.mapSessions.remove(sessionName);
                    this.mapSessionNamesTokens.remove(sessionName);
                }
            }
        }

        try {
            Session session = this.openVidu.createSession();
            String token = session.createConnection(connectionProperties).getToken();

            this.mapSessions.put(sessionName, session);
            this.mapSessionNamesTokens.put(sessionName, new ConcurrentHashMap<>());
            this.mapSessionNamesTokens.get(sessionName).put(token, role);

            return token;
        } catch (OpenViduJavaClientException e) {
            throw new WebRtcException(WebRtcErrorInfo.OPEN_VIDU_JAVA_CLIENT_EXCEPTION);
        } catch (OpenViduHttpException e) {
            throw new WebRtcException(WebRtcErrorInfo.OPEN_VIDU_HTTP_EXCEPTION);
        }
    }
}

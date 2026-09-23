package com.smhrd.service;

import java.security.Security;

import org.apache.http.HttpResponse;
import org.bouncycastle.jce.provider.BouncyCastleProvider;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import nl.martijndwars.webpush.Notification;
import nl.martijndwars.webpush.PushService;

@Service
public class WebPushService {

    @Value("${vapid.public-key}")
    private String publicKey;

    @Value("${vapid.private-key}")
    private String privateKey;

    @Value("${vapid.subject}")
    private String subject;

    public int sendPush(
            String endpoint,
            String p256dh,
            String auth,
            String title,
            String body) throws Exception {

        // =========================================================
        // 1. Bouncy Castle 등록
        // =========================================================

        if (Security.getProvider("BC") == null) {

            Security.addProvider(
                    new BouncyCastleProvider()
            );
        }


        // =========================================================
        // 2. Push Service 생성
        // =========================================================

        System.out.println("=================================");
        System.out.println("[WebPush] PushService 생성");
        System.out.println("[WebPush] endpoint = " + endpoint);
        System.out.println("[WebPush] VAPID subject = " + subject);
        System.out.println("[WebPush] publicKey 존재 = "
                + (publicKey != null && !publicKey.isBlank()));
        System.out.println("[WebPush] privateKey 존재 = "
                + (privateKey != null && !privateKey.isBlank()));
        System.out.println("=================================");


        PushService pushService =
                new PushService(
                        publicKey,
                        privateKey,
                        subject
                );


        // =========================================================
        // 3. JSON payload
        // =========================================================

        String payload =
                "{"
                + "\"title\":\""
                + escapeJson(title)
                + "\","
                + "\"body\":\""
                + escapeJson(body)
                + "\""
                + "}";


        System.out.println("[WebPush] payload = " + payload);


        // =========================================================
        // 4. Notification 생성
        // =========================================================

        Notification notification =
                new Notification(
                        endpoint,
                        p256dh,
                        auth,
                        payload
                );


        System.out.println("[WebPush] Notification 생성 완료");
        System.out.println("[WebPush] Push 전송 시작");


        // =========================================================
        // 5. Push 전송
        // =========================================================

        HttpResponse response =
                pushService.send(notification);


        // =========================================================
        // 6. 응답 확인
        // =========================================================

        int statusCode =
                response.getStatusLine().getStatusCode();


        String responseBody = "";

        if (response.getEntity() != null) {

            responseBody =
                    org.apache.http.util.EntityUtils
                            .toString(response.getEntity());
        }


        System.out.println("=================================");
        System.out.println("[WebPush] Push 응답");
        System.out.println("[WebPush] 상태 코드 : " + statusCode);
        System.out.println("[WebPush] 상태 : " + response.getStatusLine());
        System.out.println("[WebPush] 응답 본문 : " + responseBody);


        // 응답 헤더 출력
        org.apache.http.Header[] headers =
                response.getAllHeaders();

        for (org.apache.http.Header header : headers) {

            System.out.println(
                    "[WebPush] Header : "
                    + header.getName()
                    + " = "
                    + header.getValue()
            );
        }

        System.out.println("=================================");


        return statusCode;
    }



    private String escapeJson(String value) {

        if (value == null) {
            return "";
        }

        return value
                .replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\n", "\\n")
                .replace("\r", "\\r");
    }
}
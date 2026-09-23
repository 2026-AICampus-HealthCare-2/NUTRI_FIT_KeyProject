self.addEventListener("push", function(event) {

    let data = {
        title: "NUTRI_FIT",
        body: "영양제 복용 시간입니다."
    };

    if (event.data) {

        try {
            data = event.data.json();

        } catch (e) {

            // JSON이 아닌 일반 문자열인 경우
            data.body = event.data.text();
        }
    }

    event.waitUntil(

        self.registration.showNotification(
            data.title,
            {
                body: data.body,
                icon: "/images/nutriFitIcon.png",
                badge: "/images/nutriFitIcon.png",
                data: {
                    url: "/intakeManage"
                }
            }
        )
    );
});


self.addEventListener(
    "notificationclick",
    function(event) {

        event.notification.close();

        event.waitUntil(
            clients.openWindow("/intakeManage")
        );
    }
);
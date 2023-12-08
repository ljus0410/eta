<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
        var ws;

        function connect() {
            ws = new WebSocket("ws://[YOUR_SERVER_URL]/websocket");

            ws.onmessage = function(event) {
                var log = document.getElementById("log");
                var message = event.data;
                log.innerHTML += "<br/>" + message;
            };

            ws.onopen = function(event) {
                // 연결 시 수행할 작업
            };

            ws.onclose = function(event) {
                // 연결 종료 시 수행할 작업
            };
        }
    </script>
</head>
<body onload="connect();">
	<div id="log"></div>
</body>
</html>
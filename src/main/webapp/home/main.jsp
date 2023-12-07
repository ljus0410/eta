<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="EUC-KR">
    <title>Responsive Web</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <style>
        body {
            overflow: hidden; /* 스크롤 제거 */
        }
        .my-container {
            margin-top: 0;
            /* 조절 가능한 margin-top 값을 설정하세요 */
        }
        .center-content {
            text-align: center;
        }

        /* 미디어 쿼리 사용하여 화면 크기에 따라 스타일 조절 */
        @media (max-width: 576px) { /* 작은 화면일 때 */
            .mt-3 {
                flex-direction: column;
            }
        }

        @media (min-width: 577px) { /* 큰 화면일 때 */
            .mt-3 {
                flex-direction: row;
            }
        }
    </style>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
</head>
<body>

<div class="d-flex flex-column align-items-center vh-100 my-container center-content">
    <div class="input-group input-group-lg my-input-group" style="max-width: 600px;">
        <span class="input-group-text" id="inputGroup-sizing-lg">Text</span>
        <input type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg">
    </div>

    <div class="mt-3 d-flex">
        <button type="button" class="btn btn-primary me-2">Button 1</button>
        <button type="button" class="btn btn-secondary me-2">Button 2</button>
        <button type="button" class="btn btn-success me-2">Button 3</button>
        <button type="button" class="btn btn-danger">Button 4</button>
    </div>
</div>

</body>
</html>

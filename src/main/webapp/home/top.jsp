<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
    crossorigin="anonymous"></script>
<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
    rel="stylesheet"
    integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
    crossorigin="anonymous">



<style>
/* Custom styles for changing the color */
.navbar-dark {
    background-color: gray;
}

.navbar-toggler-icon {
    background-color: white;
}

.navbar-brand, .navbar-nav .nav-link {
    color: black;
}

.navbar-toggler {
    border-color: white;
}

/* 스크롤 제거 스타일 추가 */
body {
    overflow: hidden;
}

/* 반응형 웹 레이아웃 조정 */
@media (max-width: 767px) {
    /* 화면 크기가 767px 이하인 경우에만 적용됨 */
    .navbar-nav {
        flex-direction: column;
        align-items: center;
    }

    .navbar-nav .nav-item {
        margin-bottom: 10px;
    }
}
</style>
 <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script type="text/javascript">
$(function() {
    
   
	$("#loginButton").on("click", function() {
	    self.location = "/user/login"
	});

	    $(".callreq").on("click", function() {
	        self.location.href = "/callreq/home.jsp";
	    });
	    
	    $(".callres").on("click", function() {
	          self.location.href = "/callres/home.jsp";
	      });
	    
	    $(".community").on("click", function() {
            self.location.href = "/community/home.jsp";
        });
	    
	    $(".feedback").on("click", function() {
            self.location.href = "/feedback/home.jsp";
        });
	    
	    $(".notice").on("click", function() {
            self.location.href = "/notice/home.jsp";
        });
	    
	    $(".pay").on("click", function() {
            self.location.href = "/pay/home.jsp";
        });
	    
	    $(".info").on("click", function() {
            self.location.href = "/user/getUser.jsp";
        });

});
</script> 

</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container-fluid">

            <div class="btn-group">
                <button type="button" data-bs-toggle="dropdown" aria-haspopup="true"
                    aria-expanded="false">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20"
                        fill="currentColor" class="bi bi-justify" viewBox="0 0 16 16">
                        <path fill-rule="evenodd"
                            d="M2 12.5a.5.5 0 0 1 .5-.5h11a.5.5 0 0 1 0 1h-11a.5.5 0 0 1-.5-.5zm0-3a.5.5 0 0 1 .5-.5h11a.5.5 0 0 1 0 1h-11a.5.5 0 0 1-.5-.5zm0-3a.5.5 0 0 1 .5-.5h11a.5.5 0 0 1 0 1h-11a.5.5 0 0 1-.5-.5zm0-3a.5.5 0 0 1 .5-.5h11a.5.5 0 0 1 0 1h-11a.5.5 0 0 1-.5-.5z" />
                    </svg>
                </button>
                <ul class="dropdown-menu">
                    <li><a class="dropdown-item callreq" href="#">callreq</a></li>
                    <li><a class="dropdown-item callres" href="#">callres</a></li>
                    <li><a class="dropdown-item community" href="#">community</a></li>
                    <li><a class="dropdown-item feedback" href="#">feedback</a></li>
                    <li><a class="dropdown-item notice" href="#">notice</a></li>
                    <li><a class="dropdown-item pay" href="#">pay</a></li>
                    <li><a class="dropdown-item info" href="#">내정보</a></li>
                </ul>
            </div>
            <div class="d-flex flex-grow-1 justify-content-center">
                <a class="navbar-brand" href="#">eTa</a>
            </div>
           <div class="text-end">
            <button type="button" class="btn btn-outline-light me-2" id="loginButton">Login</button>
            </div>

        </div>
    </nav>

</body>
</html>

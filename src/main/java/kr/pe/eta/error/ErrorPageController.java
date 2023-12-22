package kr.pe.eta.error;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class ErrorPageController {

	public static final String ERROR_EXCEPTION_TYPE = "jakarta.servlet.error.exception_type";

	@RequestMapping("/error/400")
	public String errorPage400(HttpServletRequest request, HttpServletResponse response) {

		System.out.println("/error/400 GET");
		return "/error/400.jsp";
	}

	@RequestMapping("/error/401")
	public String errorPage401(HttpServletRequest request, HttpServletResponse response) {

		System.out.println("/error/401 GET");
		return "/error/401.jsp";
	}

	@RequestMapping("/error/403")
	public String errorPage403(HttpServletRequest request, HttpServletResponse response) {

		System.out.println("/error/403 GET");
		return "/error/403.jsp";
	}

	@RequestMapping("/error/404")
	public String errorPage404(HttpServletRequest request, HttpServletResponse response) {

		System.out.println("/error/404 GET");
		return "/error/404.jsp";
	}

	@RequestMapping("/error/500")
	public String errorPage500(HttpServletRequest request, HttpServletResponse response) {

		System.out.println("/error/500 GET");
		return "/error/500.jsp";
	}

	@RequestMapping("/error/500ex")
	public String errorPage500ex(HttpServletRequest request, HttpServletResponse response) {

		System.out.println("/error/500ex GET");
		return "/error/500ex.jsp";
	}

}

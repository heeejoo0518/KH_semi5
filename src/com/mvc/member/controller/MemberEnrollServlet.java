package com.mvc.member.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mvc.member.model.service.MemberService;
import com.mvc.member.model.vo.Member;


@WebServlet(name="enroll",urlPatterns="/member/enroll")
public class MemberEnrollServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	private MemberService service = new MemberService();
	
    public MemberEnrollServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/views/member/enroll.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Member member = new Member();
		int LocationNum = 0;
		
		switch(request.getParameter("Member_LocationNum")) {
			case "Seoul" :				LocationNum = 1; break;
			case "Gyeonggi" :			LocationNum = 2; break;
			case "Daegu" :				LocationNum = 3; break;
			case "Incheon" :			LocationNum = 4; break;
			case "Gwangju" :			LocationNum = 5; break;
			case "Daejeon" :			LocationNum = 6; break;
			case "Ulsan" :				LocationNum = 7; break;
			case "Busan" :				LocationNum = 8; break;
			case "Gangwon" :			LocationNum = 9; break;
			case "South_Chungcheong" :	LocationNum = 10; break;
			case "North_Chungcheong" :	LocationNum = 11; break;
			case "South_Jeolla" :		LocationNum = 12; break;
			case "North_Jeolla" :		LocationNum = 13; break;
			case "South_Gyeongsang" :	LocationNum = 14; break;
			case "North_Gyeongsang" :	LocationNum = 15; break;
			case "Jeju" :				LocationNum = 16; break;
			case "Sejong" :				LocationNum = 17; break;
		}
		
		member.setMember_Id(request.getParameter("Member_Id"));
		member.setMember_Pw(request.getParameter("Member_Pw"));
		member.setMember_NickName(request.getParameter("Member_NickName"));
		member.setMember_Birth(request.getParameter("Member_Birth"));
		member.setMember_Email(request.getParameter("Member_Email"));
		member.setMember_LocationNum(String.valueOf(LocationNum));
		
		int result = service.enrollMember(member);
		
		if(result > 0) {
			request.setAttribute("msg","회원가입성공!");
			request.setAttribute("location", "/");
		
		}else {
			
			System.out.println(result);
			request.setAttribute("msg","회원가입실패!");
			request.setAttribute("location", "/member/enroll");
	
		}
		
		request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
	}

}

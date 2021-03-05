package com.goobne;

import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.goobne.CustomInfo;
import com.util.DBConn;
import com.util.MyUtil;

public class GoobneServlet extends HttpServlet{

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

	protected void forward(HttpServletRequest req, HttpServletResponse resp, String url) throws ServletException, IOException {
		RequestDispatcher rd = req.getRequestDispatcher(url);
		rd.forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		Connection conn = DBConn.getConnection();
		ProductDAO daoProduct = new ProductDAO(conn);
		ReviewDAO daoReview = new ReviewDAO(conn);
		UserInfoDAO daoUserInfo = new UserInfoDAO(conn);
		UserInfoDTO dtoUserInfo=null;
		OrderInfoDAO daoOrderInfo=new OrderInfoDAO(conn);
		OrderInfoDTO dtoOrderInfo=null;
		QnaDAO daoQna = new QnaDAO(conn);
		CartDAO daoCart = new CartDAO(conn);
		MyUtil myUtill = new MyUtil();
		String cp = req.getContextPath();
		String uri = req.getRequestURI();
		String url;
		ProductDTO dtoProduct = null;





		if (uri.indexOf("index.do")!= -1) {

			List<ProductDTO> lists = daoProduct.getListsRandom();
			req.setAttribute("lists", lists);

			url = "/goobne/index.jsp";
			forward(req, resp, url);

		}else if (uri.indexOf("user/signin.do")!= -1) {

			url = "/goobne/user/signin.jsp";
			forward(req, resp, url);

		} else if (uri.indexOf("user/signin_ok.do")!= -1) {

			String id = req.getParameter("id");
			String pwd = req.getParameter("pwd");

			UserInfoDTO dto = daoUserInfo.getReadData(id);
			if (dto == null || (!dto.getPwd().equals(pwd))) {

				req.setAttribute("message", 
						"아이디 or 패스워드 체크(나중에문구수정)");


				url = "/goobnemall/user/signin.do";
				forward(req, resp, url);
				return;				
			}

			HttpSession session = req.getSession();

			CustomInfo info = new CustomInfo();

			info.setUserId(dto.getId());
			info.setUserName(dto.getName());

			session.setAttribute("customInfo", info);

			url =cp+ "/goobnemall/index.do";
			resp.sendRedirect(url);

		} else if (uri.indexOf("logout.do")!= -1) {

			HttpSession session = req.getSession();

			session.removeAttribute("customInfo");
			session.invalidate();

			url = cp+"/goobnemall/index.do";
			resp.sendRedirect(url);

		}else if (uri.indexOf("user/signup.do")!= -1) {
			String idVal = req.getParameter("idVal");
			req.setAttribute("idVal", idVal);
			url = "/goobne/user/signup.jsp";
			forward(req, resp, url);

		}else if (uri.indexOf("user/signup_ok.do")!= -1) {

			UserInfoDTO dto = new UserInfoDTO();
			String id = req.getParameter("id");			

			String tel1 = req.getParameter("tel1");
			String tel2 = req.getParameter("tel2");
			String tel3 = req.getParameter("tel3");
			String tel = tel1 + "-" + tel2 + "-" + tel3;

			String email1 = req.getParameter("email1");
			String email2 = req.getParameter("email2");
			String email = email1 + "@" + email2;

			String addr1 = req.getParameter("addr1");
			String addr2 = req.getParameter("addr2");
			String addr3 = req.getParameter("addr3");
			String addr4 = req.getParameter("addr4");
			String addr5 = req.getParameter("addr5");
			String addr = "[" + addr1 + "] " + addr2 + addr3 + " " + addr4 + addr5;

			String birthy = req.getParameter("birthy");
			String birthm = req.getParameter("birthm");
			String birthd = req.getParameter("birthd");
			String birth = birthy + "-" + birthm + "-" + birthd;

			dto.setId(req.getParameter("id"));
			dto.setPwd(req.getParameter("pwd"));
			dto.setName(req.getParameter("name"));
			dto.setEmail(email);
			dto.setBirth(birth);
			dto.setGender(req.getParameter("gender"));
			dto.setTel(tel);
			dto.setAddr(addr);

			daoUserInfo.insertData(dto);

			req.setAttribute("dto", dto);

			url = "/goobne/index.jsp";
			forward(req, resp, url);

		}else if (uri.indexOf("user/signChk.do")!= -1) {

			if(!daoUserInfo.idChk(req.getParameter("id"))){

				req.setAttribute("chk",0);
				req.setAttribute("idVal","");
				url = "/goobnemall/user/signup.do";
				forward(req, resp, url);
				return;
			}
			req.setAttribute("chk", 1);
			req.setAttribute("idVal", req.getParameter("id"));
			url = "/goobne/user/signup.jsp";
			forward(req, resp, url);


		}else if (uri.indexOf("user/mypage.do")!= -1) {

			HttpSession session = req.getSession();
			CustomInfo info = (CustomInfo)session.getAttribute("customInfo");
			String id = info.getUserId();

			dtoUserInfo = daoUserInfo.getReadData(id);

			//사실 그냥 user info를 가져오는거지만 긁어오느라 buyer입니다..헤헤
			String buyerTel1=dtoUserInfo.getTel().substring(0, dtoUserInfo.getTel().indexOf("-"));
			String buyerTel2=dtoUserInfo.getTel().substring(dtoUserInfo.getTel().indexOf("-")+1, dtoUserInfo.getTel().lastIndexOf("-"));
			String buyerTel3=dtoUserInfo.getTel().substring(dtoUserInfo.getTel().lastIndexOf("-")+1);
			String buyerEmail1=dtoUserInfo.getEmail().substring(0, dtoUserInfo.getEmail().indexOf("@"));
			String buyerEmail2=dtoUserInfo.getEmail().substring(dtoUserInfo.getEmail().indexOf("@")+1);
			String created=dtoUserInfo.getCreated().substring(0, dtoUserInfo.getCreated().indexOf(":")-2);

			req.setAttribute("buyerTel1", buyerTel1);
			req.setAttribute("buyerTel2", buyerTel2);
			req.setAttribute("buyerTel3", buyerTel3);
			req.setAttribute("buyerEmail1", buyerEmail1);
			req.setAttribute("buyerEmail2", buyerEmail2);
			req.setAttribute("created", created);

			List<OrderInfoDTO> listsOrderInfoDto=daoOrderInfo.getList(id);
			List<ProductDTO> listsProductDto=new ArrayList<ProductDTO>();

			Iterator<OrderInfoDTO> it=listsOrderInfoDto.iterator();
			while(it.hasNext()) {

				listsProductDto.add(new ProductDAO(conn).getReadData(it.next().getProductNum()));				
			}
			////
			int totalAllCost = 0;
			for (int i = 0; i < listsOrderInfoDto.size(); i++) 
				totalAllCost +=listsOrderInfoDto.get(i).getTotalCost();
			///
			String grade="";
			if(totalAllCost<10000)
				grade="브론즈";
			else if(totalAllCost>=10000 && totalAllCost<50000)
				grade="실버";
			else if(totalAllCost>=50000 && totalAllCost<100000)
				grade="골드";
			else if(totalAllCost>=100000)
				grade="다이아몬드";

			req.setAttribute("it", it);
			req.setAttribute("grade", grade);
			req.setAttribute("totalAllCost", totalAllCost);
			req.setAttribute("listsOrderInfoDto", listsOrderInfoDto);
			req.setAttribute("listsProductDto", listsProductDto);


			url = "/goobne/user/mypage.jsp";
			forward(req, resp, url);

		}else if (uri.indexOf("product/list.do")!= -1) {
			String category1 = req.getParameter("category1");
			String category2 = req.getParameter("category2");
			List<ProductDTO> lists;
			if(category1==null && category2!=null) {
				lists = daoProduct.getListsCat2(category2);
			}else if(category2==null && category1!=null) {
				lists = daoProduct.getListsCat1(category1);
			}else {
				lists = daoProduct.getLists();
			}

			req.setAttribute("lists", lists);

			req.setAttribute("category1", category1);
			req.setAttribute("category2", category2);

			url = "/goobne/product/list.jsp";
			forward(req, resp, url);

		}else if (uri.indexOf("product/listdetail.do")!= -1) {
			//url 주소 확인
			//
			if (uri.indexOf("product/listdetail.do_cart")!= -1) {
				CartDTO dtoCart = daoCart.getReadData(Integer.parseInt(req.getParameter("num")));
				ProductDTO dto = daoProduct.getData(dtoCart.getProductName());
				int score = daoReview.getAvgScore(dtoCart.getProductName());
				if(score==0) {
					req.setAttribute("score", "등록된 점수가 없습니다");
				}else {
					String str="";
					for (int i = 0; i < score; i++)str+="★";
					for (int i = 0; i < 5-score; i++)str+="☆";
					req.setAttribute("score", str);
				}
				req.setAttribute("dto", dto);
				url = "/goobne/product/listdetail.jsp";//이 list는 이제 실제 판매 페이지를 보여줌
				forward(req, resp, url);
			}else {
				ProductDTO dto = daoProduct.getReadData(req.getParameter("productNum"));
				req.setAttribute("dto", dto);
				int score = daoReview.getAvgScore(dto.getProductName());
				if(score==0) {
					req.setAttribute("score", "등록된 점수가 없습니다");
				}else {
					String str="";
					for (int i = 0; i < score; i++)str+="★";
					for (int i = 0; i < 5-score; i++)str+="☆";
					req.setAttribute("score", str);
				}
				url = "/goobne/product/listdetail.jsp";//이 list는 이제 실제 판매 페이지를 보여줌
				forward(req, resp, url);

			}

		}else if (uri.indexOf("product/review.do")!= -1) {

			HttpSession session = req.getSession();
			CustomInfo info = (CustomInfo)session.getAttribute("customInfo");
			String id = info.getUserId();
			UserInfoDTO dto = daoUserInfo.getReadData(id);
			ProductDTO dto1 = daoProduct.getReadData(req.getParameter("productNum"));
			String productNum = req.getParameter("productNum");
			String pageNum = req.getParameter("pageNum");
			int orderNum = 0;
			if(req.getParameter("orderNum")!=null) {
				orderNum = Integer.parseInt(req.getParameter("orderNum"));
			}
			//추가한부분
			int score = daoReview.getAvgScore(dto1.productName);
			//
			int currentPage = 1;
			if(pageNum!=null)
				currentPage = Integer.parseInt(pageNum);

			int dataCount = daoReview.getTotalData(dto1.getProductName());

			int numPerPage = 2;
			int totalPage = myUtill.getPageCount(numPerPage, dataCount);
			if(currentPage>totalPage)
				currentPage = totalPage;
			int start = (currentPage-1)*numPerPage+1;
			int end = currentPage*numPerPage;

			List<ReviewDTO> lists =
					daoReview.getList(start, end, dto1.getProductName());

			String param = "";
			if(!productNum.equals("")) {
				param+= "productNum=" + URLEncoder.encode(productNum,"UTF-8") +"&orderNum=" +orderNum;
			}
			String listUrl = cp + "/goobnemall/product/review.do";
			//param이 null이 아니면 검색을 했다는 것!!
			if(!param.equals("")) {
				listUrl += "?" + param;
			}

			String pageIndexList = 
					myUtill.pageIndexList(currentPage, totalPage, listUrl);
			//추가한부분
			if(score==0) {
				req.setAttribute("score", "등록된 점수가 없습니다");
			}else {
				String str="";
				for (int i = 0; i < score; i++)str+="★";
				for (int i = 0; i < 5-score; i++)str+="☆";
				req.setAttribute("score", str);
			}
			req.setAttribute("productName", dto1.getProductName());
			//글보기 주소
			req.setAttribute("productNum",dto1.getProductNum());
			req.setAttribute("name", dto.getName());
			req.setAttribute("lists", lists);
			req.setAttribute("pageIndexList", pageIndexList);
			req.setAttribute("dataCount", dataCount);
			req.setAttribute("orderNum", orderNum);

			url = "/goobne/product/review.jsp";//이 list는 이제 실제 판매 페이지를 보여줌
			forward(req, resp, url);

		}else if(uri.indexOf("product/review_ok.do")!=-1) {

			HttpSession session = req.getSession();

			CustomInfo info = (CustomInfo)session.getAttribute("customInfo");
			String id = info.getUserId();
			int orderNum = Integer.parseInt(req.getParameter("orderNum"));
			ProductDTO dto1 = daoProduct.getReadData(req.getParameter("productNum"));
			ReviewDTO dto = new ReviewDTO();
			int maxNum = daoReview.getMaxNum();

			dto.setOrderNum(orderNum);//이거는 나중에 상품주문 완료되면 바꿔줘야함
			dto.setProductName(dto1.getProductName());
			dto.setId(id);
			dto.setScore(Integer.parseInt(req.getParameter("score")));
			dto.setReviewNum(maxNum+1);
			dto.setSubject(req.getParameter("subject"));
			dto.setContent(req.getParameter("content"));
			daoReview.insertData(dto);

			req.setAttribute("productNum", dto1.getProductNum());

			url = "/goobnemall/product/review.do";//이 list는 이제 실제 판매 페이지를 보여줌
			forward(req, resp, url);
			/*url = "/goobnemall/product/review.do";
			resp.sendRedirect(url);*/
			
		}else if (uri.indexOf("product/review_delete_ok.do")!= -1) {

			int reviewNum = Integer.parseInt(req.getParameter("reviewNum"));
			
			daoReview.deleteData(reviewNum);
			
			url = cp + "/goobnemall/product/review.do?";
			resp.sendRedirect(url);	

		}else if (uri.indexOf("product/purchase.do")!= -1) {

			int count = Integer.parseInt(req.getParameter("count"));
			ProductDTO dto = daoProduct.getReadData(req.getParameter("productNum"));
			req.setAttribute("dto", dto);
			req.setAttribute("count", count);

			url = "/goobne/product/purchase.jsp";//이 list는 이제 실제 판매 페이지를 보여줌
			forward(req, resp, url);

		}else if (uri.indexOf("order.do")!=-1) {

			HttpSession session = req.getSession();
			CustomInfo info = (CustomInfo)session.getAttribute("customInfo");
			String id = info.getUserId();
			dtoUserInfo=daoUserInfo.getReadData(id);
			//------------------------------------------------
			List<CartDTO> listsCartDto = daoCart.getList(id);
			req.setAttribute("listsCartDto", listsCartDto);
			//------------------------------------------------
			List<OrderInfoDTO> listsOrderInfoDto=daoOrderInfo.getList(id);
			List<String> pic1Addr=new ArrayList<String>();
			Iterator<OrderInfoDTO> it=listsOrderInfoDto.iterator();
			while(it.hasNext()) {
				pic1Addr.add(new ProductDAO(conn).getReadData(it.next().getProductNum()).getPic1());
			}

			req.setAttribute("listsOrderInfoDto", listsOrderInfoDto);
			req.setAttribute("pic1Addr", pic1Addr);




			//----------------------

			String productNum=req.getParameter("productNum");
			int qty=Integer.parseInt(req.getParameter("qty"));
			int deliveryFee=0;

			dtoProduct=new ProductDTO();
			dtoProduct=daoProduct.getReadData(productNum);

			if(dtoProduct.getPrice()*qty>=30000) {
				deliveryFee=0;
			}else {
				deliveryFee=3000;
			}

			String buyerTel1=dtoUserInfo.getTel().substring(0, dtoUserInfo.getTel().indexOf("-"));
			String buyerTel2=dtoUserInfo.getTel().substring(dtoUserInfo.getTel().indexOf("-")+1, dtoUserInfo.getTel().lastIndexOf("-"));
			String buyerTel3=dtoUserInfo.getTel().substring(dtoUserInfo.getTel().lastIndexOf("-")+1);
			String buyerEmail1=dtoUserInfo.getEmail().substring(0, dtoUserInfo.getEmail().indexOf("@"));
			String buyerEmail2=dtoUserInfo.getEmail().substring(dtoUserInfo.getEmail().indexOf("@")+1);
			req.setAttribute("dtoUserInfo", dtoUserInfo);
			req.setAttribute("dtoProduct", dtoProduct);
			req.setAttribute("qty", qty);
			req.setAttribute("deliveryFee", deliveryFee);
			req.setAttribute("buyerTel1", buyerTel1);
			req.setAttribute("buyerTel2", buyerTel2);
			req.setAttribute("buyerTel3", buyerTel3);
			req.setAttribute("buyerEmail1", buyerEmail1);
			req.setAttribute("buyerEmail2", buyerEmail2);

			url="/goobne/order/orderMain.jsp";
			forward(req, resp, url);
			
		}else if (uri.indexOf("order_cart.do")!=-1) {

			HttpSession session = req.getSession();
			CustomInfo info = (CustomInfo)session.getAttribute("customInfo");
			String id = info.getUserId();
			dtoUserInfo=daoUserInfo.getReadData(id);
			List<CartDTO> listsCartDto = daoCart.getList(id);
			req.setAttribute("listsCartDto", listsCartDto);
			List<OrderInfoDTO> listsOrderInfoDto=daoOrderInfo.getList(id);
			List<String> pic1Addr=new ArrayList<String>();
			Iterator<OrderInfoDTO> it=listsOrderInfoDto.iterator();
			while(it.hasNext()) {
				pic1Addr.add(new ProductDAO(conn).getReadData(it.next().getProductNum()).getPic1());
			}

			req.setAttribute("listsOrderInfoDto", listsOrderInfoDto);
			req.setAttribute("pic1Addr", pic1Addr);

			//----------------------

			int deliveryFee=3000;

			dtoProduct=new ProductDTO();
			int totPrice =0;
			for (int i = 0; i < listsCartDto.size(); i++) {
				totPrice+=listsCartDto.get(i).getPrice();
			}
			if(totPrice>=30000)
				deliveryFee=0;

			String buyerTel1=dtoUserInfo.getTel().substring(0, dtoUserInfo.getTel().indexOf("-"));
			String buyerTel2=dtoUserInfo.getTel().substring(dtoUserInfo.getTel().indexOf("-")+1, dtoUserInfo.getTel().lastIndexOf("-"));
			String buyerTel3=dtoUserInfo.getTel().substring(dtoUserInfo.getTel().lastIndexOf("-")+1);
			String buyerEmail1=dtoUserInfo.getEmail().substring(0, dtoUserInfo.getEmail().indexOf("@"));
			String buyerEmail2=dtoUserInfo.getEmail().substring(dtoUserInfo.getEmail().indexOf("@")+1);
			req.setAttribute("dtoUserInfo", dtoUserInfo);
			req.setAttribute("deliveryFee", deliveryFee);
			req.setAttribute("buyerTel1", buyerTel1);
			req.setAttribute("totPrice", totPrice);
			req.setAttribute("buyerTel2", buyerTel2);
			req.setAttribute("buyerTel3", buyerTel3);
			req.setAttribute("buyerEmail1", buyerEmail1);
			req.setAttribute("buyerEmail2", buyerEmail2);

			url="/goobne/order/orderMain_Cart.jsp";
			forward(req, resp, url);
			
		}else if(uri.indexOf("personalInformationPolicy.do")!=-1) {

			url="/goobne/order/personalInformationPolicy.jsp";
			forward(req, resp, url);
			
		}else if(uri.indexOf("order_ok.do")!=-1) {

			HttpSession session = req.getSession();
			CustomInfo info = (CustomInfo)session.getAttribute("customInfo");
			String id = info.getUserId();

			dtoOrderInfo=new OrderInfoDTO();
			int maxNum=daoOrderInfo.getMaxNum();

			String deliveryFee=req.getParameter("deliveryFee");
			dtoProduct=daoProduct.getReadData(req.getParameter("productNum"));
			dtoOrderInfo.setOrderNum(maxNum+1);
			dtoOrderInfo.setBuyerName(req.getParameter("buyerName"));
			dtoOrderInfo.setId(id);
			dtoOrderInfo.setProductNum(req.getParameter("productNum"));
			dtoOrderInfo.setQty(Integer.parseInt(req.getParameter("qty")));
			String buyerTel1=req.getParameter("buyerTel1");
			String buyerTel2=req.getParameter("buyerTel2");
			String buyerTel3=req.getParameter("buyerTel3");
			String buyerTel=buyerTel1+"-"+buyerTel2+"-"+buyerTel3;
			dtoOrderInfo.setBuyerTel(buyerTel);
			String buyerEmail1=req.getParameter("buyerEmail1");
			String buyerEmail2=req.getParameter("buyerEmail2");
			String buyerEmail=buyerEmail1+"@"+buyerEmail2;
			dtoOrderInfo.setBuyerEmail(buyerEmail);
			dtoOrderInfo.setGetterName(req.getParameter("getterName"));
			String getterTel1a=req.getParameter("getterTel1");
			String getterTel1b=req.getParameter("getterTel2");
			String getterTel1c=req.getParameter("getterTel3");
			String getterTel1=getterTel1a+"-"+getterTel1b+"-"+getterTel1c;
			dtoOrderInfo.setGetterTel1(getterTel1);
			String getterTel2a=req.getParameter("getterTel4");
			String getterTel2b=req.getParameter("getterTel5");
			String getterTel2c=req.getParameter("getterTel6");
			String getterTel2=getterTel2a+"-"+getterTel2b+"-"+getterTel2c;
			if(getterTel2.equals("--")) {
				getterTel2="";
			}
			dtoOrderInfo.setGetterTel2(getterTel2);
			dtoOrderInfo.setGetterZip(req.getParameter("getterZip"));
			String getterAddr1=req.getParameter("getterAddr1");
			String getterAddr2=req.getParameter("getterAddr2");
			String getterAddr3=req.getParameter("getterAddr3");
			String getterAddr=getterAddr1+" "+getterAddr2+" "+getterAddr3;
			dtoOrderInfo.setGetterAddr(getterAddr);
			dtoOrderInfo.setGetterMsg(req.getParameter("getterMsg"));
			dtoOrderInfo.setPayWay(req.getParameter("payWay"));
			dtoOrderInfo.setPayerName(req.getParameter("payerName"));
			dtoOrderInfo.setBankName(req.getParameter("bankName"));
			dtoOrderInfo.setTotalCost(Integer.parseInt(req.getParameter("totalCost")));
			dtoOrderInfo.setOrderState("배송전");

			daoOrderInfo.insertData(dtoOrderInfo);

			req.setAttribute("dtoProduct", dtoProduct);
			req.setAttribute("dtoOrderInfo", dtoOrderInfo);
			req.setAttribute("deliveryFee", deliveryFee);

			url="/goobne/order/orderComplete.jsp";
			forward(req, resp, url);
		} else if (uri.indexOf("qna/created.do")!= -1) {

			url = "/goobne/qna/created.jsp";
			forward(req, resp, url);			

		} else if (uri.indexOf("qna/created_ok.do")!= -1) {

			QnaDTO dto = new QnaDTO();

			int maxNum = daoQna.getMaxNum();
			dto.setQnaNum(maxNum + 1);
			dto.setId(req.getParameter("id"));
			dto.setSubject(req.getParameter("subject"));
			dto.setContent(req.getParameter("content"));

			daoQna.insertData(dto);

			url = cp + "/goobnemall/qna/list.do";
			resp.sendRedirect(url);

		} else if (uri.indexOf("qna/list.do")!= -1) {

			String pageNum = req.getParameter("pageNum");

			int currentPage = 1;

			if (pageNum != null)
				currentPage = Integer.parseInt(pageNum);

			String searchKey = req.getParameter("searchKey");
			String searchValue = req.getParameter("searchValue");

			if (searchValue == null) {

				searchKey = "subject";
				searchValue = "";

			} else {

				if (req.getMethod().equalsIgnoreCase("GET"))
					searchValue = URLDecoder.decode(searchValue, "UTF-8");
			}

			int dataCount = daoQna.getDataCount(searchKey, searchValue);

			int numPerPage = 5;
			int totalPage = myUtill.getPageCount(numPerPage, dataCount);

			if (currentPage > totalPage)
				currentPage = totalPage;

			int start = (currentPage-1)*numPerPage+1;
			int end = currentPage*numPerPage;

			List<QnaDTO> lists =
					daoQna.getList(start, end, searchKey, searchValue);

			String param = "";
			if (!searchValue.equals("")) {
				param = "searchKey=" + searchKey;
				param += "&searchValue=" + URLEncoder.encode(searchValue, "UTF-8");
			}

			String listUrl = cp + "/goobnemall/qna/list.do";

			if (!param.equals("")) {
				listUrl += "?" + param;
			}

			String pageIndexList = 
					myUtill.pageIndexList(currentPage, totalPage, listUrl);

			String articleUrl = cp + "/goobnemall/qna/article.do?pageNum=" + currentPage;

			if (!param.equals("")) {
				articleUrl += "&" + param;
			}

			req.setAttribute("lists", lists);
			req.setAttribute("pageIndexList", pageIndexList);
			req.setAttribute("dataCount", dataCount);
			req.setAttribute("articleUrl", articleUrl);

			url = "/goobne/qna/list.jsp";
			forward(req, resp, url);

		} else if (uri.indexOf("qna/article.do")!= -1) {

			int qnaNum = Integer.parseInt(req.getParameter("qnaNum"));
			String pageNum = req.getParameter("pageNum");

			String searchKey = req.getParameter("searchKey");
			String searchValue = req.getParameter("searchValue");

			if (searchValue != null) {
				searchValue = URLDecoder.decode(searchValue, "UTF-8");
			}

			QnaDTO dto = daoQna.getReadData(qnaNum);

			if (dto == null) {
				url = cp + "/goobnemall/qna/list.do";
				resp.sendRedirect("url"); 
			}

			int lineSu = dto.getContent().split("\n").length;

			dto.setContent(dto.getContent().replaceAll("\n", "<br/>"));

			String param = "pageNum=" + pageNum;

			if (searchValue != null) {

				param += "&searchKey=" + searchKey;
				param += "&searchValue=" + URLEncoder.encode(searchValue, "UTF-8");

			}

			req.setAttribute("dto", dto);
			req.setAttribute("params", param);
			req.setAttribute("lineSu", lineSu);
			req.setAttribute("pageNum", pageNum);

			url = "/goobne/qna/article.jsp";
			forward(req, resp, url);			

		} else if (uri.indexOf("qna/updated.do")!= -1) {

			int qnaNum = Integer.parseInt(req.getParameter("qnaNum"));
			String pageNum = req.getParameter("pageNum");

			String searchKey = req.getParameter("searchKey");
			String searchValue = req.getParameter("searchValue");

			if (searchValue != null) {
				searchValue = URLDecoder.decode(searchValue, "UTF-8");
			}

			QnaDTO dto = daoQna.getReadData(qnaNum);

			if (dto == null) {
				url = cp + "/goobnemall/qna/list.do";
				resp.sendRedirect(url);
			}

			String param = "pageNum=" + pageNum;

			if (searchValue != null) {
				param += "&searchKey=" + searchKey;
				param += "&searchValue="
						+ URLEncoder.encode(searchValue, "UTF-8");
			}

			req.setAttribute("dto", dto);
			req.setAttribute("pageNum", pageNum);
			req.setAttribute("params", param);
			req.setAttribute("searchKey", searchKey);
			req.setAttribute("searchValue", searchValue);	

			url = "/goobne/qna/updated.jsp";
			forward(req, resp, url);			

		} else if (uri.indexOf("qna/updated_ok.do")!= -1) {

			int qnaNum = Integer.parseInt(req.getParameter("qnaNum"));
			String pageNum = req.getParameter("pageNum");

			String searchKey = req.getParameter("searchKey");
			String searchValue = req.getParameter("searchValue");

			if (searchValue != null) {
				searchValue = URLDecoder.decode(searchValue, "UTF-8");
			}

			QnaDTO dto = new QnaDTO();

			dto.setQnaNum(qnaNum);
			dto.setId(req.getParameter("id"));
			dto.setSubject(req.getParameter("subject"));
			dto.setContent(req.getParameter("content"));

			daoQna.updateData(dto);

			String params = "pageNum=" + pageNum;

			if (!searchValue.equals("")) {
				params += "&searchKey=" + searchKey;
				params += "&searchValue=" 
						+ URLEncoder.encode(searchValue, "UTF-8");
			}

			url = cp + "/goobnemall/qna/list.do?" + params;
			resp.sendRedirect(url);	

		} else if (uri.indexOf("qna/deleted_ok.do") != -1) {

			int qnaNum = Integer.parseInt(req.getParameter("qnaNum"));
			String pageNum = req.getParameter("pageNum");

			String searchKey = req.getParameter("searchKey");
			String searchValue = req.getParameter("searchValue");

			if (searchValue != null) {
				searchValue = URLDecoder.decode(searchValue, "UTF-8");
			}

			daoQna.deleteData(qnaNum);

			String params = "pageNum=" + pageNum;

			if (searchValue != null) {

				params += "&searchKey=" + searchKey;
				params += "&searchValue=" 
						+ URLEncoder.encode(searchValue, "UTF-8");
			}

			url = cp + "/goobnemall/qna/list.do?" + params;
			resp.sendRedirect(url);		
			
		}else if(uri.indexOf("order/cart_ok.do")!=-1) {

			String productNum=req.getParameter("productNum");

			int qty=Integer.parseInt(req.getParameter("qty"));
			dtoProduct = daoProduct.getReadData(productNum);
			HttpSession session = req.getSession();
			CustomInfo info = (CustomInfo)session.getAttribute("customInfo");
			String id = info.getUserId();
			int maxNum = daoCart.getMaxNum();
			daoCart.insertData(maxNum+1,id, dtoProduct.getProductName(),qty,dtoProduct.getPrice()*qty,dtoProduct.getPic1());
			req.setAttribute("dto", dtoProduct);
			url = "/goobne/product/listdetail.jsp";//이 list는 이제 실제 판매 페이지를 보여줌
			forward(req, resp, url);

		}else if(uri.indexOf("order/cart.do")!=-1) {

			HttpSession session = req.getSession();
			CustomInfo info = (CustomInfo)session.getAttribute("customInfo");
			String id = info.getUserId();
			List<CartDTO> lists = daoCart.getList(id);
			int totPrice=0;
			for (int i = 0; i < lists.size(); i++) {
				totPrice+=lists.get(i).getPrice();
			}
			req.setAttribute("totPrice", totPrice);
			req.setAttribute("id", id);
			req.setAttribute("lists",lists);
			url="/goobne/order/cart.jsp";
			forward(req, resp, url);
		}else if(uri.indexOf("order/delete.do")!=-1) {

			daoCart.deleteData(Integer.parseInt(req.getParameter("num")));
			url = cp+ "/goobnemall/order/cart.do";
			resp.sendRedirect(url);
		}else if(uri.indexOf("order/cart_update.do")!=-1) {
			int num = Integer.parseInt(req.getParameter("num"));
			int qty = Integer.parseInt(req.getParameter("qty"));
			if(qty==0)
				qty=1;

			CartDTO dto = daoCart.getReadData(num);
			dto.setNum(num);
			dto.setPrice(qty*(dto.getPrice()/dto.getQty()));
			dto.setQty(qty);
			daoCart.updateData(dto);

			url="/goobnemall/order/cart.do";
			forward(req, resp, url);

		} else if(uri.indexOf("product/search.do")!=-1) {

			String searchValue = req.getParameter("searchValue");

			List<ProductDTO> lists = daoProduct.getSearchData(searchValue);

			String param = "";
			if (!searchValue.equals("")) {
				param = "searchValue=" + URLEncoder.encode(searchValue, "UTF-8");
			}

			req.setAttribute("lists", lists);

			url="/goobne/product/list.jsp";
			forward(req, resp, url);
		}else if(uri.indexOf("orderCompleteCart")!=-1) {
			String productNum=req.getParameter("productNum");

			dtoProduct = daoProduct.getReadData(productNum);
			HttpSession session = req.getSession();
			CustomInfo info = (CustomInfo)session.getAttribute("customInfo");
			String id = info.getUserId();

			//--------------------------------------------------

			List<CartDTO> listsCartDTO=daoCart.getList(id);
			List<CartDTO> listsCartDTO2=daoCart.getList(id);
			List<String> listsProductName=new ArrayList<String>();
			List<Integer> listsProductQty=new ArrayList<Integer>();
			List<ProductDTO> listsProductDTO=new ArrayList<ProductDTO>();

			Iterator<CartDTO> it1=listsCartDTO.iterator();
			while(it1.hasNext()) {
				listsProductName.add(it1.next().getProductName());
			}

			Iterator<CartDTO> it4=listsCartDTO2.iterator();
			while(it4.hasNext()) {
				listsProductQty.add(it4.next().getQty());
			}

			Iterator<String> it2=listsProductName.iterator();
			while(it2.hasNext()) {
				listsProductDTO.add(daoProduct.getDataByProductName(it2.next()));
			}

			Iterator<ProductDTO> it3=listsProductDTO.iterator();
			Iterator<Integer> it5=listsProductQty.iterator();

			//-------------------------------------------------
			int[] qtyArray=new int[listsProductQty.size()];
			Iterator<CartDTO> it6=listsCartDTO2.iterator();
			/*
			 * for(int i=0;i<listsProductQty.size();i++) { qtyArray[i]=it6.next().getQty();
			 * }
			 */
			//--------------------------------------------------

			List<OrderInfoDTO> listsOrderInfoDTO=new ArrayList<OrderInfoDTO>();
			String deliveryFee=req.getParameter("deliveryFee");

			for(int i=0;i<listsCartDTO.size();i++) {

				dtoOrderInfo=new OrderInfoDTO();
				int maxNum=daoOrderInfo.getMaxNum();
				dtoProduct=daoProduct.getReadData(req.getParameter("productNum"));
				dtoOrderInfo.setOrderNum(maxNum+1);
				dtoOrderInfo.setBuyerName(req.getParameter("buyerName"));
				dtoOrderInfo.setId(id);
				dtoOrderInfo.setProductNum(it3.next().getProductNum());
				dtoOrderInfo.setQty(it5.next());
				String buyerTel1=req.getParameter("buyerTel1");
				String buyerTel2=req.getParameter("buyerTel2");
				String buyerTel3=req.getParameter("buyerTel3");
				String buyerTel=buyerTel1+"-"+buyerTel2+"-"+buyerTel3;
				dtoOrderInfo.setBuyerTel(buyerTel);
				String buyerEmail1=req.getParameter("buyerEmail1");
				String buyerEmail2=req.getParameter("buyerEmail2");
				String buyerEmail=buyerEmail1+"@"+buyerEmail2;
				dtoOrderInfo.setBuyerEmail(buyerEmail);
				dtoOrderInfo.setGetterName(req.getParameter("getterName"));
				String getterTel1a=req.getParameter("getterTel1");
				String getterTel1b=req.getParameter("getterTel2");
				String getterTel1c=req.getParameter("getterTel3");
				String getterTel1=getterTel1a+"-"+getterTel1b+"-"+getterTel1c;
				dtoOrderInfo.setGetterTel1(getterTel1);
				String getterTel2a=req.getParameter("getterTel4");
				String getterTel2b=req.getParameter("getterTel5");
				String getterTel2c=req.getParameter("getterTel6");
				String getterTel2=getterTel2a+"-"+getterTel2b+"-"+getterTel2c;
				if(getterTel2.equals("--")) {
					getterTel2="";
				}
				dtoOrderInfo.setGetterTel2(getterTel2);
				dtoOrderInfo.setGetterZip(req.getParameter("getterZip"));
				String getterAddr1=req.getParameter("getterAddr1");
				String getterAddr2=req.getParameter("getterAddr2");
				String getterAddr3=req.getParameter("getterAddr3");
				String getterAddr=getterAddr1+" "+getterAddr2+" "+getterAddr3;
				dtoOrderInfo.setGetterAddr(getterAddr);
				dtoOrderInfo.setGetterMsg(req.getParameter("getterMsg"));
				dtoOrderInfo.setPayWay(req.getParameter("payWay"));
				dtoOrderInfo.setPayerName(req.getParameter("payerName"));
				dtoOrderInfo.setBankName(req.getParameter("bankName"));
				dtoOrderInfo.setTotalCost(Integer.parseInt(req.getParameter("totalCost")));
				dtoOrderInfo.setOrderState("배송전");

				daoOrderInfo.insertData(dtoOrderInfo);

				listsOrderInfoDTO.add(dtoOrderInfo);
			}

			daoCart.deleteDataById(id);

			/*
			 * it6.next().getQty();
			 */
			req.setAttribute("payerName", req.getParameter("payerName"));
			req.setAttribute("bankName", req.getParameter("bankName"));
			req.setAttribute("totalCost", Integer.parseInt(req.getParameter("totalCost")));
			req.setAttribute("listsProductDTO", listsProductDTO);
			req.setAttribute("listsOrderInfoDTO", listsOrderInfoDTO);
			req.setAttribute("listsProductQty", listsProductQty);
			req.setAttribute("deliveryFee", deliveryFee);
			req.setAttribute("qtyArray", qtyArray);
			req.setAttribute("it6", it6);

			url = "/goobne/order/orderCompleteCart.jsp";
			forward(req, resp, url);
			
		} else if (uri.indexOf("user/withdrawal.do")!= -1) {

			url = "/goobne/user/withdrawal.jsp";
			forward(req, resp, url);

		} 







	}

}



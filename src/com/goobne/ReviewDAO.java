package com.goobne;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ReviewDAO {

	Connection conn=null;

	public ReviewDAO(Connection conn) {
		super();
		this.conn = conn;
	}
	
	public int getTotalData(String productName) {
		
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql;
		int totalData=0;
		
		try {
			sql="select nvl(count(*),0) from review where productName =?";
			
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1,productName);

			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				totalData=rs.getInt(1);
			}
			
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return totalData;
	}
	
	public int getMaxNum() {
		
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql;
		int maxNum=0;
		
		try {
			sql="select nvl(max(reviewNum),0) from review";
			
			pstmt=conn.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				maxNum=rs.getInt(1);
			}
			
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return maxNum;		
	}

	public int insertData(ReviewDTO dto) {

		PreparedStatement pstmt=null;
		String sql;
		int result=0;

		try {
			sql="insert into review(reviewNum,id,orderNum,productName,score,subject,content,created) values(?,?,?,?,?,?,?,sysdate)";

			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1,dto.getReviewNum());
			pstmt.setString(2,dto.getId());
			pstmt.setInt(3,dto.getOrderNum());
			pstmt.setString(4,dto.getProductName());;
			pstmt.setInt(5, dto.getScore());
			pstmt.setString(6,dto.getSubject());
			pstmt.setString(7,dto.getContent());
			
			result=pstmt.executeUpdate();

			pstmt.close();
		} catch (Exception e) {
			System.out.println("Review insertData");
			System.out.println(e.toString());
		}

		return result;
	}

	public int updateData(ReviewDTO dto) {

		PreparedStatement pstmt=null;
		String sql;
		int result=0;

		try {
			sql="update review set subject=?,content=?,created=sysdate where reviewNum=?";

			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1,dto.getSubject());
			pstmt.setString(2,dto.getContent());
			pstmt.setInt(3,dto.getReviewNum());
			
			result=pstmt.executeUpdate();

			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return result;
	}

	public int deleteData(int reviewNum) {

		PreparedStatement pstmt=null;
		String sql;
		int result=0;

		try {
			sql="delete from review where reviewNum=?";

			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, reviewNum);
			
			result=pstmt.executeUpdate();

			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return result;
	}
	
	public ReviewDTO getReadData(int reviewNum) {
		
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		ReviewDTO dto=null;
		String sql;

		try {
			sql="select reviewNum,id,orderNum,productName,score,subject,content,created from review where reviewNum=?";

			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, reviewNum);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				dto=new ReviewDTO();
				
				dto.setReviewNum(rs.getInt("reviewNum"));
				dto.setId(rs.getString("id"));
				dto.setOrderNum(rs.getInt("orderNum"));
				dto.setScore(rs.getInt("score"));
				dto.setProductName(rs.getString("productName"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setCreated(rs.getString("created"));
			}
			
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			System.out.println("Review getReadData");
			System.out.println(e.toString());
		}

		return dto;
	}
	
	public int getAvgScore(String productName) {
		
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		ReviewDTO dto=null;
		String sql;
		int result=0;

		try {
			sql="select avg(score) from review where productName= ?";

			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, productName);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				result=(int)Math.round(rs.getDouble(1));
			}
			
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			System.out.println("Review getAvgScore");
			System.out.println(e.toString());
		}

		return result;
	}
	
	
	public List<ReviewDTO> getList(int start, int end, String productName) {
		
		List<ReviewDTO> lists=new ArrayList<ReviewDTO>();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		ReviewDTO dto=null;
		String sql;

		try {
			sql = "select * from (";
			sql += "select rownum rnum,data.* from(";
			sql += "select reviewNum,id,orderNum,productName,subject,content,score, ";
			sql += "to_char(created,'YYYY-MM-DD') created from review ";
			sql += "order by reviewNum desc) data) ";
			sql += "where rnum>=? and rnum<=? and productName = ? ";
			
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			pstmt.setString(3, productName);

			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				dto=new ReviewDTO();
				
				dto.setReviewNum(rs.getInt("reviewNum"));
				dto.setId(rs.getString("id"));
				dto.setOrderNum(rs.getInt("orderNum"));
				dto.setProductName(rs.getString("productName"));
				dto.setScore(rs.getInt("score"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setCreated(rs.getString("created"));
				lists.add(dto);
			}
			
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			System.out.println("Review getList");
			System.out.println(e.toString());
		}

		return lists;
	}
}

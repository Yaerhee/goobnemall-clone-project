package com.goobne;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class QnaDAO {

	Connection conn=null;

	public QnaDAO(Connection conn) {
		super();
		this.conn = conn;
	}
	
	public int getMaxNum() {
		
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql;
		int maxNum=0;
		
		try {
			sql="select nvl(max(qnaNum),0) from qna";
			
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

	public int insertData(QnaDTO dto) {

		PreparedStatement pstmt=null;
		String sql;
		int result=0;

		try {
			sql="insert into qna(qnaNum,id,subject,content,created) values(?,?,?,?,sysdate)";

			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1,dto.getQnaNum());
			pstmt.setString(2,dto.getId());
			pstmt.setString(3,dto.getSubject());
			pstmt.setString(4, dto.getContent());

			result=pstmt.executeUpdate();

			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return result;
	}

	public int updateData(QnaDTO dto) {

		PreparedStatement pstmt=null;
		String sql;
		int result=0;

		try {
			sql="update qna set subject=?,content=?,created=sysdate where qnaNum=?";

			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1,dto.getSubject());
			pstmt.setString(2,dto.getContent());
			pstmt.setInt(3,dto.getQnaNum());
			
			result=pstmt.executeUpdate();

			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return result;
	}

	public int deleteData(int qnaNum) {

		PreparedStatement pstmt=null;
		String sql;
		int result=0;

		try {
			sql="delete from qna where qnaNum=?";

			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, qnaNum);
			
			result=pstmt.executeUpdate();

			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return result;
	}
	
	public QnaDTO getReadData(int qnaNum) {
		
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		QnaDTO dto=null;
		String sql;

		try {
			sql="select qnaNum,id,subject,content,created from qna where qnaNum=?";

			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, qnaNum);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				dto=new QnaDTO();
				
				dto.setQnaNum(rs.getInt("qnaNum"));
				dto.setId(rs.getString("id"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setCreated(rs.getString("created"));
			}
			
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return dto;
	}
	
	public List<QnaDTO> getList(int start, int end, 
			String searchKey, String searchValue) {
		
		List<QnaDTO> lists=new ArrayList<QnaDTO>();
		
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		String sql;
		
		try {
			
			searchValue = "%" + searchValue + "%";
			
			sql = "select * from (";
			sql += "select rownum rnum, data.* from (";
			sql += "select qnaNum, id, subject, content, ";
			sql += "to_char(created, 'YYYY-MM-DD') created from qna ";
			sql += "where " + searchKey + " like ? order by qnaNum desc) data) ";
			sql += "where rnum >= ? and rnum <= ?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, searchValue);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				
				QnaDTO dto = new QnaDTO();
				
				dto.setQnaNum(rs.getInt("qnaNum"));
				dto.setId(rs.getString("id"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setCreated(rs.getString("created"));
				
				lists.add(dto);		
				
			}
			
			rs.close();
			pstmt.close();			
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return lists;
		
	}
	
	public int getDataCount(String searchKey, String searchValue) {
		
		int totalData = 0;		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			
			searchValue = "%" + searchValue + "%";
					
			sql = "select nvl(count(*), 0) from qna ";
			sql += "where " + searchKey + " like ?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, searchValue);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) 
				totalData = rs.getInt(1);
			
			rs.close();
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return totalData;		
		
	}
	
	
	
	
	
}

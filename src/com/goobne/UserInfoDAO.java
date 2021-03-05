package com.goobne;

import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserInfoDAO {

	Connection conn=null;

	public UserInfoDAO(Connection conn) {
		super();
		this.conn = conn;
	}

	public int insertData(UserInfoDTO dto) {

		PreparedStatement pstmt=null;
		String sql;
		int result=0;

		try {
			sql="insert into userInfo(id,pwd,name,email,gender,tel,birth,addr,created) values(?,?,?,?,?,?,?,?,sysdate)";

			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1,dto.getId());
			pstmt.setString(2,dto.getPwd());
			pstmt.setString(3,dto.getName());
			pstmt.setString(4,dto.getEmail());
			pstmt.setString(5,dto.getGender());
			pstmt.setString(6,dto.getTel());
			pstmt.setString(7,dto.getBirth());
			pstmt.setString(8,dto.getAddr());
			
			result=pstmt.executeUpdate();

			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return result;
	}

	public int updateData(UserInfoDTO dto) {

		PreparedStatement pstmt=null;
		String sql;
		int result=0;

		try {
			sql="update userInfo set pwd=?,name=?,email=?,gender=?,tel=?,addr=? where id=?";

			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1,dto.getPwd());
			pstmt.setString(2,dto.getName());
			pstmt.setString(3,dto.getEmail());
			pstmt.setString(4,dto.getGender());
			pstmt.setString(5,dto.getTel());
			pstmt.setString(6,dto.getAddr());
			pstmt.setString(7,dto.getId());

			result=pstmt.executeUpdate();

			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return result;
	}

	public int deleteData(String id) {

		PreparedStatement pstmt=null;
		String sql;
		int result=0;

		try {
			sql="delete from userInfo where id=?";

			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			
			result=pstmt.executeUpdate();

			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return result;
	}
	
	public UserInfoDTO getReadData(String id) {
		
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		UserInfoDTO dto=null;
		String sql;

		try {
			sql="select id,pwd,name,email,gender,tel,birth,addr,created from userInfo where id=?";

			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				dto=new UserInfoDTO();
				
				dto.setId(rs.getString("id"));
				dto.setPwd(rs.getString("pwd"));
				dto.setName(rs.getString("name"));
				dto.setEmail(rs.getString("email"));
				dto.setGender(rs.getString("gender"));
				dto.setTel(rs.getString("tel"));
				dto.setBirth(rs.getString("birth"));
				dto.setAddr(rs.getString("addr"));
				dto.setCreated(rs.getString("created"));
			}
			
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return dto;
	}
	public boolean idChk(String id) {

		PreparedStatement pstmt=null;
		ResultSet rs = null;
		String sql;
		int result=0;
		boolean chk =false;

		try {
			sql="select count(*) cnt from userInfo where id=?";

			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs=pstmt.executeQuery();
			if(rs.next()) {
			
				result=rs.getInt("cnt");
			}
			if(result==0)
				chk=true;

			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return chk;
	}
}

package com.goobne;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.board.BoardDTO;



public class CartDAO {
	
	private Connection conn;
	
	public CartDAO(Connection conn) {//의존성 주입
		this.conn = conn;
	}
	public int insertData(int num, String id,String productName, int qty, int price, String pic1) {

		PreparedStatement pstmt=null;
		String sql;
		int result=0;

		try {
			sql="insert into cart(num, id,productName,qty,price,pic1) values(?,?,?,?,?,?)";

			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1,num);
			pstmt.setString(2,id);
			pstmt.setString(3,productName);
			pstmt.setInt(4,qty);
			pstmt.setInt(5,price);
			pstmt.setString(6,pic1);
			
			result=pstmt.executeUpdate();

			pstmt.close();
		} catch (Exception e) {
			System.out.println("Cart insertData");
			System.out.println(e.toString());
		}

		return result;
	}
	public List<CartDTO> getList(String id) {
		
		List<CartDTO> lists=new ArrayList<CartDTO>();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		CartDTO dto=null;
		String sql;

		try {
			sql = "select * from cart where id=?";
			
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setString(1, id);

			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				dto=new CartDTO();
				dto.setNum(rs.getInt("num"));
				dto.setId(rs.getString("id"));
				dto.setProductName(rs.getString("productName"));
				dto.setQty(rs.getInt("qty"));
				dto.setPrice(rs.getInt("price"));
				dto.setPic1(rs.getString("pic1"));
				lists.add(dto);
			}
			
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			System.out.println("Cart getList");
			System.out.println(e.toString());
		}

		return lists;
	}
	public int getMaxNum() {
		
		int maxNum = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "select nvl(max(num),0) from cart";
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				maxNum = rs.getInt(1);
			}
			rs.close();
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println("CartDAO_겟넘");
			System.out.println(e.toString());
		}
		
		return maxNum;
	}
	public int deleteData(int num) {
		
		int result =0;
		
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "delete cart where num=?";
			
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			result = pstmt.executeUpdate();
			
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println("CartDAO_딜리트데이터");
			System.out.println(e.toString());
		}
		
		return result;
		
		
	}
	
public int deleteDataById(String id) {
		
		int result =0;
		
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "delete cart where id=?";
			
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			result = pstmt.executeUpdate();
			
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println("CartDAO_딜리트데이터");
			System.out.println(e.toString());
		}
		
		return result;
		
		
	}
	public int updateData(CartDTO dto) {
		
		int result =0;
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "update cart set qty=?,price=? where num=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, dto.getQty());
			pstmt.setInt(2, dto.getPrice());
			pstmt.setInt(3, dto.getNum());
			
			result = pstmt.executeUpdate();
			pstmt.close();
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return result;
		
		
	}
	public CartDTO getReadData(int num) {
		
		CartDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql;
		
		try {
			sql = "select * from cart where num=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				dto = new CartDTO();
				dto.setNum(rs.getInt("num"));
				dto.setId(rs.getString("id"));
				dto.setProductName(rs.getString("productName"));
				dto.setQty(rs.getInt("qty"));
				dto.setPrice(rs.getInt("price"));
				dto.setPic1(rs.getString("pic1"));
			}
			rs.close();
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return dto;
		
	}
}
	
	

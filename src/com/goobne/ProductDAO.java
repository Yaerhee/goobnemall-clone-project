package com.goobne;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;



public class ProductDAO {
	
	private Connection conn;
	
	public ProductDAO(Connection conn) {//의존성 주입
		this.conn = conn;
	}
	public List<ProductDTO> getLists(){
		
		List<ProductDTO> lists = new ArrayList<ProductDTO>();
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		try {
			sql = "select * from product";
			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ProductDTO dto = new ProductDTO();
				
				dto.setProductNum(rs.getString("productNum"));
				dto.setCategory1(rs.getString("category1"));
				dto.setCategory2(rs.getString("category2"));
				dto.setCategory3(rs.getString("category3"));
				dto.setProductName(rs.getString("productName"));
				dto.setPrice(rs.getInt("price"));
				dto.setAmount(rs.getInt("amount"));
				dto.setQty(rs.getInt("qty"));
				dto.setPic1(rs.getString("pic1"));
				dto.setPic2(rs.getString("pic2"));
				dto.setPic3(rs.getString("pic3"));
				dto.setPic4(rs.getString("pic4"));	
				lists.add(dto);
			}
			
			rs.close();
			pstmt.close();
			
		} catch (Exception e) {
			
			System.out.println("ProductDAO.getLists");
			System.out.println(e.toString());
		}
		
		return lists;
	}
	public List<ProductDTO> getListsCat1(String category1){
		
		List<ProductDTO> lists = new ArrayList<ProductDTO>();
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		try {
			sql = "select * from product where category1 =?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, category1);

			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ProductDTO dto = new ProductDTO();
				
				dto.setProductNum(rs.getString("productNum"));
				dto.setCategory1(rs.getString("category1"));
				dto.setCategory2(rs.getString("category2"));
				dto.setCategory3(rs.getString("category3"));
				dto.setProductName(rs.getString("productName"));
				dto.setPrice(rs.getInt("price"));
				dto.setAmount(rs.getInt("amount"));
				dto.setQty(rs.getInt("qty"));
				dto.setPic1(rs.getString("pic1"));
				dto.setPic2(rs.getString("pic2"));
				dto.setPic3(rs.getString("pic3"));
				dto.setPic4(rs.getString("pic4"));	
				lists.add(dto);
			}
			
			rs.close();
			pstmt.close();
			
		} catch (Exception e) {
			
			System.out.println("ProductDAO.getLists");
			System.out.println(e.toString());
		}
		
		return lists;
	}
	public List<ProductDTO> getListsCat2(String category2){
		
		List<ProductDTO> lists = new ArrayList<ProductDTO>();
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		try {
			sql = "select * from product where category2 =?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, category2);
			
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ProductDTO dto = new ProductDTO();
				
				dto.setProductNum(rs.getString("productNum"));
				dto.setCategory1(rs.getString("category1"));
				dto.setCategory2(rs.getString("category2"));
				dto.setCategory3(rs.getString("category3"));
				dto.setProductName(rs.getString("productName"));
				dto.setPrice(rs.getInt("price"));
				dto.setAmount(rs.getInt("amount"));
				dto.setQty(rs.getInt("qty"));
				dto.setPic1(rs.getString("pic1"));
				dto.setPic2(rs.getString("pic2"));
				dto.setPic3(rs.getString("pic3"));
				dto.setPic4(rs.getString("pic4"));	
				lists.add(dto);
			}
			
			rs.close();
			pstmt.close();
			
		} catch (Exception e) {
			
			System.out.println("ProductDAO.getLists");
			System.out.println(e.toString());
		}
		
		return lists;
	}
	
	public ProductDTO getReadData(String productNum) {
		ProductDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "select * from product where productNum=?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, productNum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto = new ProductDTO();
				dto.setProductNum(rs.getString("productNum"));
				dto.setCategory1(rs.getString("category1"));
				dto.setCategory2(rs.getString("category2"));
				dto.setCategory3(rs.getString("category3"));
				dto.setProductName(rs.getString("productName"));
				dto.setPrice(rs.getInt("price"));
				dto.setAmount(rs.getInt("amount"));
				dto.setQty(rs.getInt("qty"));
				dto.setPic1(rs.getString("pic1"));
				dto.setPic2(rs.getString("pic2"));
				dto.setPic3(rs.getString("pic3"));
				dto.setPic4(rs.getString("pic4"));	
			}
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			System.out.println("ProductDAO.getReadData");
			System.out.println(e.toString());
		}
		return dto;
	}
	public List<ProductDTO> getListsRandom(){
		
		List<ProductDTO> lists = new ArrayList<ProductDTO>();
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "select * from (";
			sql+= "select * from product";
			sql+= " order by DBMS_RANDOM.RANDOM";
			sql+= ") where rownum < 20";
		
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				ProductDTO dto = new ProductDTO();
				dto.setProductNum(rs.getString("productNum"));
				dto.setCategory1(rs.getString("category1"));
				dto.setCategory2(rs.getString("category2"));
				dto.setCategory3(rs.getString("category3"));
				dto.setProductName(rs.getString("productName"));
				dto.setPrice(rs.getInt("price"));
				dto.setAmount(rs.getInt("amount"));
				dto.setQty(rs.getInt("qty"));
				dto.setPic1(rs.getString("pic1"));
				dto.setPic2(rs.getString("pic2"));
				dto.setPic3(rs.getString("pic3"));
				dto.setPic4(rs.getString("pic4"));
				
				lists.add(dto);
			}
			
			rs.close();
			pstmt.close();
			
		} catch (Exception e) {
			
			System.out.println("ProductDAO.getLists");
			System.out.println(e.toString());
		}
		return lists;
	}
	
	public ProductDTO getData(String productName) {
		ProductDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "select * from product where productName=?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, productName);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto = new ProductDTO();
				dto.setProductNum(rs.getString("productNum"));
				dto.setCategory1(rs.getString("category1"));
				dto.setCategory2(rs.getString("category2"));
				dto.setCategory3(rs.getString("category3"));
				dto.setProductName(rs.getString("productName"));
				dto.setPrice(rs.getInt("price"));
				dto.setAmount(rs.getInt("amount"));
				dto.setQty(rs.getInt("qty"));
				dto.setPic1(rs.getString("pic1"));
				dto.setPic2(rs.getString("pic2"));
				dto.setPic3(rs.getString("pic3"));
				dto.setPic4(rs.getString("pic4"));	
			}
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			System.out.println("ProductDAO.getReadData");
			System.out.println(e.toString());
		}
		return dto;
	}
	
	public List<ProductDTO> getSearchData(String searchValue) {
		
		List<ProductDTO> lists = new ArrayList<ProductDTO>();
		
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql;
		ProductDTO dto = null;
		
		try {
			
			sql = "select * from product where productName LIKE ?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, "%" + searchValue + "%");
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				
				dto = new ProductDTO();
				
				dto.setProductNum(rs.getString("productNum"));
				dto.setCategory1(rs.getString("category1"));
				dto.setCategory2(rs.getString("category2"));
				dto.setCategory3(rs.getString("category3"));
				dto.setProductName(rs.getString("productName"));
				dto.setPrice(rs.getInt("price"));
				dto.setAmount(rs.getInt("amount"));
				dto.setQty(rs.getInt("qty"));
				dto.setPic1(rs.getString("pic1"));
				dto.setPic2(rs.getString("pic2"));
				dto.setPic3(rs.getString("pic3"));
				
				lists.add(dto);
				
			}
			
			rs.close();
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return lists;
		
		
	}
	
	
	
public ProductDTO getDataByProductName(String productName) {
		
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql;
		ProductDTO dto = null;
		
		try {
			
			sql = "select * from product where productName LIKE ?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, "%" + productName + "%");
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				
				dto = new ProductDTO();
				
				dto.setProductNum(rs.getString("productNum"));
				dto.setCategory1(rs.getString("category1"));
				dto.setCategory2(rs.getString("category2"));
				dto.setCategory3(rs.getString("category3"));
				dto.setProductName(rs.getString("productName"));
				dto.setPrice(rs.getInt("price"));
				dto.setAmount(rs.getInt("amount"));
				dto.setQty(rs.getInt("qty"));
				dto.setPic1(rs.getString("pic1"));
				dto.setPic2(rs.getString("pic2"));
				dto.setPic3(rs.getString("pic3"));
			}
			
			rs.close();
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return dto;
		
		
	}
}

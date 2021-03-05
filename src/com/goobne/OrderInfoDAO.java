package com.goobne;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class OrderInfoDAO {

	Connection conn=null;

	public OrderInfoDAO(Connection conn) {
		super();
		this.conn = conn;
	}
	
	public int getMaxNum() {
		
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql;
		int maxNum=0;
		
		try {
			sql="select nvl(max(orderNum),0) from orderInfo";
			
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
	

	public int insertData(OrderInfoDTO dto) {

		PreparedStatement pstmt=null;
		String sql;
		int result=0;

		try {
			sql="insert into orderInfo(orderNum,id,productNum,qty,buyerName,buyerTel,buyerEmail,getterName,getterTel1,getterTel2,";
			sql+="getterZip,getterAddr,getterMsg,payWay,payerName,bankName,totalCost,orderDate,orderState) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,sysdate,?)";

			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getOrderNum());
			pstmt.setString(2, dto.getId());
			pstmt.setString(3, dto.getProductNum());
			pstmt.setInt(4, dto.getQty());
			pstmt.setString(5, dto.getBuyerName());
			pstmt.setString(6, dto.getBuyerTel());
			pstmt.setString(7, dto.getBuyerEmail());
			pstmt.setString(8, dto.getGetterName());
			pstmt.setString(9, dto.getGetterTel1());
			pstmt.setString(10, dto.getGetterTel2());
			pstmt.setString(11, dto.getGetterZip());
			pstmt.setString(12, dto.getGetterAddr());
			pstmt.setString(13, dto.getGetterMsg());
			pstmt.setString(14, dto.getPayWay());
			pstmt.setString(15, dto.getPayerName());
			pstmt.setString(16, dto.getBankName());
			pstmt.setInt(17, dto.getTotalCost());
			pstmt.setString(18, dto.getOrderState());
			
			result=pstmt.executeUpdate();

			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return result;
	}

	public int updateData(OrderInfoDTO dto) {

		PreparedStatement pstmt=null;
		String sql;
		int result=0;

		try {
			sql="update orderInfo set getterName=?,getterAddr=?,getterTel1=?,getterTel2=? where orderNum=?";

			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1,dto.getGetterName());
			pstmt.setString(2,dto.getGetterAddr());
			pstmt.setString(3,dto.getGetterTel1());
			pstmt.setString(4,dto.getGetterTel2());
			pstmt.setInt(5, dto.getOrderNum());
			
			result=pstmt.executeUpdate();

			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return result;
	}
	
	public int updateOrderState(int orderNum,String orderState) {

		PreparedStatement pstmt=null;
		String sql;
		int result=0;

		try {
			sql="update orderInfo set orderState=? where orderNum=?";

			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1,orderState);
			pstmt.setInt(2, orderNum);
			
			result=pstmt.executeUpdate();

			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return result;
	}

	public int deleteData(int orderNum) {

		PreparedStatement pstmt=null;
		String sql;
		int result=0;

		try {
			sql="delete from orderInfo where orderNum=?";

			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, orderNum);
			
			result=pstmt.executeUpdate();

			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return result;
	}
	
	public OrderInfoDTO getReadData(int orderNum) {
		
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		OrderInfoDTO dto=null;
		String sql;

		try {			
			sql="select orderNum,id,productNum,qty,buyerName,buyerTel,buyerEmail,getterName,getterTel1,getterTel2,";
			sql+="getterZip,getterAddr,getterMsg,payWay,payerName,bankName,totalCost,orderDate,orderState from orderInfo where orderNum=?";

			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, orderNum);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				dto=new OrderInfoDTO();
				
				dto.setOrderNum(rs.getInt("orderNum"));
				dto.setId(rs.getString("id"));
				dto.setProductNum(rs.getString("productNum"));
				dto.setQty(rs.getInt("qty"));
				dto.setBuyerName(rs.getString("buyerName"));
				dto.setBuyerTel(rs.getString("buyerTel"));
				dto.setBuyerEmail(rs.getString("buyerEmail"));
				dto.setGetterName(rs.getString("getterName"));
				dto.setGetterTel1(rs.getString("getterTel1"));
				dto.setGetterTel2(rs.getString("getterTel2"));
				dto.setGetterZip(rs.getString("getterZip"));
				dto.setGetterAddr(rs.getString("getterAddr"));
				dto.setGetterMsg(rs.getString("getterMsg"));
				dto.setPayWay(rs.getString("payWay"));
				dto.setPayerName(rs.getString("payerName"));
				dto.setBankName(rs.getString("bankName"));
				dto.setTotalCost(rs.getInt("totalCost"));
				dto.setOrderDate(rs.getString("orderDate"));
				dto.setOrderState(rs.getString("orderState"));
			}
			
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return dto;
	}
	
	public List<OrderInfoDTO> getList(String id) {
		
		List<OrderInfoDTO> lists=new ArrayList<OrderInfoDTO>();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		OrderInfoDTO dto=null;
		String sql;

		try {		
			sql="select orderNum,id,productNum,qty,buyerName,buyerTel,buyerEmail,getterName,getterTel1,getterTel2,";
			sql+="getterZip,getterAddr,getterMsg,payWay,payerName,bankName,totalCost,orderDate,orderState from orderInfo where id=?";

			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				dto=new OrderInfoDTO();
				
				dto.setOrderNum(rs.getInt("orderNum"));
				dto.setId(rs.getString("id"));
				dto.setProductNum(rs.getString("productNum"));
				dto.setQty(rs.getInt("qty"));
				dto.setBuyerName(rs.getString("buyerName"));
				dto.setBuyerTel(rs.getString("buyerTel"));
				dto.setBuyerEmail(rs.getString("buyerEmail"));
				dto.setGetterName(rs.getString("getterName"));
				dto.setGetterTel1(rs.getString("getterTel1"));
				dto.setGetterTel2(rs.getString("getterTel2"));
				dto.setGetterZip(rs.getString("getterZip"));
				dto.setGetterAddr(rs.getString("getterAddr"));
				dto.setGetterMsg(rs.getString("getterMsg"));
				dto.setPayWay(rs.getString("payWay"));
				dto.setPayerName(rs.getString("payerName"));
				dto.setBankName(rs.getString("bankName"));
				dto.setTotalCost(rs.getInt("totalCost"));
				dto.setOrderDate(rs.getString("orderDate"));
				dto.setOrderState(rs.getString("orderState"));
				
				lists.add(dto);
			}
			
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return lists;
	}
}

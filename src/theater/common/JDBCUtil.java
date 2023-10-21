package theater.common;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class JDBCUtil {

	public static Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource)envCtx.lookup("jdbc/db03");// Context.xml에서 이름이 jdbc/db03인 항목을 찾아오기
		return ds.getConnection();
	}
	
	
	// DB 변수 해제 - conn, pstmt, rs
	public static void close(Connection conn, PreparedStatement pstmt, ResultSet rs) {
		if(rs != null) {
			try {
				if(!rs.isClosed()) rs.close();
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				rs = null;
			}
		}
		if(pstmt != null) {
			try {
				if(!pstmt.isClosed()) pstmt.close();
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				pstmt = null;
			}
		}
		if(conn != null) {
			try {
				if(!conn.isClosed()) conn.close();
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				conn = null;
			}
		}
	}
	
	// DB 변수 해제 - conn, pstmt
	public static void close(Connection conn, PreparedStatement pstmt) {
		if(pstmt != null) {
			try {
				if(!pstmt.isClosed()) pstmt.close();
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				pstmt = null;
			}
		}
		if(conn != null) {
			try {
				if(!conn.isClosed()) conn.close();
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				conn = null;
			}
		}
	}

}

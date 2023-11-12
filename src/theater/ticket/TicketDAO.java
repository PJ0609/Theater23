package theater.ticket;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import theater.common.JDBCUtil;


public class TicketDAO {

	private TicketDAO() {};
	
	private static TicketDAO instance = new TicketDAO();
	
	public static TicketDAO getInstance() {
		return instance;
	}
	
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	public final String INSERT_TICKET = "insert into ticket(resv_id, scn_id, mov_id, id, resv_type, theater, scn_time, end_time, seat) values(?,?,?,?,?,?,?,?,?)";
	public final String UPDATE_SCREEN = "update screen set remaining_seats=remaining_seats-?, resv_seat=concat(resv_seat, ', ', ?) where scn_id=?";
	public final String GET_TKTLIST = "select * from ticket where id=? order by scn_time desc";
	
	public int insertTicket(TicketDTO ticket) {
		int chk = -1;
		try {
			conn = JDBCUtil.getConnection();
			// Transaction 처리
			conn.setAutoCommit(false);
			
			pstmt = conn.prepareStatement(INSERT_TICKET);
			pstmt.setString(1, ticket.getResv_id());
			pstmt.setInt(2, ticket.getScn_id());
			pstmt.setInt(3, ticket.getMov_id());
			pstmt.setString(4, ticket.getId());
			pstmt.setString(5, ticket.getResv_type());
			pstmt.setInt(6, ticket.getTheater());
			pstmt.setTimestamp(7, ticket.getScn_time());
			pstmt.setTimestamp(8, ticket.getEnd_time());
			pstmt.setString(9, ticket.getSeat());
			chk = pstmt.executeUpdate();
			
			pstmt = conn.prepareStatement(UPDATE_SCREEN);
			int cnt = ticket.getSeat().split(",").length;
			pstmt.setInt(1, cnt);
			pstmt.setString(2, ticket.getSeat());
			pstmt.setInt(3, ticket.getScn_id());
			pstmt.executeUpdate();
			
			// Transaction 커밋
			conn.commit();
			conn.setAutoCommit(true);
			
		} catch(Exception e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch(SQLException ex) {ex.printStackTrace();}
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return chk;
	}
	
	public List<TicketDTO> getTktList(String id) {
		List<TicketDTO> tickets = new ArrayList<TicketDTO>();
		try {
			conn = JDBCUtil.getConnection();
			
			pstmt = conn.prepareStatement(GET_TKTLIST);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			TicketDTO ticket = null;
			while(rs.next()) {
				ticket = new TicketDTO();
				ticket.setResv_id(rs.getString("resv_id"));
				ticket.setScn_id(rs.getInt("scn_id"));
				ticket.setMov_id(rs.getInt("mov_id"));
				ticket.setId(rs.getString("id"));
				ticket.setResv_type(rs.getString("resv_type"));
				ticket.setTheater(rs.getInt("theater"));
				ticket.setScn_time(rs.getTimestamp("scn_time"));
				ticket.setEnd_time(rs.getTimestamp("end_time"));
				ticket.setSeat(rs.getString("seat"));
				tickets.add(ticket);
			}			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return tickets;
		
	}
}

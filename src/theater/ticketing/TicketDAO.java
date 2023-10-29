package theater.ticketing;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


public class TicketDAO {

	private TicketDAO() {};
	
	private static TicketDAO instance = new TicketDAO();
	
	public static TicketDAO getInstance() {
		return instance;
	}
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
}

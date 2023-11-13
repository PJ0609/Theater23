package theater.review;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import theater.common.JDBCUtil;

public class ReviewDAO {
	private ReviewDAO() {};
	
	private static ReviewDAO instance = new ReviewDAO();
	
	public static ReviewDAO getInstance() {
		return instance;
	}
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private final String INSERT_REVIEW = "insert into review(mov_id, mov_name, id, usr_rating, content, spoiler) values(?,?,?,?,?,?)";
	private final String GET_REVIEW = "select * from review where mov_id=?";
	public int insertReview(ReviewDTO review) {
		int chk = 0;
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(INSERT_REVIEW);
			pstmt.setInt(1, review.getMov_id());
			pstmt.setString(2, review.getMov_name());
			pstmt.setString(3, review.getId());
			pstmt.setInt(4, review.getUsr_rating());
			pstmt.setString(5, review.getContent());
			pstmt.setInt(6, review.getSpoiler());
			chk = pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt);
		}
		return chk;
	}
	public List<ReviewDTO> getRvwList(int mov_id) {
		List<ReviewDTO> reviews = new ArrayList<ReviewDTO>();
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(GET_REVIEW);
			pstmt.setInt(1, mov_id);
			rs = pstmt.executeQuery();
			ReviewDTO review = null;
			while(rs.next()) {
				review = new ReviewDTO();
				review.setReview_id(rs.getInt("review_id"));
				review.setMov_id(rs.getInt("mov_id"));
				review.setMov_name(rs.getString("mov_name"));
				review.setId(rs.getString("id"));
				review.setUsr_rating(rs.getInt("usr_rating"));
				review.setContent(rs.getString("content"));
				review.setPost_time(rs.getTimestamp("post_time"));
				review.setSpoiler(rs.getInt("spoiler"));
				reviews.add(review);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt);
		}
		return reviews;
	}
	
}

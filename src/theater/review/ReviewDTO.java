package theater.review;

import java.sql.Timestamp;

public class ReviewDTO {
	private int review_id;
	private int mov_id;
	private String mov_name;
	private String id;
	private int usr_rating;
	private String content;
	private Timestamp post_time;
	private int recomm;
	private int spoiler;

	public int getReview_id() {
		return review_id;
	}

	public int getMov_id() {
		return mov_id;
	}

	public String getMov_name() {
		return mov_name;
	}

	public String getId() {
		return id;
	}

	public int getUsr_rating() {
		return usr_rating;
	}

	public String getContent() {
		return content;
	}

	public Timestamp getPost_time() {
		return post_time;
	}

	public int getRecomm() {
		return recomm;
	}

	public int getSpoiler() {
		return spoiler;
	}

	public void setReview_id(int review_id) {
		this.review_id = review_id;
	}

	public void setMov_id(int mov_id) {
		this.mov_id = mov_id;
	}

	public void setMov_name(String mov_name) {
		this.mov_name = mov_name;
	}

	public void setId(String id) {
		this.id = id;
	}

	public void setUsr_rating(int usr_rating) {
		this.usr_rating = usr_rating;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public void setPost_time(Timestamp post_time) {
		this.post_time = post_time;
	}

	public void setRecomm(int recomm) {
		this.recomm = recomm;
	}

	public void setSpoiler(int spoiler) {
		this.spoiler = spoiler;
	}

}

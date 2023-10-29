package theater.movie;

import java.sql.Date;

public class MovieDTO {
	private int mov_id;
	private String mov_name;
	private String director;
	private String mov_img;
	private String genre;
	private String rating;
	private String synopsis;
	private int length;
	private Date rel_date;
	private String trailer_link;
	private double avgusr_rating;

	public int getMov_id() {
		return mov_id;
	}

	public String getMov_name() {
		return mov_name;
	}

	public String getDirector() {
		return director;
	}

	public String getMov_img() {
		return mov_img;
	}

	public String getGenre() {
		return genre;
	}

	public String getRating() {
		return rating;
	}

	public String getSynopsis() {
		return synopsis;
	}

	public int getLength() {
		return length;
	}

	public Date getRel_date() {
		return rel_date;
	}

	public String getTrailer_link() {
		return trailer_link;
	}

	public double getAvgusr_rating() {
		return avgusr_rating;
	}

	public void setMov_id(int mov_id) {
		this.mov_id = mov_id;
	}

	public void setMov_name(String mov_name) {
		this.mov_name = mov_name;
	}

	public void setDirector(String director) {
		this.director = director;
	}

	public void setMov_img(String mov_img) {
		this.mov_img = mov_img;
	}

	public void setGenre(String genre) {
		this.genre = genre;
	}

	public void setRating(String rating) {
		this.rating = rating;
	}

	public void setSynopsis(String synopsis) {
		this.synopsis = synopsis;
	}

	public void setLength(int length) {
		this.length = length;
	}

	public void setRel_date(Date rel_date) {
		this.rel_date = rel_date;
	}

	public void setTrailer_link(String trailer_link) {
		this.trailer_link = trailer_link;
	}

	public void setAvgusr_rating(double avgusr_rating) {
		this.avgusr_rating = avgusr_rating;
	}

}

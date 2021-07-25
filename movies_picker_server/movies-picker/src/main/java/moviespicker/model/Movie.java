package moviespicker.model;

import javax.persistence.*;

@Entity
@Table(name = "movies")
public class Movie {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private long id;

	@Column(name = "language", nullable = false)
	@Enumerated(EnumType.STRING)
	private Language language;

	@Column(name = "location", nullable = false)
	@Enumerated(EnumType.STRING)
	private Location location;

	@Column(name = "plot", nullable = false, length=2048)
	private String plot;

	@Column(name = "poster", nullable = false)
	private String poster;

	@Column(name = "soundEffects")
	private String soundEffects;

	@Column(name = "stills", length=2048)
	private String stills;

	@Column(name = "title", nullable = false)
	private String title;

	@Column(name = "imdbID", nullable = false)
	private String imdbID;

	@Column(name = "imdbRating", nullable = false)
	private Double imdbRating;

	@Column(name = "listingType", nullable = false)
	@Enumerated(EnumType.STRING)
	private ListingType listingType;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public Language getLanguage() {
		return language;
	}

	public void setLanguage(Language language) {
		this.language = language;
	}

	public Location getLocation() {
		return location;
	}

	public void setLocation(Location location) {
		this.location = location;
	}

	public String getPlot() {
		return plot;
	}

	public void setPlot(String plot) {
		this.plot = plot;
	}

	public String getPoster() {
		return poster;
	}

	public void setPoster(String poster) {
		this.poster = poster;
	}

	public String getSoundEffects() {
		return soundEffects;
	}

	public void setSoundEffects(String soundEffects) {
		this.soundEffects = soundEffects;
	}

	public String getStills() {
		return stills;
	}

	public void setStills(String stills) {
		this.stills = stills;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getImdbID() {
		return imdbID;
	}

	public void setImdbID(String imdbID) {
		this.imdbID = imdbID;
	}

	public Double getImdbRating() {
		return imdbRating;
	}

	public void setImdbRating(Double imdbRating) {
		this.imdbRating = imdbRating;
	}

	public ListingType getListingType() {
		return listingType;
	}

	public void setListingType(ListingType listingType) {
		this.listingType = listingType;
	}
}

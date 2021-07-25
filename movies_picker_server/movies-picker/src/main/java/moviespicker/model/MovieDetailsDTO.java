package moviespicker.model;

import java.io.Serializable;
import java.util.List;
import java.util.Objects;

public class MovieDetailsDTO implements Serializable {
    private long id;
    private Language language;
    private Location location;
    private String plot;
    private String poster;
    private List<String> soundEffects;
    private List<String> stills;
    private String title;
    private String imdbID;
    private Double imdbRating;
    private ListingType listingType;

    public MovieDetailsDTO(long id, Language language, Location location,
                           String plot, String poster, List<String> soundEffects,
                           List<String> stills, String title, String imdbID,
                           Double imdbRating, ListingType listingType) {
        this.id = id;
        this.language = language;
        this.location = location;
        this.plot = plot;
        this.poster = poster;
        this.soundEffects = soundEffects;
        this.stills = stills;
        this.title = title;
        this.imdbID = imdbID;
        this.imdbRating = imdbRating;
        this.listingType = listingType;
    }

    public long getId() {
        return id;
    }

    public Language getLanguage() {
        return language;
    }

    public Location getLocation() {
        return location;
    }

    public String getPlot() {
        return plot;
    }

    public String getPoster() {
        return poster;
    }

    public List<String> getSoundEffects() {
        return soundEffects;
    }

    public List<String> getStills() {
        return stills;
    }

    public String getTitle() {
        return title;
    }

    public String getImdbID() {
        return imdbID;
    }

    public Double getImdbRating() {
        return imdbRating;
    }

    public ListingType getListingType() {
        return listingType;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        MovieDetailsDTO that = (MovieDetailsDTO) o;
        return id == that.id;
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }

    @Override
    public String toString() {
        return "MovieDetailsDTO{" +
                "id=" + id +
                ", language=" + language +
                ", location=" + location +
                ", plot='" + plot + '\'' +
                ", poster='" + poster + '\'' +
                ", soundEffects=" + soundEffects +
                ", stills=" + stills +
                ", title='" + title + '\'' +
                ", imdbID='" + imdbID + '\'' +
                ", imdbRating=" + imdbRating +
                ", listingType=" + listingType +
                '}';
    }
}

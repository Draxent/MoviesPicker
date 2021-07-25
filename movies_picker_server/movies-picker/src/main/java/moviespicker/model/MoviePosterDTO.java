package moviespicker.model;

import java.io.Serializable;
import java.util.Objects;

public class MoviePosterDTO implements Serializable {
    private long id;
    private String poster;
    private ListingType listingType;

    public MoviePosterDTO(long id, String poster, ListingType listingType) {
        this.id = id;
        this.poster = poster;
        this.listingType = listingType;
    }

    public long getId() {
        return id;
    }

    public String getPoster() {
        return poster;
    }

    public ListingType getListingType() {
        return listingType;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        MoviePosterDTO that = (MoviePosterDTO) o;
        return id == that.id;
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }

    @Override
    public String toString() {
        return "MoviePosterDTO{" +
                "id=" + id +
                ", poster='" + poster + '\'' +
                ", listingType=" + listingType +
                '}';
    }
}
